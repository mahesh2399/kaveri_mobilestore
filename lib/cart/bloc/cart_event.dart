part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class TriggerCartEventEvent extends CartEvent {
  
  TriggerCartEventEvent();
}
class AddtoCartPageEvent extends CartEvent{
  final Product product;
   AddtoCartPageEvent(this.product);
}
class RemoveFromCartEvent extends  CartEvent{
  final Product removeProduct;
  RemoveFromCartEvent(this.removeProduct);
}