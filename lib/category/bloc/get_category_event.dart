part of 'get_category_bloc.dart';

@immutable
sealed class GetCategoryEvent {}

class FetchCategoryEvent extends GetCategoryEvent {
  FetchCategoryEvent();
}

class GetCategoryFetchProductsEvent extends GetCategoryEvent {
 

  GetCategoryFetchProductsEvent();
}
