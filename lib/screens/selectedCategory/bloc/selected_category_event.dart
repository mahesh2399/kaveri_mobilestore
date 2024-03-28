import 'package:flutter/material.dart';

@immutable
sealed class SelectedCategoryEvent {}

class FetchSelectedCategoryEvent extends SelectedCategoryEvent {
  final String categoryId;
  FetchSelectedCategoryEvent(this.categoryId);
}
