
import 'package:mbeshtetu_app/src/models/category_model.dart';

class CategoryMetadata {
  List<Category> categories;

  CategoryMetadata({
    this.categories,
  });

  factory CategoryMetadata.fromJson(Map<String, dynamic> json) {
    Iterable list = json['categories'];
    List<Category> categories = list.map((i)=> Category.fromJson(i)).toList();

    return CategoryMetadata(
      categories: categories,
    );
  }
}