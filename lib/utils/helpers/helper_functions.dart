import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../constants/colors.dart';


class SHelperFunctions {
  static Color? getColor(String value) {
    if (value == "Green") {
      return Colors.green;
    } else if (value == 'Red') {
      return Colors.red;
    } else if (value == 'Blue') {
      return Colors.blue;
    } else if (value == 'Pink') {
      return Colors.pink;
    } else if (value == 'Grey') {
      return Colors.grey;
    } else if (value == 'Purple') {
      return Colors.purple;
    } else if (value == 'Black') {
      return Colors.black;
    } else if (value == 'White') {
      return Colors.white;
    } else if (value == 'Yellow') {
      return Colors.yellow;
    } else if (value == 'Orange') {
      return Colors.orange;
    } else if (value == 'Brown') {
      return Colors.brown;
    } else if (value == 'Teal') {
      return Colors.teal;
    } else if (value == 'Indigo') {
      return Colors.indigo;
    } else {
      return null;
    }
  }

  static void showSnackBar(String message) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(content: Text(message))
    );
  }

  static void showAlert(String title, String message) {
    showDialog(
        context: Get.context!,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop,
                  child: const Text("Ok"))
            ],
          );
        }
    );
  }


  static void navigateToScreen(BuildContext context, Widget screen){
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  static String truncateText(String text, int maxLength){
    if(text.length <= maxLength){
      return text;
    } else{
      return '${text.substring(0, maxLength)}...';
    }
  }

  static bool isDarkMode(BuildContext context){
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Size screenSize(){
    return MediaQuery.of(Get.context!).size;
  }

  static double screenHeight(){
    return MediaQuery.of(Get.context!).size.height;
  }

  static double screenWidth(){
    return MediaQuery.of(Get.context!).size.width;
  }

  static String getFormattedDate(DateTime date, {String format = 'dd MMM yyyy'}){
    return DateFormat(format).format(date);
  }

  static List<T> removeDuplicate<T>(List<T> list){
    return list.toSet().toList();
  }

  static List<Widget> wrapWidgets(List<Widget> widgets, int rowSize){
    final wrappedList = <Widget>[];
    for (var i=0; i<widgets.length; i+=rowSize){
      final rowChildren = widgets.sublist(i, i+rowSize > widgets.length ? widgets.length : i+rowSize);
      wrappedList.add(Row(children: rowChildren));
    }
    return wrappedList;
  }



  static Future showCustomBottomSheet(BuildContext context ,List<Widget> content,
      {double? topPadding,
        bool noHandle = false,
        bool? isScrollControlled = true,
        Widget? topWidget,
        double? sidePadding,
        bool isDismissible = true,
        bool showSearchBox = false, String? searchHint
      })async{
    return await showModalBottomSheet(
        backgroundColor: Colors.transparent,
        showDragHandle: false,
        isDismissible: isDismissible ,
        isScrollControlled: isScrollControlled ?? true,
        context: context, builder: (context)=>
        SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if(topWidget != null)
                topWidget,
              Container(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom,
                    top: 12.h,left:sidePadding?? 24.w,
                    right: sidePadding??24.w),
                decoration:  BoxDecoration(
                    color: SColors.white,
                    borderRadius: BorderRadius.only(topRight:Radius.circular(20.r),topLeft:Radius.circular(20.r) )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if(!noHandle)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(),
                          Container(
                            width: 45.w,height: 5.h,
                            decoration: BoxDecoration(
                              borderRadius:  BorderRadius.circular(100.r),
                              color: SColors.grey,
                            ),

                          ),
                          InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Image.asset( 'assets/icons/cancel.png',width: 21.5.w,),
                          )
                        ],
                      ),
                    SizedBox(height: topPadding??24.h,),
                    if(showSearchBox)
                      // SearchBox(
                      //   prefixIcon: 'icons/grey_search_icon', hint: searchHint??'',),
                    ...content
                  ],
                ),
              ),
            ],
          ),
        ));
  }


}