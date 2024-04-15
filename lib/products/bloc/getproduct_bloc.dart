import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:kaveri/brand/brand_servive/brandservice.dart';
import 'package:kaveri/products/prduct_servide/productservice.dart';
import 'package:kaveri/products/product_model/product_model.dart';
part 'getproduct_event.dart';
part 'getproduct_state.dart';

class GetproductBloc extends Bloc<GetproductEvent, GetproductState> {
  final ProductService productService;
  final BrandService brandService;

  GetproductBloc(this.productService, this.brandService)
      : super(GetproductInitial()) {
    on<GetproductEvent>((event, emit) async {
      emit(ProductsLoading());

      try {
        final List<Product> products = await productService.fetchProducts();

        emit(ProductsLoaded(products));
      } catch (e) {
        emit(ProductsLoadFailure(error: 'Failed to fetch brands: $e'));
      }
    });

    on<FetchProductSelectEvent>((event, emit) async {
      emit(ProductsLoading());
      log('${event.brandId}good id');
      try {
        final result = await brandService.fetchProductByBrand(event.brandId);
        emit(ProductSelectBrandState(productsData: result));
      } catch (e) {
        print(e);
        emit(ProductsLoadFailure(error: e.toString()));
      }
      // TODO: implement event handler
    });

    on<FetchProductsEvent>(_fetchProductsEvent);
  }

  FutureOr<void> _fetchProductsEvent(
      FetchProductsEvent event, Emitter<GetproductState> emit) async {
    emit(ProductsLoading());
    try {
      List<Product> result = await ProductService().fetchProducts();
      emit(ProductsLoaded(result));
    } catch (e) {
      emit(ProductsLoadFailure(error: e.toString()));
    }
    // TODO: implement event handler
  }
}
