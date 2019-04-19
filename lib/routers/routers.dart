import 'package:baixing_flutter_app/routers/router_handler.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class Routes{
  static String root='/';
  static String detailsPage='/detail';
  static void configureRoutes(Router router){
    router.notFoundHandler = new Handler(
      handlerFunc: (BuildContext context,Map<String,List<String>> params){
        print('Error=> Router not fund');
      }
    );
    router.define(detailsPage, handler: detailsHandler);
  }
}