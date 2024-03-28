part of 'get_brands_bloc.dart';

@immutable
abstract class GetBrandsEvent {}

class FetchBrandsEvent extends GetBrandsEvent {
  FetchBrandsEvent();
}
