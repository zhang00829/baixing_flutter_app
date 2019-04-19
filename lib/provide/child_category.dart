import 'package:flutter/material.dart';
import '../model/category.dart';

class ChildCategory with ChangeNotifier{
  List<BxMallSubDto> childCategoryList = [];
  int childIndex = 0;//子类高亮索引
  String categoryId='4';//大类id
  String subId = '';//小类id
  int page=1;//列表页数
  String noMoreText='';//显示没有数据的文字

  //大类切换
  getChildCategory (List<BxMallSubDto> list,String id ){
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

  //子类索引切换
  changeChildIndex(int index,String subId){
    page=1;
    noMoreText='';
    subId = subId;
    childIndex = index;
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