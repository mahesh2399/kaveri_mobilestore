part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class TriggerCartEventEvent extends CartEvent {
  
  TriggerCartEventEvent();
}