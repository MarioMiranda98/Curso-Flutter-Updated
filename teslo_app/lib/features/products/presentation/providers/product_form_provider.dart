import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:teslo_app/config/constants/environment.dart';
import 'package:teslo_app/features/products/domain/entities/product_entity.dart';
import 'package:teslo_app/features/products/presentation/providers/providers.dart';
import 'package:teslo_app/features/shared/shared.dart';

final productFormProvider = StateNotifierProvider.autoDispose
    .family<ProductFormNotifier, ProductFormState, ProductEntity>((
      ref,
      product,
    ) {
      final createUpdateCallback = ref
          .watch(productsProvider.notifier)
          .createOrUpdateProduct;

      return ProductFormNotifier(
        product: product,
        onSubmitCallback: createUpdateCallback,
      );
    });

class ProductFormNotifier extends StateNotifier<ProductFormState> {
  ProductFormNotifier({
    required this.onSubmitCallback,
    required ProductEntity product,
  }) : super(
         ProductFormState(
           id: product.id,
           title: Title.dirty(product.title),
           slug: Slug.dirty(product.slug),
           price: Price.dirty(product.price),
           sizes: product.sizes,
           gender: product.gender,
           inStock: Stock.dirty(product.stock),
           description: product.description,
           tags: product.tags.join(', '),
           images: product.images,
         ),
       );

  final Future<bool> Function(Map<String, dynamic> productLike)
  onSubmitCallback;

  Future<bool> onFormSubmit() async {
    _touchEverything();

    if (!state.isFormValid) return false;

    final productLike = {
      "id": state.id,
      "title": state.title.value,
      "price": state.price.value,
      "description": state.description,
      "slug": state.slug.value,
      "stock": state.inStock.value,
      "sizes": state.sizes,
      "gender": state.gender,
      "tags": state.tags.split(','),
      "images": state.images
          .map(
            (image) =>
                image.replaceAll('${Environment.apiUrl}/files/product', ''),
          )
          .toList(),
    };

    try {
      return await onSubmitCallback(productLike);
    } catch (e) {
      return false;
    }
  }

  void _touchEverything() {
    state = state.copyWith(
      isFormValid: Formz.validate([
        Title.dirty(state.title.value),
        Stock.dirty(state.inStock.value),
        Price.dirty(state.price.value),
        Slug.dirty(state.slug.value),
      ]),
    );
  }

  void onTitleChanged(String value) {
    state = state.copyWith(
      title: Title.dirty(value),
      isFormValid: Formz.validate([
        Title.dirty(value),
        state.slug,
        state.price,
        state.inStock,
      ]),
    );
  }

  void onSlugChanged(String value) {
    state = state.copyWith(
      slug: Slug.dirty(value),
      isFormValid: Formz.validate([
        Slug.dirty(value),
        state.title,
        state.price,
        state.inStock,
      ]),
    );
  }

  void onPriceChanged(double value) {
    state = state.copyWith(
      price: Price.dirty(value),
      isFormValid: Formz.validate([
        Price.dirty(value),
        state.slug,
        state.title,
        state.inStock,
      ]),
    );
  }

  void onStockChanged(int value) {
    state = state.copyWith(
      inStock: Stock.dirty(value),
      isFormValid: Formz.validate([
        Stock.dirty(value),
        state.slug,
        state.price,
        state.title,
      ]),
    );
  }

  void onSizeChanged(List<String> sizes) {
    state = state.copyWith(sizes: sizes);
  }

  void onGenderChanged(String gender) {
    state = state.copyWith(gender: gender);
  }

  void onDescriptionChange(String description) {
    state = state.copyWith(description: description);
  }

  void onTagsChanged(String tags) {
    state = state.copyWith(tags: tags);
  }

  void onImageAdded(String path) {
    state = state.copyWith(images: [...state.images, path]);
  }
}

class ProductFormState {
  final bool isFormValid;
  final String? id;
  final Title title;
  final Slug slug;
  final Price price;
  final List<String> sizes;
  final String gender;
  final Stock inStock;
  final String description;
  final String tags;
  final List<String> images;

  ProductFormState({
    this.isFormValid = false,
    this.id,
    this.title = const Title.dirty(''),
    this.slug = const Slug.dirty(''),
    this.price = const Price.dirty(0),
    this.sizes = const [],
    this.gender = 'men',
    this.inStock = const Stock.dirty(0),
    this.description = '',
    this.tags = '',
    this.images = const [],
  });

  ProductFormState copyWith({
    bool? isFormValid,
    String? id,
    Title? title,
    Slug? slug,
    Price? price,
    List<String>? sizes,
    String? gender,
    Stock? inStock,
    String? description,
    String? tags,
    List<String>? images,
  }) => ProductFormState(
    isFormValid: isFormValid ?? this.isFormValid,
    id: id ?? this.id,
    title: title ?? this.title,
    slug: slug ?? this.slug,
    price: price ?? this.price,
    sizes: sizes ?? this.sizes,
    gender: gender ?? this.gender,
    inStock: inStock ?? this.inStock,
    description: description ?? this.description,
    tags: tags ?? this.tags,
    images: images ?? this.images,
  );
}
