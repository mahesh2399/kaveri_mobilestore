part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();
  
  @override
  List<Object> get props => [];
}



final class CartInitial extends CartState {}



class CartLoading extends CartState {}

class CartLoaded extends CartState {
 
  const CartLoaded();
}

class CartLoadFailure extends CartState {
  final String error;

  const CartLoadFailure(this.error);
}
