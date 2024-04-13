import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
           
        emit(GetCategoryLoaded(category: categories));
        
        
      } catch (e) {
        emit(GetCategoryLoadFailure('Failed to fetch categories: $e'));
      }
    });

    on<GetProductsEvent>((event, emit)async {
      // TODO: implement event handler
      emit(GetCategoryProductsLoadingState());

 final productsList = await ProductService()
          .fetchProducts();
          emit(GetCategoryLoaded2State(categoryProductList: productsList));

    });
    on<GetCategoryFetchProductsEvent>((event,emit)async{
      emit(GetCategoryProductsLoadingState());

       try {
      final productsList = await CategoryService()
          .fetchProductsBasedOnCategories(categoryId: event.categoryId);
          
      emit(GetCategorybyIdState(categoryProductList: productsList));
      //  final List<Category> categories =
      //       await categoryService.fetchCategories();
      //       final productsList2 = await ProductService()
      //     .fetchProducts();
      //   emit(GetCategoryLoaded(category: categories,categoryProductList: productsList2));
    } catch (e) {
      emit(GetCategoryLoadFailure(e.toString()));
    }
    });
  }


}
