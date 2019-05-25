import 'package:baixing_flutter_app/pages/category_page/goods_list.dart';
import 'package:baixing_flutter_app/pages/category_page/left_nav.dart';
import 'package:baixing_flutter_app/pages/category_page/right_nav.dart';
import 'package:baixing_flutter_app/provide/child_category.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void didChangeDependencies() {
    Provide.value<ChildCategory>(context).ajaxGetBigCategoryList();
    Provide.value<ChildCategory>(context).ajaxGetGoodsList(categorySubId: '');
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品分类'),
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftNav(),
            Column(
              children: <Widget>[
                RightNav(),
                CategoryGoodsList(),
              ],
            )
          ],
        ),
      ),
    );
  }
}



