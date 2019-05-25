import 'package:baixing_flutter_app/model/category.dart';
import 'package:baixing_flutter_app/provide/child_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';


class LeftNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
          border: Border(right: BorderSide(width: 1, color: Colors.black12))),
      child: Provide<ChildCategory>(builder: (context,child,val){
        return ListView.builder(
            itemCount: val.bigCategoryList.length,
            itemBuilder: (BuildContext context, index) {
              return _leftInkWell(val.bigCategoryList,index,context);
            });
      }),
    );
  }

  Widget _leftInkWell(List<BigCategoryData> list,int index,context) {
    int listIndex = Provide.value<ChildCategory>(context).listIndex;
    return InkWell(
      onTap: () {
        var childList = list[index].bxMallSubDto;
        var categoryId = list[index].mallCategoryId;
        Provide.value<ChildCategory>(context)
            .getChildCategory(childList, categoryId);
        Provide.value<ChildCategory>(context).changeChildIndex(0, '');
        Provide.value<ChildCategory>(context).ajaxGetGoodsList(categorySubId: '');
        Provide.value<ChildCategory>(context).changeBigIndex(index: index);
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

