import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:kaveri/category/category_service/categoryservice.dart';
import 'package:kaveri/category/model/cateogyr_product_model.dart';
import 'package:kaveri/products/prduct_servide/productservice.dart';
import 'package:kaveri/products/product_model/product_model.dart';
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
            final productsList = await ProductService()
          .fetchProducts();
        emit(GetCategoryLoaded(category: categories,categoryProductList: productsList));
      } catch (e) {
        emit(GetCategoryLoadFailure('Failed to fetch categories: $e'));
      }
    });
    // on<GetCategoryFetchProductsEvent>((event,emit)async{

    //    try {
    //   emit(GetCategoryProductsLoadingState());
    //   final productsList = await ProductService()
    //       .fetchProducts();
    //   emit(GetCategoryProductsLoadedState(categoryProductList: productsList));
    // } catch (e) {
    //   emit(GetCategoryLoadFailure(e.toString()));
    // }
    // });
  }

  FutureOr<dynamic> _getCategoryFetchProductsEvent(
      GetCategoryFetchProductsEvent event,
      Emitter<GetCategoryState> emit) async {
   
  }
}
