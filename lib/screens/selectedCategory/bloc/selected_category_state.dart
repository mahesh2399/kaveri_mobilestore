part of 'selected_category_bloc.dart';

// sealed class SelectedCategoryState extends Equatable {
//   const SelectedCategoryState();
  
//   @override
//   List<Object> get props => [];
// }

// final class SelectedCategoryInitial extends SelectedCategoryState {}


@immutable
sealed class SelectedCategoryState {}

final class SelectedCategoryInitial extends SelectedCategoryState {}
class SelectedCategoryLoading extends SelectedCategoryState {}

class SelectedCategoryLoaded extends SelectedCategoryState {
  final List<Category> category;

 SelectedCategoryLoaded(this.category);
}

class SelectedCategoryLoadFailure extends SelectedCategoryState {
  final String error;

  SelectedCategoryLoadFailure(this.error);
}
