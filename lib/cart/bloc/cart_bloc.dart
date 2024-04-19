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
  double discount = 0;
  String? discountType;
  double shipmentCharges = 0;
  FutureOr<void> _addtoCartPageEvent(
      AddtoCartPageEvent event, Emitter<CartState> emit) async {
    emit(const CartLoading(loadingEnum: CartLoadingEnum.data));
    try {
      productList.add(event.product);
      subTotal = 0;
      for (ProductsForCart product in productList) {
        subTotal = subTotal + product.price;
      }
      if (discountType == 'Fixed') {
        log('stupid');
        // double count = (subTotal + tax) - double.parse(event.discountPrice);
        grandTotal = (subTotal + tax + shipmentCharges) - discount;
      } else if (discountType == 'Percent %') {
        grandTotal = calculateDiscountedTotal(
            (subTotal.toDouble() + tax.toDouble() + shipmentCharges), discount);
      } else {
        grandTotal = (subTotal + tax + shipmentCharges);
      }
      emit(
        CartLoaded(
          CartModel(
              discountType: discountType,
              shipmentCharges: shipmentCharges,
              productsList: productList,
              subTotal: subTotal,
              tax: tax,
              grandTotal: grandTotal,
              discount: discount),
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
    if (discountType == 'Fixed') {
      log('stupid');
      // double count = (subTotal + tax) - double.parse(event.discountPrice);
      grandTotal = (subTotal + tax + shipmentCharges) - discount;
    } else if (discountType == 'Percent %') {
      grandTotal = calculateDiscountedTotal(
          (subTotal.toDouble() + tax.toDouble() + shipmentCharges), discount);
    } else {
      grandTotal = (subTotal + tax + shipmentCharges);
    }
    emit(
      CartLoaded(
        CartModel(
            shipmentCharges: shipmentCharges,
            discountType: discountType,
            productsList: productList,
            subTotal: subTotal,
            tax: tax,
            grandTotal: grandTotal,
            discount: discount),
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
    if (discountType == 'Fixed') {
      log('stupid');
      // double count = (subTotal + tax) - double.parse(event.discountPrice);
      grandTotal = (subTotal + tax + shipmentCharges) - discount;
    } else if (discountType == 'Percent %') {
      grandTotal = calculateDiscountedTotal(
          (subTotal.toDouble() + tax.toDouble() + shipmentCharges), discount);
    } else {
      grandTotal = (subTotal + tax + shipmentCharges);
    }
    emit(
      CartLoaded(
        CartModel(
            shipmentCharges: shipmentCharges,
            discountType: discountType,
            productsList: productList,
            subTotal: subTotal,
            tax: tax,
            grandTotal: grandTotal,
            discount: discount),
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
    if (discountType == 'Fixed') {
      log('stupid');
      // double count = (subTotal + tax) - double.parse(event.discountPrice);
      grandTotal = (subTotal + tax + shipmentCharges) - discount;
    } else if (discountType == 'Percent %') {
      grandTotal = calculateDiscountedTotal(
          (subTotal.toDouble() + tax.toDouble() + shipmentCharges), discount);
    } else {
      grandTotal = (subTotal + tax + shipmentCharges);
    }
    emit(
      CartLoaded(
        CartModel(
            shipmentCharges: shipmentCharges,
            discountType: discountType,
            productsList: productList,
            subTotal: subTotal,
            tax: tax,
            grandTotal: grandTotal,
            discount: discount),
      ),
    );
  }

  FutureOr<void> _cartAddShipingChargesEvent(
      CartAddShipingChargesEvent event, Emitter<CartState> emit) {
    emit(CartInitial());
    if (event.shipingCharge.trim() != '') {
      shipmentCharges = double.parse(event.shipingCharge);
    } else {
      shipmentCharges = 0;
    }
    if (discountType == 'Fixed') {
      log('stupid');
      // double count = (subTotal + tax) - double.parse(event.discountPrice);
      grandTotal = (subTotal + tax + shipmentCharges) - discount;
    } else if (discountType == 'Percent %') {
      grandTotal = calculateDiscountedTotal(
          (subTotal.toDouble() + tax.toDouble() + shipmentCharges), discount);
    } else {
      grandTotal = (subTotal + tax + shipmentCharges);
    }
    emit(
      CartLoaded(
        CartModel(
            shipmentCharges: shipmentCharges,
            discountType: discountType,
            productsList: productList,
            subTotal: subTotal,
            tax: tax,
            grandTotal: grandTotal,
            discount: discount),
      ),
    );
  }

  FutureOr<void> _cartAddDiscountEvent(
      CartAddDiscountEvent event, Emitter<CartState> emit) {
    emit(CartInitial());
    if (event.disCountType == 'Fixed') {
      log('stupid');
      // double count = (subTotal + tax) - double.parse(event.discountPrice);
      grandTotal = (subTotal + tax + shipmentCharges) -
          double.parse(event.discountPrice);
    } else if (event.disCountType == 'Percent %') {
      grandTotal = calculateDiscountedTotal(
          (subTotal.toDouble() + tax.toDouble() + shipmentCharges),
          double.parse(event.discountPrice));
    }
    discount = double.parse(event.discountPrice);
    discountType = event.disCountType;
    // double count = double.parse(event.discountPrice) - (subTotal + tax);
    // grandTotal += count;
    // discount =
    //     calculateDiscountedTotal(grandTotal, double.parse(event.discountPrice));
    // double data = (subTotal.toDouble() + tax.toDouble());
    // grandTotal =
    //     calculateDiscountedTotal(data, double.parse(event.discountPrice));
    emit(
      CartLoaded(
        CartModel(
            shipmentCharges: shipmentCharges,
            discountType: discountType,
            productsList: productList,
            subTotal: subTotal,
            tax: tax,
            grandTotal: grandTotal,
            discount: discount),
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
