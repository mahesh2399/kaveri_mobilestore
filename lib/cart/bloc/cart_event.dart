part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class TriggerCartEventEvent extends CartEvent {
  TriggerCartEventEvent();
}

class AddtoCartPageEvent extends CartEvent {
  final ProductsForCart product;
  AddtoCartPageEvent(this.product);
}

class RemoveFromCartEvent extends CartEvent {
  final Product removeProduct;
  RemoveFromCartEvent(this.removeProduct);
}

class CartSearchUserEvent extends CartEvent {
  final String searchQuery;

  CartSearchUserEvent({required this.searchQuery});
}

class CartCreateNewUserEvent extends CartEvent {
  final String uerName;
  final String mobileNumber;
  final String emailId;
  final String address;

  CartCreateNewUserEvent({required this.uerName, required this.mobileNumber, required this.emailId, required this.address});
}
