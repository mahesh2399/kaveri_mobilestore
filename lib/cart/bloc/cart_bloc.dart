import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:kaveri/products/product_model/product_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<AddtoCartPageEvent>((event, emit) async{
    emit(CartLoading());
    try {
     if(state is CartLoaded){ CartLoaded loadedState = state as CartLoaded;
      List<Product> productList=List.from(loadedState.productList);
      productList.add(event.product);
      emit(CartLoaded(productList));}
       
    } catch (e) {
      print(e); 
    }
      
    

    });
      on<RemoveFromCartEvent>((event, emit) {
        // TODO: implement event handler
      });
  }
  
}
