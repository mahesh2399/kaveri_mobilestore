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

  const GetCategoryLoaded(this.category);
}

class GetCategoryLoadFailure extends GetCategoryState {
  final String error;

  const GetCategoryLoadFailure(this.error);
}

class GetCategoryProductsLoadingState extends GetCategoryState {}
class GetCategoryProductsLoadedState extends GetCategoryState {
 final   List<CategoryProduct> categoryProductList;

  const GetCategoryProductsLoadedState({required this.categoryProductList});
}
