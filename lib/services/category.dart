import 'dart:async';
import 'package:app/services/service.dart';
import 'dart:convert';

class CategoryService extends Service {
  static CategoryService _categoryService;

  static CategoryService getInstance() {
    if (_categoryService == null) {
      _categoryService = new CategoryService();
    }
    return _categoryService;
  }

  // service call
  Future<List<Category>> findAll() async {
   /* final response = await Service.getInstance().get("/commerce/category/all");
    return Category.fromListJson(response["data"]);*/
    return Category.fromListJson(json.decode("{\r\n  \"id\":\"123\",\r\n  \"name\" : \"Sample Category\",\r\n  \"image\" : \"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTzDgbPkonHsiIBPzYBJkwI-k3aR0AEEAcw8Q&usqp=CAU\",\r\n\t\"images\":[],\r\n\t\"description\" : \"Sample description\",\r\n\t\"price\" : 1\r\n},\r\n{\r\n\t\"id\":1,\r\n\t\"name\" : \"Sample Product\",\r\n\t\"category\" : \"Sample Category\",\r\n\t\"thumbnail\" : \"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTzDgbPkonHsiIBPzYBJkwI-k3aR0AEEAcw8Q&usqp=CAU\",\r\n  \"productCount\" : 1\r\n\t\r\n}"));
  }
}

class Category {
  final String id;
  final String name;
  final String image;
  final String parent;
  final int productCount;

  Category({this.id, this.name, this.image, this.parent, this.productCount});

  factory Category.fromJson(Map<String, dynamic> json) {
    return new Category(
      id: json["id"],
      name: json["name"],
      parent: json["parent"],
      image: json["image"],
      productCount: json["productCount"],
    );
  }

  static List<Category> fromListJson(List<dynamic> list) {
    return list.map((data) => Category.fromJson(data)).toList();
  }
}
