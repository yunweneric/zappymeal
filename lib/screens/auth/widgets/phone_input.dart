import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../shared/utils/sizing.dart';

Widget phoneInput(BuildContext context, PhoneNumber number) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Phone Number"),
      khSpacer(5.h),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: Theme.of(context).highlightColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10.r),
          // border: Border.all(color: kTextGrey),
        ),
        child: InternationalPhoneNumberInput(
          hintText: "Enter phone",
          textStyle: Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 12.sp, color: Theme.of(context).primaryColorDark),
          // textFieldController: phoneNumberController,
          onInputChanged: (PhoneNumber number) {
            // setState(() => userPhone = number.phoneNumber!);
          },
          searchBoxDecoration: InputDecoration(
            hintText: "Select country",
            prefix: Icon(Icons.search),
            hintStyle: TextStyle(fontSize: 12.sp),
            contentPadding: kpadding(10.w, 12.h),
          ),
          inputDecoration: InputDecoration(filled: false, hintText: "Enter phone number"),
          onInputValidated: (bool value) {},
          selectorConfig: SelectorConfig(selectorType: PhoneInputSelectorType.BOTTOM_SHEET),
          ignoreBlank: false,
          autoValidateMode: AutovalidateMode.disabled,
          selectorTextStyle: TextStyle(color: Theme.of(context).primaryColorDark, fontSize: 12.sp),
          initialValue: number,
          formatInput: false,
          validator: (value) {
            if (value!.isEmpty || value.length < 9) {
              return "Please enter a valid number";
            }
            return null;
          },
          keyboardType: TextInputType.number,
          inputBorder: OutlineInputBorder(borderSide: BorderSide.none),
          onSaved: (PhoneNumber number) {},
        ),
      ),
    ],
  );
}
