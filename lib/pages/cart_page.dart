import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<String> testList =[];
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  //增加
  void _add()async{
    SharedPreferences prefs =await SharedPreferences.getInstance();

    String temp = 'jspang是金三胖';
    testList.add(temp);
    prefs.setStringList('test', testList);
    _show();
  }

  //查询
  void _show() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getStringList('test')!=null){
      setState(() {
        testList = prefs.getStringList('test');
      });
    }
  }

  //删除
  void _clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('test');
    setState(() {
      testList=[];
    });
  }

}



