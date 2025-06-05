import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_app/features/products/domain/domain.dart';
import 'package:teslo_app/features/products/presentation/providers/providers.dart';

final productProvider = StateNotifierProvider.autoDispose
    .family<ProductNotifier, ProductState, String>((ref, productId) {
      final productsRepository = ref.watch(productsRepositoryProvider);

      return ProductNotifier(
        productId: productId,
        productsRepository: productsRepository,
      );
    });

class ProductNotifier extends StateNotifier<ProductState> {
  ProductNotifier({required this.productId, required this.productsRepository})
    : super(ProductState(id: productId)) {
    loadProduct();
  }

  final String productId;
  final ProductsRepository productsRepository;

  Future<void> loadProduct() async {
    try {
      state = state.copyWith(isLoading: true);

      final product = await productsRepository.getProductById(state.id);

      state = state.copyWith(isLoading: false, product: product);
    } catch (e) {
      print(e);
    }
  }
}

class ProductState {
  const ProductState({
    this.product,
    required this.id,
    this.isLoading = true,
    this.isSaving = false,
  });

  final String id;
  final ProductEntity? product;
  final bool isLoading;
  final bool isSaving;

  ProductState copyWith({
    String? id,
    ProductEntity? product,
    bool? isLoading,
    bool? isSaving,
  }) => ProductState(
    id: id ?? this.id,
    product: product ?? this.product,
    isLoading: isLoading ?? this.isLoading,
    isSaving: isSaving ?? this.isSaving,
  );
}
