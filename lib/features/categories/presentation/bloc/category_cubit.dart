import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';
import 'package:spend_analytics/features/categories/domain/entities/category_entity.dart';
import 'package:spend_analytics/features/categories/domain/usecases/add_category_use_case.dart';
import 'package:spend_analytics/features/categories/domain/usecases/get_categories_use_case.dart';
import 'package:spend_analytics/features/categories/domain/usecases/reorder_categories_use_case.dart';
import 'package:spend_analytics/features/categories/domain/usecases/sync_categories_use_case.dart';

import 'category_state.dart';

@injectable
class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit(
    this._getCategories,
    this._addCategory,
    this._reorder,
    this._sync,
  ) : super(const CategoryState());

  static const _uuid = Uuid();

  final GetCategoriesUseCase _getCategories;
  final AddCategoryUseCase _addCategory;
  final ReorderCategoriesUseCase _reorder;
  final SyncCategoriesUseCase _sync;

  Future<void> load(String userId) async {
    emit(state.copyWith(isLoading: true));
    await _sync(userId);
    final result = await _getCategories(userId);
    result.fold(
      (_) => emit(state.copyWith(isLoading: false)),
      (all) => emit(state.copyWith(
        isLoading: false,
        expense: _filter(all, 'expense'),
        income: _filter(all, 'income'),
        transfer: _filter(all, 'transfer'),
      )),
    );
  }

  Future<bool> addCategory(
    String userId, {
    required String name,
    required String type,
  }) async {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return false;
    final existing = _listForType(type);
    if (existing.any((c) => c.name.toLowerCase() == trimmed.toLowerCase())) {
      return false;
    }
    final now = DateTime.now().toUtc();
    final entity = CategoryEntity(
      id: _uuid.v4(),
      userId: userId,
      name: trimmed,
      type: type,
      sortOrder: existing.length,
      createdAt: now,
      updatedAt: now,
    );
    final result = await _addCategory(entity);
    return result.fold((_) => false, (_) {
      load(userId);
      return true;
    });
  }

  Future<void> reorder(
    String userId, {
    required String type,
    required int oldIndex,
    required int newIndex,
  }) async {
    final list = List<CategoryEntity>.from(_listForType(type));
    final adjusted = newIndex > oldIndex ? newIndex - 1 : newIndex;
    final item = list.removeAt(oldIndex);
    list.insert(adjusted, item);

    // Update sortOrder fields before optimistic emit and persistence
    final now = DateTime.now().toUtc();
    final reordered = list
        .asMap()
        .entries
        .map((e) => e.value.copyWith(sortOrder: e.key, updatedAt: now))
        .toList();

    _emitReordered(type, reordered);
    await _reorder(reordered);
  }

  List<CategoryEntity> categoriesForType(String type) => _listForType(type);

  List<CategoryEntity> _listForType(String type) => switch (type) {
        'income' => state.income,
        'transfer' => state.transfer,
        _ => state.expense,
      };

  List<CategoryEntity> _filter(List<CategoryEntity> all, String type) =>
      all.where((c) => c.type == type).toList()
        ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));

  void _emitReordered(String type, List<CategoryEntity> list) {
    emit(switch (type) {
      'income' => state.copyWith(income: list),
      'transfer' => state.copyWith(transfer: list),
      _ => state.copyWith(expense: list),
    });
  }
}
