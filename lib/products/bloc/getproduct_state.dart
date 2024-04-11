part of 'getproduct_bloc.dart';


sealed class GetproductState {}

final class GetproductInitial extends GetproductState {}
class ProductsLoading extends GetproductState {}

class ProductsLoaded extends GetproductState {
  final List<Product> products;

 ProductsLoaded(this.products);
}

 final class ProductsLoadFailure extends GetproductState {
  final String error;

  ProductsLoadFailure({required this.error});
}
