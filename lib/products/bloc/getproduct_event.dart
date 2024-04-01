part of 'getproduct_bloc.dart';

@immutable
sealed class GetproductEvent {}
class FetchProductsEvent extends GetproductEvent {
  FetchProductsEvent();
}
