import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:zappy_meal/controllers/login/login_cubit.dart';
import 'package:zappy_meal/models/login/verification_routing.dart';
import 'package:zappy_meal/routes/index.dart';
import 'package:zappy_meal/screens/auth/widgets/phone_input.dart';
import 'package:zappy_meal/shared/components/buttons.dart';
import 'package:zappy_meal/shared/components/radius.dart';
import 'package:zappy_meal/shared/components/taosts.dart';
import 'package:zappy_meal/shared/utils/index.dart';
import 'package:zappy_meal/shared/utils/sizing.dart';
import 'package:zappy_meal/theme/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool has_accepted_terms = false;
  bool is_password_visible = false;
  bool loading = false;
  bool error = false;
  PhoneNumber phone_number = PhoneNumber(isoCode: "CM");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: kheight(context),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Padding(
              padding: kAppPading(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Image.asset(ImageAssets.color_logo_and_name, scale: 2)),
                  kh20Spacer(),
                  // Text("Login", style: Theme.of(context).textTheme.displayLarge),
                  Form(
                    child: Column(
                      children: AnimateList(
                        interval: 200.ms,
                        effects: [
                          SlideEffect(end: Offset.zero, begin: Offset(0, 1)),
                          FadeEffect(),
                        ],
                        children: [
                          kh20Spacer(),
                          phoneInput(
                            context: context,
                            number: phone_number,
                            onInputChanged: (PhoneNumber phone) {
                              setState(() => phone_number = phone);
                            },
                          ),
                          kh20Spacer(),
                          BlocConsumer<LoginCubit, LoginState>(
                            listener: (context, state) {
                              if (state is LoginPhoneSuccess) {
                                context.go(AppRoutes.verify, extra: VerificationRoutingResponse(id: state.res.id, code: state.res.code));
                              }
                            },
                            builder: (context, state) {
                              if (state is LoginPhoneInit) loading = true;
                              if (state is LoginPhoneError) {
                                loading = false;
                                error = true;
                              }
                              if (state is LoginPhoneSuccess) {
                                loading = false;
                              }
                              return submitButton(
                                loading: loading,
                                context: context,
                                onPressed: () async {
                                  if (phone_number.phoneNumber != null)
                                    BlocProvider.of<LoginCubit>(context).phoneLogin(context, phone_number.phoneNumber!);
                                  else {
                                    showToastError("Please enter a phone number");
                                  }
                                },
                                text: "Login",
                              );
                            },
                          ),
                          kh20Spacer(),
                          Container(
                            decoration: BoxDecoration(color: Theme.of(context).highlightColor.withOpacity(0.2), borderRadius: radiusM()),
                            padding: kpadding(20.w, 20.h),
                            child: Row(
                              children: [
                                Container(
                                  height: 40.h,
                                  width: 40.h,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).hoverColor.withOpacity(0.2),
                                    borderRadius: radiusSm(),
                                  ),
                                  child: Transform.scale(scale: 0.5, child: SvgPicture.asset(AppIcons.login)),
                                ),
                                kwSpacer(10.w),
                                GestureDetector(
                                  onTap: () => context.push(AppRoutes.register),
                                  child: RichText(
                                    text: TextSpan(
                                      text: "Don't yet have an account?",
                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: "\nRegister",
                                          style: TextStyle(fontWeight: FontWeight.bold, color: primaryColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget authInput({
    required String label,
    required String hint,
    Widget? prefixIcon,
    Widget? sufficIcon,
    TextInputType? keyboardType,
    bool obscureText = false,
  }) {
    return Container(
      margin: kpadding(0, 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          khSpacer(5.h),
          TextFormField(
            style: Theme.of(context).textTheme.bodyMedium,
            obscureText: obscureText,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hint,
              prefixIcon: prefixIcon,
              suffixIcon: sufficIcon,
              hintStyle: Theme.of(context).textTheme.labelMedium,
            ),
          ),
        ],
      ),
    );
  }
}
