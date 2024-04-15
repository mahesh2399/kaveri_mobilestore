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
    on<CartPlusQuantityEvent>(_cartPlusQuantityEvent);
    on<CartMinusQuantityEvent>(_cartMinusQuantityEvent);
    on<CartAddShipingChargesEvent>(_cartAddShipingChargesEvent);
    on<CartAddDiscountEvent>(_cartAddDiscountEvent);
  }

  FutureOr<void> _cartEvent(CartEvent event, Emitter<CartState> emit) {}
  List<ProductsForCart> productList = [];
  int subTotal = 0;
  int tax = 0;
  double grandTotal = 0;
  FutureOr<void> _addtoCartPageEvent(
      AddtoCartPageEvent event, Emitter<CartState> emit) async {
    emit(const CartLoading(loadingEnum: CartLoadingEnum.data));
    try {
      productList.add(event.product);
      subTotal = 0;
      for (ProductsForCart product in productList) {
        subTotal = subTotal + product.price;
      }
      emit(
        CartLoaded(
          CartModel(
            productsList: productList,
            subTotal: subTotal,
            tax: tax,
            grandTotal: (subTotal + tax).toDouble(),
          ),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  FutureOr<void> _removeFromCartEvent(
      RemoveFromCartEvent event, Emitter<CartState> emit) {
    emit(const CartLoading(loadingEnum: CartLoadingEnum.data));
    productList.remove(event.removeProduct);
    subTotal = 0;

    for (ProductsForCart product in productList) {
      subTotal = subTotal + product.price;
    }
    emit(
      CartLoaded(
        CartModel(
          productsList: productList,
          subTotal: subTotal,
          tax: tax,
          grandTotal: (subTotal + tax).toDouble(),
        ),
      ),
    );
  }

  FutureOr<void> _cartSearchUserEvent(
      CartSearchUserEvent event, Emitter<CartState> emit) async {
    emit(
      const CartLoading(loadingEnum: CartLoadingEnum.search),
    );

    EitherData<List<UserDetailModel>> searchService = await getDirectorsData(
      searchQuery: event.searchQuery,
    );
    searchService.fold(
      (l) => emit(
        CartLoadFailure(l),
      ),
      (r) => emit(
        CartUserSearchLoadedState(userDataList: r),
      ),
    );
  }

  FutureOr<void> _cartCreateNewUserEvent(
      CartCreateNewUserEvent event, Emitter<CartState> emit) async {
    log('message');
    emit(const CartLoading(loadingEnum: CartLoadingEnum.newUser));
    //call api and retrive the user data
    final bool isDone = await createNewCustomer(
        name: event.uerName,
        email: event.emailId,
        number: event.mobileNumber,
        address: event.address);
    if (isDone) {
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
    } else {}
  }

  FutureOr<void> _cartPlusQuantityEvent(
      CartPlusQuantityEvent event, Emitter<CartState> emit) {
    emit(const CartLoading(loadingEnum: CartLoadingEnum.data));
    productList[event.index].wantedQuantity =
        productList[event.index].wantedQuantity + 1;
    // productList[event.index].price = productList[event.index].wantedQuantity *
    //     productList[event.index]
    //         .price; //TODO hear when multipled the nwhen comes again multipled again leads to wrong output
    productList[event.index] = productList[event.index];
    subTotal = 0;
    for (ProductsForCart product in productList) {
      subTotal = subTotal + (product.price * product.wantedQuantity);
    }
    emit(
      CartLoaded(
        CartModel(
          productsList: productList,
          subTotal: subTotal,
          tax: tax,
          grandTotal: (subTotal + tax).toDouble(),
        ),
      ),
    );
  }

  FutureOr<void> _cartMinusQuantityEvent(
      CartMinusQuantityEvent event, Emitter<CartState> emit) {
    emit(const CartLoading(loadingEnum: CartLoadingEnum.data));

    if (productList[event.index].wantedQuantity != 1) {
      productList[event.index].wantedQuantity =
          productList[event.index].wantedQuantity - 1;
    }
    // productList[event.index].price = productList[event.index].wantedQuantity *
    //     productList[event.index]
    //         .price; //TODO hear when multipled the nwhen comes again multipled again leads to wrong output
    productList[event.index] = productList[event.index];
    subTotal = 0;
    for (ProductsForCart product in productList) {
      subTotal = subTotal + (product.price * product.wantedQuantity);
    }
    emit(
      CartLoaded(
        CartModel(
          productsList: productList,
          subTotal: subTotal,
          tax: tax,
          grandTotal: (subTotal + tax).toDouble(),
        ),
      ),
    );
  }

  FutureOr<void> _cartAddShipingChargesEvent(
      CartAddShipingChargesEvent event, Emitter<CartState> emit) {
    emit(CartInitial());
    double shipingCharge = 0;
    if (event.shipingCharge.trim() != '') {
      shipingCharge = double.parse(event.shipingCharge);
    }
    grandTotal = subTotal + tax + shipingCharge;
    emit(
      CartLoaded(
        CartModel(
          productsList: productList,
          subTotal: subTotal,
          tax: tax,
          grandTotal: grandTotal,
        ),
      ),
    );
  }

  FutureOr<void> _cartAddDiscountEvent(
      CartAddDiscountEvent event, Emitter<CartState> emit) {
    emit(CartInitial());
//TODO calculation for discount
    emit(
      CartLoaded(
        CartModel(
          productsList: productList,
          subTotal: subTotal,
          tax: tax,
          grandTotal: grandTotal,
        ),
      ),
    );
  }
}

double calculateDiscountedTotal(double totalAmount, double discountPercentage) {
  // Convert the discount percentage to a decimal
  double discountPercentageDecimal = discountPercentage / 100;

  // Calculate the discount
  double discount = totalAmount * discountPercentageDecimal;

  // Subtract the discount from the total amount
  double discountedTotal = totalAmount - discount;

  return discountedTotal;
}
