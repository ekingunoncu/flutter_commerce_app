import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:app/services/product.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<dynamic> productList =
      ProductService.getInstance().productsInCart.values.toList();

  _buildCartProduct(int index) {
    Map<String, dynamic> map = productList[index];
    double price = double.parse(map["product"].price) * map["amount"];
    return ListTile(
      contentPadding: EdgeInsets.all(20.0),
      leading: Image(
        height: double.infinity,
        width: 100.0,
        image: NetworkImage(
          map["product"].thumbnail,
        ),
        fit: BoxFit.contain,
      ),
      title: Text(
        map["product"].name,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        "x " + map["amount"].toString(),
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Text(
        price.toString(),
        style: TextStyle(
          color: Colors.orange,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget getTitle() {
    if (ProductService.getInstance().productsInCart != null &&
        ProductService.getInstance().productsInCart.length != null) {
      return Text(
        'Sepetim (${ProductService.getInstance().productsInCart.length})',
        style: TextStyle(color: Colors.black),
      );
    } else {
      return Text(
        'Sepetim (0)',
        style: TextStyle(color: Colors.black),
      );
    }
  }

  Widget getBody() {
    if (productList != null) {
      return ListView.separated(
        itemCount: productList.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildCartProduct(index);
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.grey[300],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = 0;
    if(ProductService.getInstance().productsInCart.values.length >= 1){
      totalPrice = ProductService.getInstance().productsInCart.values.map((e) => double.parse(e["product"].price) * e["amount"]).reduce((a, b) => a + b);
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: getTitle(),
        ),
        body: getBody(),
        bottomSheet: Container(
          height: 120.0,
          color: Colors.orange,
          child: Center(
            child: Text(
              'Alışverişi Tamamla ' + totalPrice.toString() + " ₺",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    }else{
      return Scaffold(backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: getTitle(),
        ),);
    }

  }
}
