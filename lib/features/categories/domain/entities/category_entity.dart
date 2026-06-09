import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_entity.freezed.dart';

@freezed
abstract class CategoryEntity with _$CategoryEntity {
  const factory CategoryEntity({
    required String id,
    required String userId,
    required String name,
    required String type,
    required int sortOrder,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _CategoryEntity;
}
