import 'dart:async';
import 'package:app/services/service.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class ProductService extends Service {
  static ProductService _productService;
  Map<String, dynamic> productsInCart = new Map();
  StreamController<Product> productStreamControler = StreamController<Product>.broadcast();

  static ProductService getInstance() {
    if (_productService == null) {
      _productService = new ProductService();
    }
    return _productService;
  }

  Future<Product> findProductById(String id) async {
   /* final response =
        await Service.getInstance().get("/commerce/product/id/" + id);
   */
   return Product.fromJson(json.decode("{\r\n\t\"id\":\"1\",\r\n\t\"name\" : \"Sample Product\",\r\n\t\"category\" : \"Sample Category\",\r\n\t\"thumbnail\" : \"data:image/jpeg;base64,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\",\r\n\t\"images\":[],\r\n\t\"description\" : \"Sample description\",\r\n\t\"price\" : \"1\"\r\n}"));
  }

  Future<List<Product>> findAllByCategoryByName(String name,int page,int size) async {
 /*   final response = await Service.getInstance()
        .get("/commerce/product/category?name=" + name + "&page=" + page.toString() + "&size=" + size.toString());
*/
 return Product.fromListJson(json.decode("[{\r\n\t\"id\":\"1\",\r\n\t\"name\" : \"Sample Product\",\r\n\t\"category\" : \"Sample Category\",\r\n\t\"thumbnail\" : \"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTzDgbPkonHsiIBPzYBJkwI-k3aR0AEEAcw8Q&usqp=CAU\",\r\n\t\"images\":[],\r\n\t\"description\" : \"Sample description\",\r\n\t\"price\" : \"1\"\r\n},\r\n{\r\n\t\"id\":\"1\",\r\n\t\"name\" : \"Sample Product\",\r\n\t\"category\" : \"Sample Category\",\r\n\t\"thumbnail\" : \"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTzDgbPkonHsiIBPzYBJkwI-k3aR0AEEAcw8Q&usqp=CAU\",\r\n\t\"images\":[],\r\n\t\"description\" : \"Sample description\",\r\n\t\"price\" : \"1\"\r\n},\r\n{\r\n\t\"id\":\"1\",\r\n\t\"name\" : \"Sample Product\",\r\n\t\"category\" : \"Sample Category\",\r\n\t\"thumbnail\" : \"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTzDgbPkonHsiIBPzYBJkwI-k3aR0AEEAcw8Q&usqp=CAU\",\r\n\t\"images\":[],\r\n\t\"description\" : \"Sample description\",\r\n\t\"price\" : \"1\"\r\n},\r\n{\r\n\t\"id\":\"1\",\r\n\t\"name\" : \"Sample Product\",\r\n\t\"category\" : \"Sample Category\",\r\n\t\"thumbnail\" : \"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTzDgbPkonHsiIBPzYBJkwI-k3aR0AEEAcw8Q&usqp=CAU\",\r\n\t\"images\":[],\r\n\t\"description\" : \"Sample description\",\r\n\t\"price\" : \"1\"\r\n}]"));
  }

  Future<List<Product>> findAllPagination(int page, int size) async {
/*    final response = await Service.getInstance().get(
        "/commerce/product/all?page=" +
            page.toString() +
            "&size=" +
            size.toString());*/
    return Product.fromListJson(json.decode("[{\r\n\t\"id\":\"1\",\r\n\t\"name\" : \"Sample Product\",\r\n\t\"category\" : \"Sample Category\",\r\n\t\"thumbnail\" : \"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTzDgbPkonHsiIBPzYBJkwI-k3aR0AEEAcw8Q&usqp=CAU\",\r\n\t\"images\":[],\r\n\t\"description\" : \"Sample description\",\r\n\t\"price\" : \"1\"\r\n},\r\n{\r\n\t\"id\":\"1\",\r\n\t\"name\" : \"Sample Product\",\r\n\t\"category\" : \"Sample Category\",\r\n\t\"thumbnail\" : \"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTzDgbPkonHsiIBPzYBJkwI-k3aR0AEEAcw8Q&usqp=CAU\",\r\n\t\"images\":[],\r\n\t\"description\" : \"Sample description\",\r\n\t\"price\" : 1\r\n},\r\n{\r\n\t\"id\":\"1\",\r\n\t\"name\" : \"Sample Product\",\r\n\t\"category\" : \"Sample Category\",\r\n\t\"thumbnail\" : \"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTzDgbPkonHsiIBPzYBJkwI-k3aR0AEEAcw8Q&usqp=CAU\",\r\n\t\"images\":[],\r\n\t\"description\" : \"Sample description\",\r\n\t\"price\" : 1\r\n},\r\n{\r\n\t\"id\":\"1\",\r\n\t\"name\" : \"Sample Product\",\r\n\t\"category\" : \"Sample Category\",\r\n\t\"thumbnail\" : \"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTzDgbPkonHsiIBPzYBJkwI-k3aR0AEEAcw8Q&usqp=CAU\",\r\n\t\"images\":[],\r\n\t\"description\" : \"Sample description\",\r\n\t\"price\" : \"1\"\r\n}]"));
  }

  Future<Product> findProductByName(String id) async {
   /* final response =
        await Service.getInstance().get("/commerce/product/id/" + id);*/
    return Product.fromJson(json.decode("{\r\n\t\"id\":\"1\",\r\n\t\"name\" : \"Sample Product\",\r\n\t\"category\" : \"Sample Category\",\r\n\t\"thumbnail\" : \"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTzDgbPkonHsiIBPzYBJkwI-k3aR0AEEAcw8Q&usqp=CAU\",\r\n\t\"images\":[],\r\n\t\"description\" : \"Sample description\",\r\n\t\"price\" : \"1\"\r\n}"));
  }

  Future<List<Product>> findAll() async {
 /*   final response = await Service.getInstance().get("/commerce/product/all");
    return Product.fromListJson(response["data"]);*/
    return Product.fromListJson(json.decode("[{\r\n\t\"id\":\"1\",\r\n\t\"name\" : \"Sample Product\",\r\n\t\"category\" : \"Sample Category\",\r\n\t\"thumbnail\" : \"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTzDgbPkonHsiIBPzYBJkwI-k3aR0AEEAcw8Q&usqp=CAU\",\r\n\t\"images\":[],\r\n\t\"description\" : \"Sample description\",\r\n\t\"price\" : \"1\"\r\n},\r\n{\r\n\t\"id\":\"1\",\r\n\t\"name\" : \"Sample Product\",\r\n\t\"category\" : \"Sample Category\",\r\n\t\"thumbnail\" : \"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTzDgbPkonHsiIBPzYBJkwI-k3aR0AEEAcw8Q&usqp=CAU\",\r\n\t\"images\":[],\r\n\t\"description\" : \"Sample description\",\r\n\t\"price\" : \"1\"\r\n},\r\n{\r\n\t\"id\":\"1\",\r\n\t\"name\" : \"Sample Product\",\r\n\t\"category\" : \"Sample Category\",\r\n\t\"thumbnail\" : \"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTzDgbPkonHsiIBPzYBJkwI-k3aR0AEEAcw8Q&usqp=CAU\",\r\n\t\"images\":[],\r\n\t\"description\" : \"Sample description\",\r\n\t\"price\" : \"1\"\r\n},\r\n{\r\n\t\"id\":\"1\",\r\n\t\"name\" : \"Sample Product\",\r\n\t\"category\" : \"Sample Category\",\r\n\t\"thumbnail\" : \"https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTzDgbPkonHsiIBPzYBJkwI-k3aR0AEEAcw8Q&usqp=CAU\",\r\n\t\"images\":[],\r\n\t\"description\" : \"Sample description\",\r\n\t\"price\" : \"1\"\r\n}]"));
  }
}

class Product {
  final String id;
  final String name;
  final String category;
  final String thumbnail;
  final List<dynamic> images;
  final String description;
  final String price;

  Product(
      {this.id,
      this.name,
      this.category,
      this.thumbnail,
      this.images,
      this.description,
      this.price});

  factory Product.fromJson(Map<String, dynamic> json) {
    return new Product(
      id: json["id"],
      name: json["name"],
      category: json["category"],
      thumbnail: json["thumbnail"],
      images: json["images"],
      description: json["description"],
      price: json["price"],
    );
  }

  static List<Product> fromListJson(List<dynamic> list) {
    return list.map((data) => Product.fromJson(data)).toList();
  }

  @override
  String toString() {
    return 'Product{name: $name, category: $category, thumbnail: $thumbnail, images: $images, description: $description, price: $price}';
  }
}

class ProductCarousel extends StatefulWidget {
  final Product product;
  final int index;

  ProductCarousel(this.product, this.index);

  @override
  _ProductCarousel createState() => _ProductCarousel();
}

class _ProductCarousel extends State<ProductCarousel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(5.0),
          padding: EdgeInsets.all(5.0),
          width: 120.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Color(0xfffffbd6),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0.0, 2.0),
                blurRadius: 6.0,
              ),
            ],
          ),
          child: Column(
            children: <Widget>[
              Stack(children: <Widget>[
                Container(
                  child:
                      Image.network(widget.product.thumbnail, fit: BoxFit.fill),
                  height: 160,
                  width: double.infinity,
                ),
                SizedBox(height: 8.0),
                Positioned(
                    top: 2,
                    right: 2,
                    child: ClipOval(
                      child: Material(
                        color: Color(0xff92d2c5), // button color
                        child: InkWell(
                          splashColor: Color(0xfffffbd6), // inkwell color
                          child: SizedBox(
                              width: 30, height: 30, child: Icon(Icons.add)),
                          onTap: () => {addItemToCart(widget.product)},
                        ),
                      ),
                    )),
              ]),
            ],
          ),
        ),
        SizedBox(height: 5.0),
        Container(
          width: 120.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 10.0,
              ),
              Container(
                child: Text(
                  widget.product.price,
                  style: TextStyle(
                    color: Color(0xfffffbd6),
                    fontSize: 16.0,
                    fontFamily: 'ChampBold',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Container(
                child: Text(
                  "₺",
                  style: TextStyle(
                    color: Color(0xfffffbd6),
                    fontSize: 16.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5.0),
        Container(
          width: 120.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 5.0,
              ),
              Container(
                height: 65.0,
                width: 100.0,
                child: Text(
                  widget.product.name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                    fontFamily: 'ChampItalic',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void addItemToCart(Product p) {
    if (ProductService.getInstance().productsInCart.containsKey(p.id)) {
      ProductService.getInstance().productsInCart[p.id]["amount"] =
          ProductService.getInstance().productsInCart[p.id]["amount"] + 1;
    } else {
      ProductService.getInstance().productsInCart[p.id] = {
        "amount": 1,
        "product": p
      };
      ProductService.getInstance().productStreamControler.add(p);
    }
  }
}
