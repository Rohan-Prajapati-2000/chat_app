import 'package:flutter/Material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/constants/colors.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield(
      {super.key,
      required this.hintText,
      this.validator,
      required this.controller,
      this.inputType = TextInputType.name,
      this.obscureText = false});

  final String hintText;
  final TextEditingController controller;
  final TextInputType inputType;
  final obscureText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return FormField(
        validator: validator == null
            ? null
            : (v) {
                return validator!(controller.text);
              },
        builder: (state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: TextField(
                      controller: controller,
                      keyboardType: inputType,
                      obscureText: obscureText,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16.w),
                          fillColor: SColors.lightGrey,
                          filled: true,
                          hintText: hintText,
                          hintStyle: TextStyle(color: SColors.grey1),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: state.hasError
                                    ? SColors.error
                                    : SColors.lightGrey),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: state.hasError
                                    ? SColors.error
                                    : SColors.grey1),
                            borderRadius: BorderRadius.circular(16.r),
                          )),
                    ),
                  ),
                  if (state.hasError)
                    RSizedBox(
                      height: 6.h,
                    ),
                  if (state.hasError)
                    Text(
                      state.errorText!,
                      style: TextStyle(color: SColors.error),
                    )
                ],
              )
            ],
          );
        });
  }
}
