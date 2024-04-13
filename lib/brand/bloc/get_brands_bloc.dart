

import 'package:bloc/bloc.dart';
import 'package:kaveri/brand/brand)_model/brand_model.dart';
import 'package:kaveri/brand/brand_servive/brandservice.dart';
// import 'package:kaveri/products/product_model/product_model.dart';
import 'package:meta/meta.dart';

part 'get_brands_event.dart';
part 'get_brands_state.dart';

class GetBrandsBloc extends Bloc<GetBrandsEvent, GetBrandsState> {
  final BrandService brandService;

  GetBrandsBloc(this.brandService) : super(GetBrandsInitial()) {
    on<FetchBrandsEvent>((event, emit)async {
      // mapEventToState(event);

      emit(BrandsLoading());
      try {
        final List<Brand> brands = await brandService.fetchBrands();
       emit(BrandsLoaded(brands));
      } catch (e) {

         emit(BrandsLoadFailure('Failed to fetch brands: $e'));
        
      }
    });
  }

}
