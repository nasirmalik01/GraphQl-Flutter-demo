import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

Widget appBarText({String? title}){
  return Text(
    title!,
    style: TextStyle(fontSize: 11.sp),
  );
}