part of 'getproduct_bloc.dart';

@immutable
sealed class GetproductState {}

final class GetproductInitial extends GetproductState {}
class ProductsLoading extends GetproductState {}

class ProductsLoaded extends GetproductState {
  final List<Product> products;

 ProductsLoaded(this.products);
}

class ProductsLoadFailure extends GetproductState {
  final String error;

  ProductsLoadFailure(this.error);
}
