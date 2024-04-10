import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:kaveri/category/category_service/categoryservice.dart';
import 'package:kaveri/category/model/cateogyr_product_model.dart';
import 'package:kaveri/screens/selectedCategory/model/selectedCategoryModel.dart';

part 'get_category_event.dart';
part 'get_category_state.dart';

class GetCategoryBloc extends Bloc<GetCategoryEvent, GetCategoryState> {
  final CategoryService categoryService;

  GetCategoryBloc(this.categoryService) : super(GetCategoryInitial()) {
    on<FetchCategoryEvent>((event, emit) async {
      emit(GetCategoryLoading());
      try {
        final List<Category> categories =
            await categoryService.fetchCategories();
        emit(GetCategoryLoaded(categories));
      } catch (e) {
        emit(GetCategoryLoadFailure('Failed to fetch categories: $e'));
      }
    });
    on<GetCategoryFetchProductsEvent>(_getCategoryFetchProductsEvent);
  }

  FutureOr<void> _getCategoryFetchProductsEvent(
      GetCategoryFetchProductsEvent event,
      Emitter<GetCategoryState> emit) async {
    try {
      emit(GetCategoryProductsLoadingState());
      List<CategoryProduct> productsList = await CategoryService()
          .fetchProductsBasedOnCategories(categoryId: event.categoryId);
      emit(GetCategoryProductsLoadedState(categoryProductList: productsList));
    } catch (e) {
      emit(GetCategoryLoadFailure(e.toString()));
    }
  }
}
