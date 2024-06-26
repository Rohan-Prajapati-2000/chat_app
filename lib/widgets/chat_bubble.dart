import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatBubble extends StatelessWidget{
  const ChatBubble({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24.r),
          bottomLeft: Radius.circular(24.r),
        ),
        color: Colors.lightBlueAccent[100]
      ),
      child: Text(message,
        style: TextStyle(fontSize: 14, color: Colors.black),
      ),
    );
  }

}