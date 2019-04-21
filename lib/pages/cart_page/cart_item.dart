import 'package:baixing_flutter_app/pages/cart_page/cart_count.dart';
import 'package:baixing_flutter_app/provide/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../model/cart_info.dart';

class CartItem extends StatelessWidget {
  final CartInfoModel item ;

  const CartItem({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
      padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1,color: Colors.black12)
        )
      ),
      child: Row(
        children: <Widget>[
          _cartCheckBtn(context,item),
          _cartImage(),
          _cartGoodsName(),
          _cartPrice(context)
        ],
      ),
    );
  }
  
  Widget _cartCheckBtn(context,CartInfoModel item){
    return Container(
      child: Checkbox(value: item.isCheck,activeColor: Colors.pink,onChanged: (val){
        item.isCheck =val;
        Provide.value<CartProvide>(context).changeCheckState(item);
      },),
    );
  }
  
  Widget _cartImage(){
    return Container(
      width: ScreenUtil().setWidth(150),
      padding: EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(width: 1.0,color: Colors.black12)
      ),
      child: Image.network(item.images),
    );
  }
  
  Widget _cartGoodsName(){
    return Container(
      width: ScreenUtil().setWidth(300),
      padding: EdgeInsets.all(10),
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(item.goodsName),
          CartCount(item: item,)
        ],
      ),
    );
  }
  
  Widget _cartPrice(context){
    return Container(
      width: ScreenUtil().setWidth(150),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Text('¥${item.price}'),
          Container(
            child: InkWell(onTap: (){
              Provide.value<CartProvide>(context).deleteOneGoods(item.goodsId);
            },
            child: Icon(Icons.delete,color: Colors.black26,size: 30.0,),),
          )
        ],
      ),
    );
  }
}
