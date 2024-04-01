import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:kaveri/screens/selectedCategory/bloc/selected_category_event.dart';
import 'package:kaveri/screens/selectedCategory/model/selectedCategoryModel.dart';
import 'package:kaveri/screens/selectedCategory/model/service/SelectedCategory.service.dart';
part 'selected_category_state.dart';

class SelectedCategoryBloc
    extends Bloc<SelectedCategoryEvent, SelectedCategoryState> {
  final SelectedCategoryService selectedCategoryService;

  SelectedCategoryBloc(this.selectedCategoryService)
      : super(SelectedCategoryInitial()) {
    on<FetchSelectedCategoryEvent>((event, emit) async {
      emit(SelectedCategoryLoading());
      try {
        final List<Category> categories =
            await selectedCategoryService.fetchCategories(event.categoryId);
        emit(SelectedCategoryLoaded(categories));
      } catch (e) {
        emit(SelectedCategoryLoadFailure('Failed to fetch categories: $e'));
      }
    });
  }
}
