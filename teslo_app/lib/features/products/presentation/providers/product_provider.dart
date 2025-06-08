import 'package:flutter/material.dart';
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

  ProductEntity newEmptyProduct() {
    return ProductEntity(
      id: 'new',
      title: '',
      price: 0,
      description: '',
      slug: '',
      stock: 0,
      sizes: [],
      gender: 'men',
      tags: [],
      images: [],
      user: null,
    );
  }

  Future<void> loadProduct() async {
    try {
      if (state.id == 'new') {
        state = state.copyWith(isLoading: false, product: newEmptyProduct());
        return;
      }

      final product = await productsRepository.getProductById(state.id);

      state = state.copyWith(isLoading: false, product: product);
    } catch (e) {
      debugPrint(e.toString());
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
