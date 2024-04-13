part of 'getproduct_bloc.dart';

@immutable
sealed class GetproductEvent {}
class FetchProductsEvent extends GetproductEvent {
  FetchProductsEvent();
}
class FetchProductSelectEvent extends GetproductEvent {
  final dynamic brandId;
  FetchProductSelectEvent({required this.brandId});
}