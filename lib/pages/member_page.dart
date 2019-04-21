import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('会员中心'),
      ),
      body: ListView(
        children: <Widget>[
          _topHeader()
        ],
      ),
    );
  }
  
  Widget _topHeader(){
    return Container(
      width: ScreenUtil().setWidth(750),
      color: Colors.pinkAccent,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 30),
            child: ClipOval(
              child: Image.network('https://appiconmaker.co/home/appicon/testid?size=1024'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text('Ray',style: TextStyle(fontSize: ScreenUtil().setSp(36),color: Colors.black54),),
          )
        ],
      ),
    );
  }
}
