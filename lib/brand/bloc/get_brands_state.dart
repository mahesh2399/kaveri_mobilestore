part of 'get_brands_bloc.dart';


@immutable
abstract class GetBrandsState {}

class GetBrandsInitial extends GetBrandsState {}

class BrandsLoading extends GetBrandsState {}

class BrandsLoaded extends GetBrandsState {
  final List<Brand> brands;

  BrandsLoaded(this.brands);
}

class BrandsLoadFailure extends GetBrandsState {
  final String error;

  BrandsLoadFailure(this.error);
}





// .....


// class BrandsGetByIdState extends GetBrandsState {
//   final List<Product> selectedbrandproducts;

//   BrandsGetByIdState(this.selectedbrandproducts);
// }

