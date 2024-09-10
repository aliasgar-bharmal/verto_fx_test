import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_verto/presentation/product/domain/product_model.dart';
import 'package:test_verto/presentation/product/domain/products_repo.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsRepo _productsRepo = ProductsRepo();
  int page = 0;
  int limit = 10;
  bool hasMore = true;
  List<Product> data = [];
  ProductsBloc() : super(ProductsInitial()) {
    on<ProductsLoadDataEvent>(_fetchProducts);
  }

  Future<void> _fetchProducts(
      ProductsLoadDataEvent event, Emitter<ProductsState> emit) async {
    try {
      if (hasMore == false || state is ProductsLoadingMore) {
        return;
      }
      if (page > 0) {
        emit(ProductsLoadingMore(products: data));
      } else {
        emit(ProductsLoading());
      }
      List<Product> posts = await _productsRepo.fetchProducts(page, limit);
      data.addAll(posts);
      page++;
      emit(ProductsSuccess(products: data));
    } catch (e) {
      if (e.toString() == "Exception: No more data") {
        hasMore = false;
        emit(ProductsSuccess(products: data));
      } else {
        emit(ProductsError(error: e.toString()));
      }
    }
  }
}
