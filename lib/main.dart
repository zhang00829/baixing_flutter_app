import 'package:baixing_flutter_app/pages/index_page.dart';
import 'package:baixing_flutter_app/provide/cart.dart';
import 'package:baixing_flutter_app/provide/category_goods.dart';
import 'package:baixing_flutter_app/provide/current_index.dart';
import 'package:baixing_flutter_app/provide/details_info.dart';
import 'package:baixing_flutter_app/routers/application.dart';
import 'package:baixing_flutter_app/routers/routers.dart';
import 'package:flutter/material.dart';
import 'provide/child_category.dart';
import 'package:provide/provide.dart';
import 'package:fluro/fluro.dart';

void main() {
  var providers = Providers();
  var childCategory = ChildCategory();
  var categoryGoodsListProvide = CategoryGoodsListProvide();
  var detailsInfoProvide = DetailsInfoProvide();
  var cartProvide = CartProvide();
  var currentIndexProvide = CurrentIndexProvide();
  providers
    ..provide(Provider<ChildCategory>.value(childCategory))
    ..provide(
        Provider<CategoryGoodsListProvide>.value(categoryGoodsListProvide))
    ..provide(Provider<DetailsInfoProvide>.value(detailsInfoProvide))
    ..provide(Provider<CartProvide>.value(cartProvide))
    ..provide(Provider<CurrentIndexProvide>.value(currentIndexProvide));
  runApp(ProviderNode(child: MyApp(), providers: providers));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
    return Container(
      child: MaterialApp(
        title: '百姓生活+',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.pink),
        home: IndexPage(),
        onGenerateRoute: Application.router.generator,
      ),
    );
  }
}
