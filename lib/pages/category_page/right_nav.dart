import 'package:baixing_flutter_app/model/category.dart';
import 'package:baixing_flutter_app/provide/child_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

class RightNav extends StatelessWidget {
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
                    childCategory.childCategoryList[index], index,context);
              }),
        );
      },
    );
  }

  Widget _rightInWell(BxMallSubDto item, int index,context) {
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
