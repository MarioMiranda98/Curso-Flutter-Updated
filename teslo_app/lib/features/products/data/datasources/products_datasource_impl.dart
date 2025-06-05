import 'package:dio/dio.dart';

import 'package:teslo_app/config/constants/environment.dart';
import 'package:teslo_app/features/products/data/errors/product_error.dart';
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
  Future<ProductEntity> getProductById(String id) async {
    try {
      final response = await dio.get('/products/$id');
      final product = ProductMapper.jsonToEntity(response.data);

      return product;
    } on DioException catch (e) {
      if (e.response!.statusCode == 404) throw ProductNotFound();

      throw Exception();
    } catch (e) {
      throw Exception();
    }
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
