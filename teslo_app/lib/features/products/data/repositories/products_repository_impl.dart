import 'package:teslo_app/features/products/domain/domain.dart';

class ProductsRepositoryImpl extends ProductsRepository {
  ProductsRepositoryImpl({required this.datasource});

  final ProductsDatasource datasource;

  @override
  Future<ProductEntity> createUpdateProduct(
    Map<String, dynamic> productLike,
  ) async {
    return await datasource.createUpdateProduct(productLike);
  }

  @override
  Future<ProductEntity> getProductById(String id) async {
    return await datasource.getProductById(id);
  }

  @override
  Future<List<ProductEntity>> getProductsByPage({
    int limit = 10,
    int offset = 0,
  }) async {
    return await datasource.getProductsByPage(limit: limit, offset: offset);
  }
}
