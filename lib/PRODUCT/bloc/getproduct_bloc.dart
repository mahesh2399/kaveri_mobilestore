

import 'package:bloc/bloc.dart';
import 'package:kaveri/PRODUCT/prduct_servide/productservice.dart';
import 'package:kaveri/PRODUCT/product_model/product_model.dart';

import 'package:meta/meta.dart';

part 'getproduct_event.dart';
part 'getproduct_state.dart';

class GetproductBloc extends Bloc<GetproductEvent, GetproductState> {


   final ProductService productService;

  GetproductBloc(this.productService) : super(GetproductInitial()) {
    on<GetproductEvent>((event, emit) async{

 emit(ProductsLoading());


   try {
        final List<Product> products = await productService.fetchProducts();
   
       emit(ProductsLoaded(products));
      } catch (e) {

         emit(ProductsLoadFailure('Failed to fetch brands: $e'));
        
      }



    });
  }
}
