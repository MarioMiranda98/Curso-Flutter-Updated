import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:teslo_app/features/products/data/data.dart';

import 'package:teslo_app/features/products/domain/repositories/product_repository.dart';

final productsRepositoryProvider = Provider<ProductsRepository>((ref) {
  final accessToken = ref.watch(authProvider).user?.token ?? '';

  final productsRepositoryImpl = ProductsRepositoryImpl(
    datasource: ProductsDatasourceImpl(accessToken: accessToken),
  );

  return productsRepositoryImpl;
});
