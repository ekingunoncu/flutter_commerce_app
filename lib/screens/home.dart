import 'package:app/services/category.dart';
import 'package:flutter/material.dart';
import 'package:app/services/product.dart';
import 'package:app/utilities/constants.dart';
import 'package:flutter_paginator/flutter_paginator.dart';
import 'package:progress_indicators/progress_indicators.dart';

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<Product>> futureProducts;
  ProductService productService = ProductService.getInstance();

  @override
  void initState() {
    super.initState();
    futureProducts = productService.findAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGreen,
      body: Container(
        child: buildListOfCategories(),
      ),
    );
  }

  Widget buildListOfCategories() {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none &&
            snapshot.data == null) {
          return JumpingDotsProgressIndicator(
            fontSize: 35.0,
            color: Color(0xfffffbd6),
          );
        } else {
          return ListView.builder(
            shrinkWrap: true,
            reverse: false,
            physics: BouncingScrollPhysics(),
            itemBuilder: (ctx, i) {
              return Container(
                height: 300.0,
                child: Paginator.listView(
                  shrinkWrap: true,
                  key: GlobalKey(),
                  pageLoadFuture: (int page) async {
                    try {
                      return ProductService.getInstance()
                          .findAllByCategoryByName("Sample Category",page, 5);
                    } catch (e) {
                      throw Exception(e);
                    }
                  },
                  pageItemsGetter: (List<Product> productList) {
                    return productList;
                  },
                  listItemBuilder: (value, int index) {
                    return ProductCarousel(value,index);
                  },
                  loadingWidgetBuilder: () {
                    return Container(
                      alignment: Alignment.center,
                      height: 340.0,
                      child: JumpingDotsProgressIndicator(
                        fontSize: 35.0,
                        color: Color(0xfffffbd6),
                      ),
                    );
                  },
                  errorWidgetBuilder:
                      (List<Product> productList, retryListener) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                          onPressed: retryListener,
                          child: Text('Tekrar yüklemek için dokun.'),
                        )
                      ],
                    );
                  },
                  emptyListWidgetBuilder: (List<Product> productList) {
                    return Center(
                      child: Text('Listede ürün bulunamadı.'),
                    );
                  },
                  totalItemsGetter: (List<Product> productList) {
                    return 3;//snapshot.data[i].productCount;
                  },
                  pageErrorChecker: (List<Product> productList) {
                    if (productList != null) {
                      return productList.length < 0;
                    } else {
                      return false;
                    }
                  },
                  scrollDirection: Axis.horizontal,
                  scrollPhysics: BouncingScrollPhysics(),
                ),
              );
            },
            itemCount: 3 //snapshot.data == null ? 0 : snapshot.data.length,
          );
        }
      },
      future: CategoryService.getInstance().findAll(),
    );
  }
}
