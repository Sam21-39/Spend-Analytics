import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spend_analytics/features/categories/domain/entities/category_entity.dart';

part 'category_state.freezed.dart';

@freezed
abstract class CategoryState with _$CategoryState {
  const factory CategoryState({
    @Default([]) List<CategoryEntity> expense,
    @Default([]) List<CategoryEntity> income,
    @Default([]) List<CategoryEntity> transfer,
    @Default(false) bool isLoading,
  }) = _CategoryState;
}
