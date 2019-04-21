import 'package:baixing_flutter_app/pages/cart_page/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';

import '../provide/cart.dart';
import 'cart_page/cart_bottom.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('购物车'),
        ),
        body: FutureBuilder(
          future: _getCartInfo(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List cartList = Provide.value<CartProvide>(context).cartList;
              return Stack(
                children: <Widget>[
                  Provide<CartProvide>(
                    builder: (context, child, val) {
                      cartList = Provide.value<CartProvide>(context).cartList;
                      return ListView.builder(
                          itemCount: cartList.length,
                          itemBuilder: (context, index) {
                            return CartItem(
                              item: cartList[index],
                            );
                          });
                    },
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: CartBottom(),
                  )
                ],
              );
            } else {
              return Text('正在加载');
            }
          },
        ));
  }

  Future<String> _getCartInfo(BuildContext context) async {
    await Provide.value<CartProvide>(context).getCartInfo();
    return 'end';
  }
}
