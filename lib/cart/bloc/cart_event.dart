// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  final ProductsForCart removeProduct;
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

  CartCreateNewUserEvent(
      {required this.uerName,
      required this.mobileNumber,
      required this.emailId,
      required this.address});
}

class CartPlusQuantityEvent extends CartEvent {
  final ProductsForCart addProduct;
final int index;

  CartPlusQuantityEvent({
    required this.addProduct,
    required this.index,
  });
}

class CartMinusQuantityEvent extends CartEvent {
  final ProductsForCart addProduct;
final int index;
  CartMinusQuantityEvent({
    required this.addProduct,
    required this.index,
  });
}
