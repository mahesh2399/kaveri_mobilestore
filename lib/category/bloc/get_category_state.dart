part of 'get_category_bloc.dart';

sealed class GetCategoryState extends Equatable {
  const GetCategoryState();

  @override
  List<Object> get props => [];
}

final class GetCategoryInitial extends GetCategoryState {}

class GetCategoryLoading extends GetCategoryState {}

class GetCategoryLoaded extends GetCategoryState {
  final List<Category> category;
 

  const GetCategoryLoaded({required this.category,});
  //   @override
  // List<Object> get props => [category , categoryProductList];
}
class GetCategoryLoaded2State extends GetCategoryState {
  final   List<Product> categoryProductList;

  const GetCategoryLoaded2State({required this.categoryProductList});
  //   @override
  // List<Object> get props => [category , categoryProductList];
}

class GetCategoryLoadFailure extends GetCategoryState {
  final String error;

  const GetCategoryLoadFailure(this.error);
}

class GetCategoryProductsLoadingState extends GetCategoryState {}


class GetCategorybyIdState extends GetCategoryState{
  final List<Product> categoryProductList;
  const GetCategorybyIdState({required this.categoryProductList});
}
