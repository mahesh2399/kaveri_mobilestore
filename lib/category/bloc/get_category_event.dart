part of 'get_category_bloc.dart';

@immutable
sealed class GetCategoryEvent {}

class FetchCategoryEvent extends GetCategoryEvent {
  FetchCategoryEvent();
}

class GetProductsEvent extends GetCategoryEvent {
 final BuildContext context;

  GetProductsEvent(this.context);
}

class GetCategoryFetchProductsEvent extends GetCategoryEvent {
 final dynamic categoryId;

  GetCategoryFetchProductsEvent(this.categoryId);
}
