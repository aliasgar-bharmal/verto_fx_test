import 'package:test_verto/presentation/product/domain/product_model.dart';
import 'package:test_verto/presentation/product/domain/products_demo_data.dart';

class ProductsRepo {
  Future<List<Product>> fetchProducts(int page, int limit) async {
    int start = page * limit;
    int end = start + limit;
    int length = productData.length;
    await Future.delayed(const Duration(seconds: 2));

    if (start >= length) {
      throw Exception('No more data');
    }

    List<Map<String, dynamic>> products = productData.sublist(
      start,
      end > length ? length : end,
    );

    return productFromJson(products);
  }
}
