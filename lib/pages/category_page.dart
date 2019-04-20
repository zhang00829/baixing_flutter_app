import 'package:baixing_flutter_app/provide/child_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

import '../model/category.dart';
import '../provide/category_goods.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品分类'),
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNav(),
            Column(
              children: <Widget>[
                RightCategoryNav(),
                CategoryGoodsList(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

//左侧大类导航
class LeftCategoryNav extends StatefulWidget {
  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List list = [];
  int listIndex = 0;



  @override
  Widget build(BuildContext context) {
    Provide.value<ChildCategory>(context).ajaxGetBigCategoryList();
    Provide.value<ChildCategory>(context).ajaxGetGoodsList(categorySubId: '');
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
          border: Border(right: BorderSide(width: 1, color: Colors.black12))),
      child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (BuildContext context, index) {
            return _leftInkWell(index);
          }),
    );
  }

  Widget _leftInkWell(int index) {
    return InkWell(
      onTap: () {
        var childList = list[index].bxMallSubDto;
        var categoryId = list[index].mallCategoryId;
        Provide.value<ChildCategory>(context)
            .getChildCategory(childList, categoryId);
        Provide.value<ChildCategory>(context).changeChildIndex(0, '');
        setState(() {
          listIndex = index;
        });
        Provide.value<ChildCategory>(context).ajaxGetGoodsList(categorySubId: categoryId);
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10, top: 20),
        decoration: BoxDecoration(
            color: index == listIndex
                ? Color.fromRGBO(236, 236, 236, 1.0)
                : Colors.white,
            border:
                Border(bottom: BorderSide(color: Colors.black12, width: 1))),
        child: Text(
          list[index].mallCategoryName,
          style: TextStyle(fontSize: ScreenUtil().setSp(28)),
        ),
      ),
    );
  }




}

//右侧分类导航
class RightCategoryNav extends StatefulWidget {
  @override
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {
  @override
  Widget build(BuildContext context) {
    return Provide<ChildCategory>(
      builder: (context, child, childCategory) {
        return Container(
          height: ScreenUtil().setHeight(80),
          width: ScreenUtil().setWidth(570),
          decoration: BoxDecoration(
              color: Colors.white,
              border:
                  Border(bottom: BorderSide(color: Colors.black12, width: 1))),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: childCategory.childCategoryList.length,
              itemBuilder: (BuildContext context, index) {
                return _rightInWell(
                    childCategory.childCategoryList[index], index);
              }),
        );
      },
    );
  }

  Widget _rightInWell(BxMallSubDto item, int index) {
    return InkWell(
      onTap: () {
        Provide.value<ChildCategory>(context)
            .changeChildIndex(index, item.mallSubId);
        Provide.value<ChildCategory>(context).ajaxGetGoodsList(categorySubId:item.mallSubId);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        child: Text(
          item.mallSubName,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(28),
            color: index == Provide.value<ChildCategory>(context).childIndex
                ? Colors.pink
                : Colors.black,
          ),
        ),
      ),
    );
  }


}

//商品列表
class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();
  var scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(
        builder: (BuildContext context, child, data) {
      try {
        if (Provide.value<ChildCategory>(context).page == 2) {
          //列表位置放到最上边
          scrollController.jumpTo(0);
        }
      } catch (e) {
        print('浸入页面第一次初始化$e');
      }

      if (data.goodsList.length > 0) {
        return Expanded(
          child: Container(
            width: ScreenUtil().setWidth(570),
            child: EasyRefresh(
              refreshFooter: ClassicsFooter(
                key: _footerKey,
                bgColor: Colors.white,
                textColor: Colors.pink,
                moreInfoColor: Colors.pink,
                showMore: true,
                noMoreText: Provide.value<ChildCategory>(context).noMoreText,
                moreInfo: '加载中',
                loadReadyText: '上拉加载',
              ),
              child: ListView.builder(
                  controller: scrollController,
                  itemCount: data.goodsList.length,
                  itemBuilder: (BuildContext context, index) {
                    return _listWidget(data.goodsList, index);
                  }),
              loadMore: () {
                Provide.value<ChildCategory>(context).ajaxGetMoreList();
              },
            ),
          ),
        );
      } else {
        return Text('暂无数据');
      }
    });
  }



  Widget _goodsImage(List newList, index) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(newList[index].image),
    );
  }

  Widget _goodsName(List newList, index) {
    return Container(
      padding: EdgeInsets.all(5.0),
      width: ScreenUtil().setWidth(370),
      child: Text(
        newList[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
      ),
    );
  }

  Widget _goodsPrice(List newList, index) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Row(
        children: <Widget>[
          Text(
            '价格:¥${newList[index].presentPrice}',
            style:
                TextStyle(color: Colors.pink, fontSize: ScreenUtil().setSp(30)),
          ),
          Text(
            '¥${newList[index].oriPrice}',
            style: TextStyle(
                color: Colors.black26, decoration: TextDecoration.lineThrough),
          ),
        ],
      ),
    );
  }

  Widget _listWidget(List newList, int index) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(bottom: BorderSide(color: Colors.black26, width: 1))),
        child: Row(
          children: <Widget>[
            _goodsImage(newList, index),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _goodsName(newList, index),
                _goodsPrice(newList, index)
              ],
            )
          ],
        ),
      ),
    );
  }
}
