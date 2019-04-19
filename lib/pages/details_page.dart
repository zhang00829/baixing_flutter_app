import 'package:baixing_flutter_app/pages/details_page/detail_explain.dart';
import 'package:baixing_flutter_app/pages/details_page/details_bottom.dart';
import 'package:baixing_flutter_app/pages/details_page/details_tabbar.dart';
import 'package:baixing_flutter_app/pages/details_page/details_top_area.dart';
import 'package:baixing_flutter_app/pages/details_page/details_web.dart';
import 'package:baixing_flutter_app/provide/details_info.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';

class DetailPage extends StatelessWidget {
  final String goodsId;

  const DetailPage({Key key, this.goodsId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _getBackInfo(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text('商品详细页'),
      ),
      body: FutureBuilder(
          future: _getBackInfo(context),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              return SafeArea(
                child: Stack(
                  children: <Widget>[
                    Container(
                      child: ListView(
                        children: <Widget>[
                          DetailsTopArea(),
                          DetailExplain(),
                          DetailsTabBar(),
                          DetailsWeb()
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: DetailsBottom(),
                    )
                  ],
                ),
              );
            } else {
              return Text('加载中');
            }
          }),
    );
  }

  Future _getBackInfo(BuildContext context) async {
    await Provide.value<DetailsInfoProvide>(context).getGoodsInfo(goodsId);
    return '完成加载';
  }
}
