part of 'get_category_bloc.dart';


@immutable
sealed class GetCategoryEvent {}
class FetchCategoryEvent extends GetCategoryEvent {
  FetchCategoryEvent();
}
