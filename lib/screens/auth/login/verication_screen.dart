import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:zappy_meal/shared/components/buttons.dart';
import 'package:zappy_meal/shared/components/radius.dart';
import 'package:zappy_meal/shared/utils/sizing.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  Timer? myTimer;
  int timer = 30;

  void timerCount() {
    myTimer = Timer.periodic(Duration(seconds: 1), (time) {
      if (timer > 0)
        setState(() => timer = timer - 1);
      else
        time.cancel();
    });
  }

  void resetTimer() {
    setState(() => timer = 30);
    timerCount();
  }

  @override
  void initState() {
    timerCount();
    super.initState();
  }

  String otpCode = "";
  @override
  void dispose() {
    myTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 80.w,
      height: 75.w,
      textStyle: TextStyle(fontSize: 20.sp, color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: radiusSm(),
        color: Theme.of(context).highlightColor,
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          height: kheight(context),
          width: kwidth(context),
          padding: kAppPading(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Verify your account", style: Theme.of(context).textTheme.displayMedium),
                kh20Spacer(),
                Text(
                  "We have just sent you an SMS with a 4 digit code, enter it in the field below",
                  textAlign: TextAlign.center,
                ),
                kh20Spacer(),
                Pinput(
                  length: 4,
                  errorText: "",
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: defaultPinTheme.copyDecorationWith(
                    border: Border.all(color: Theme.of(context).primaryColor),
                    borderRadius: radiusSm(),
                  ),
                  submittedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      color: Theme.of(context).cardColor,
                    ),
                  ),
                  validator: (s) {
                    if (s == null) return '';
                    return s;
                  },
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  showCursor: true,
                  onChanged: (pin) => setState(() => otpCode = pin),
                ),
                kh20Spacer(),
                submitButton(context: context, onPressed: () {}, text: "Continue"),
                kh20Spacer(),
                if (timer > 0)
                  RichText(
                    text: TextSpan(
                      text: "Didn't receive the code? Resent code in ",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(),
                      children: <TextSpan>[
                        TextSpan(
                          text: timer.toString() + " seconds",
                          style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
