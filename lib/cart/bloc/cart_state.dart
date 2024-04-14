part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {}

enum CartLoadingEnum {
  search,
  newUser,
  data,
}

class CartLoading extends CartState {
  final CartLoadingEnum loadingEnum;

  const CartLoading({required this.loadingEnum});
}

class CartLoaded extends CartState {
  final CartModel cartData;

  const CartLoaded(this.cartData);
}

class CartLoadFailure extends CartState {
  final String error;

  const CartLoadFailure(this.error);
}

class CartUserSearchLoadedState extends CartState {
  final List<UserDetailModel> userDataList;

  const CartUserSearchLoadedState({required this.userDataList});
}

class CartUserCreatedState extends CartState {
  final UserDetailModel userData;

  const CartUserCreatedState({required this.userData});
}
