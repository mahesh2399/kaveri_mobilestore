part of 'getproduct_bloc.dart';

sealed class GetproductEvent {}
class FetchProductsEvent extends GetproductEvent {
}
class FetchProductSelectEvent extends GetproductEvent {
  final dynamic brandId;
  FetchProductSelectEvent({required this.brandId});
}