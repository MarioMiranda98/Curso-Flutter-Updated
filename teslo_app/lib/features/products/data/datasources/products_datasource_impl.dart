import 'package:dio/dio.dart';

import 'package:teslo_app/config/constants/environment.dart';
import 'package:teslo_app/features/products/data/mappers/product_mapper.dart';
import 'package:teslo_app/features/products/domain/domain.dart';

class ProductsDatasourceImpl extends ProductsDatasource {
  ProductsDatasourceImpl({required this.accessToken})
    : dio = Dio(
        BaseOptions(
          baseUrl: Environment.apiUrl,
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );

  late final Dio dio;
  final String accessToken;

  @override
  Future<ProductEntity> createUpdateProduct(Map<String, dynamic> productLike) {
    // TODO: implement createUpdateProduct
    throw UnimplementedError();
  }

  @override
  Future<ProductEntity> getProductById(String id) {
    // TODO: implement getProductById
    throw UnimplementedError();
  }

  @override
  Future<List<ProductEntity>> getProductsByPage({
    int limit = 10,
    int offset = 0,
  }) async {
    final response = await dio.get('/products?limit=$limit&offset=$offset');
    final List<ProductEntity> products = [];

    for (final product in response.data) {
      products.add(ProductMapper.jsonToEntity(product));
    }

    return products;
  }
}
