import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:kaveri/cart/data/cart_utils_service.dart';
import 'package:kaveri/common/header.dart';
import 'package:kaveri/products/product_model/product_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartEvent>(_cartEvent);
    on<AddtoCartPageEvent>(_addtoCartPageEvent);
    on<RemoveFromCartEvent>(_removeFromCartEvent);
    on<CartSearchUserEvent>(_cartSearchUserEvent);
    on<CartCreateNewUserEvent>(_cartCreateNewUserEvent);
  }

  FutureOr<void> _cartEvent(CartEvent event, Emitter<CartState> emit) {}
  List<ProductsForCart> productList = [];

  FutureOr<void> _addtoCartPageEvent(
      AddtoCartPageEvent event, Emitter<CartState> emit) async {
    emit(CartLoading(loadingEnum: CartLoadingEnum.data));
    try {
      //  if(state is CartLoaded){ //CartLoaded loadedState = state as CartLoaded;
      productList.add(event.product);
      //functionality for the below data
      emit(CartLoaded(CartModel(
          productsList: [],
          userId: 'userId',
          subTotal: 0,
          tax: 0,
          grandTotal: 0))); //}
    } catch (e) {
      print(e);
    }
  }

  FutureOr<void> _removeFromCartEvent(
      RemoveFromCartEvent event, Emitter<CartState> emit) {}

  FutureOr<void> _cartSearchUserEvent(
      CartSearchUserEvent event, Emitter<CartState> emit) async {
    emit(const CartLoading(loadingEnum: CartLoadingEnum.search));

    EitherData<List<UserDetailModel>> searchService = await getDirectorsData(
      searchQuery: event.searchQuery,
    );
    searchService.fold((l) => emit(CartLoadFailure(l)),
        (r) => emit(CartUserSearchLoadedState(userDataList: r)));
  }

  FutureOr<void> _cartCreateNewUserEvent(
      CartCreateNewUserEvent event, Emitter<CartState> emit) {
    log('message');
    emit(const CartLoading(loadingEnum: CartLoadingEnum.newUser));
    //call api and retrive the user data
    emit(
      CartUserCreatedState(
        userData: UserDetailModel(
          userId: 'userId',
          mobileNumber: event.mobileNumber,
          emailAddress: event.emailId,
          name: event.uerName,
        ),
      ),
    );
  }
}
