import 'package:app/screens/home.dart';
import 'package:app/screens/cart.dart';
import 'package:app/library/fancy_bottom_navigation.dart';
import 'package:app/services/product.dart';
import 'package:flutter/material.dart';
import 'package:app/utilities/constants.dart';
import 'package:app/icons/nova_icons_icons.dart';

class Router extends StatefulWidget {
  @override
  State createState() {
    return _RouterState();
  }
}

class Base extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: lightGreen,
      ),
      home: Router(),
    );
  }
}

class _RouterState extends State<Router> {
  int currentPage = 0;
  static GlobalKey bottomNavigationKey = GlobalKey();

  TabData home = TabData(
      iconData: NovaIcons.animalshelter,
      title: "Anasayfa",
      onclick: () {
        final FancyBottomNavigationState fState =
            bottomNavigationKey.currentState;
        fState.setPage(0);
      });

  TabData cart = TabData(
      iconData: NovaIcons.mamakab_,
      title: "Sepetim",
      onclick: () {
        final FancyBottomNavigationState fState =
            bottomNavigationKey.currentState;
        fState.setPage(1);
      });

  TabData profile = TabData(
      iconData: NovaIcons.cute_dog,
      title: "Hesabım",
      onclick: () {
        final FancyBottomNavigationState fState =
            bottomNavigationKey.currentState;
        fState.setPage(2);
      });

  @override
  Widget build(BuildContext context) {


    FancyBottomNavigation fancyBottomNavigation = FancyBottomNavigation(
      barBackgroundColor: Color(0xfffffbd6),
      activeIconColor: Color(0xfffffbd6),
      tabs: [
        home,
        cart,
        profile,
      ],
      initialSelection: 0,
      key: bottomNavigationKey,
      onTabChangedListener: (position) {
        setState(() {
          currentPage = position;
        });
      },
    );

    ProductService.getInstance().productStreamControler.stream.listen((data) {
      setCartIndex();
    }, onDone: () {
      print("Task Done");
    }, onError: (error) {
      print("Some Error");
    });

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Center(
          child: _getPage(currentPage),
        ),
      ),
      bottomNavigationBar: FancyBottomNavigation(
        barBackgroundColor: Color(0xfffffbd6),
        activeIconColor: Color(0xfffffbd6),
        tabs: [
          home,
          cart,
          profile,
        ],
        initialSelection: 0,
        key: bottomNavigationKey,
        onTabChangedListener: (position) {
          setState(() {
            currentPage = position;
          });
        },
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[Text("Hello"), Text("World")],
        ),
      ),
    );
  }

  void setCartIndex() {
    cart.index = ProductService.getInstance().productsInCart.length.toString();
  }

  _getPage(int page) {
    switch (page) {
      case 0:
        return Home();
      case 1:
        return Cart();
      case 2:
        return Scaffold();
    }
  }
}
