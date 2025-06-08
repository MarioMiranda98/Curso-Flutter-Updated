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

  Future<String> _uploadFile(String path) async {
    try {
      final fileName = path.split('/').last;
      final FormData data = FormData.fromMap({
        'file': MultipartFile.fromFileSync(path, filename: fileName),
      });

      final response = await dio.post('/files/product', data: data);

      return response.data['image'];
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<String>> _uploadPhotos(List<String> photos) async {
    final photosToUpload = photos
        .where((element) => element.contains('/'))
        .toList();

    final ignoredPhotos = photos.where((e) => !e.contains('/')).toList();

    final List<Future<String>> uploadJob = [];

    for (final ph in photosToUpload) {
      uploadJob.add(_uploadFile(ph));
    }

    final List<String> newImages = await Future.wait(uploadJob);

    return [...ignoredPhotos, ...newImages];
  }

  @override
  Future<ProductEntity> createUpdateProduct(
    Map<String, dynamic> productLike,
  ) async {
    try {
      final String? productId = productLike['id'];
      final String method = productId == null ? 'POST' : 'PATCH';
      final String url = productId == null ? '/post' : '/products/$productId';

      productLike.remove('id');
      productLike['images'] = await _uploadPhotos(productLike['images']);

      final response = await dio.request(
        url,
        data: productLike,
        options: Options(method: method),
      );

      final product = ProductMapper.jsonToEntity(response.data);

      return product;
    } catch (e) {
      throw Exception();
    }
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
