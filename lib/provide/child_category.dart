import 'package:flutter/material.dart';
import '../model/category.dart';
import '../model/categoryGoodsList.dart';
import '../service/service_method.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class ChildCategory with ChangeNotifier{
  //大类导航内容
  List<BigCategoryData> bigCategoryList = [];
  //子类导航内容
  List<BxMallSubDto> childCategoryList = [];
  //商品列表内容
  List<CategoryGoodsListData> goodsList = [];

  int childIndex = 0;//子类高亮索引
  String categoryId='4';//大类id
  String subId = '';//小类id
  int page=1;//列表页数
  String noMoreText='';//显示没有数据的文字



  //获取大类导航内容
  ajaxGetBigCategoryList() async{
    await request('getCategory').then((val) {
      var data = json.decode(val.toString());
      CategoryModel category = CategoryModel.fromJson(data);
      bigCategoryList = category.data;

      //大类切换时，更新子类导航内容
      getChildCategory(bigCategoryList[0].bxMallSubDto, bigCategoryList[0].mallCategoryId);
    });
  }


  //大类切换时，更新子类导航内容
  getChildCategory(List<BxMallSubDto> list,String id ){
    page=1;
    noMoreText='';
    BxMallSubDto all = BxMallSubDto();
    all.mallSubId='';
    all.mallCategoryId='00';
    all.comments='null';
    all.mallSubName="全部";
    childCategoryList = [all];
    childCategoryList.addAll(list);
    categoryId = id;
    notifyListeners();
  }

  //获取商品列表
  ajaxGetGoodsList({@required String categorySubId}) async{
    var params = {
        'categoryId': categoryId,
        'categorySubId': categorySubId,
        "page": 1
      };

    await request('getMallGoods', formData: params).then((val) {
      addPage();
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      ///是否应该在此调用getGoodsList？ui界面调用是否更好？
      getGoodsList(goodsList.data==null?[]:goodsList.data);
    });
  }

  //ajax上拉加载商品列表
  ajaxGetMoreList() async {
    var params = {
      'categoryId':categoryId,
      'categorySubId': subId,
      "page": page,
    };
    await request('getMallGoods', formData: params).then((val) {
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      addPage();
      if (goodsList.data == null) {
        changeNoMore('没有更多了');
        Fluttertoast.showToast(
            msg: '已经到底了',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.pink,
            textColor: Colors.white,fontSize: 16.0);
      } else {
        getMoreList(goodsList.data);
      }
    });
  }


  //大类切换时，更新商品列表内容
  getGoodsList(List<CategoryGoodsListData> list){
    goodsList=list;
    notifyListeners();
  }

  //子类切换时，更新商品内容
  changeChildIndex(int index,String subId){
    page=1;
    noMoreText='';
    subId = subId;
    childIndex = index;
    notifyListeners();
  }

  //商品列表，上拉加载
  getMoreList(List<CategoryGoodsListData> list){
    goodsList.addAll(list);
    notifyListeners();
  }

  //增加page方法
  addPage(){
    page++;
  }

  changeNoMore(String text){
    noMoreText=text;
    notifyListeners();
  }
}