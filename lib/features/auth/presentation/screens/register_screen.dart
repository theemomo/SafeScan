import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:safe_scan/core/route/route_names.dart';
import 'package:safe_scan/core/utils/app_validators.dart';
import 'package:safe_scan/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:safe_scan/features/auth/presentation/widgets/animated_auth_widget.dart';
import 'package:safe_scan/features/auth/presentation/widgets/app_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final FocusNode _usernameFocusNode = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _passwordFocusNode = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
    _usernameFocusNode.dispose();
    _emailController.dispose();
    _emailFocusNode.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthCubit>(context).register(
        _usernameController.text,
        _emailController.text,
        _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: 70.h, left: 24.w, right: 24.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedAuthWidget(
                  delay: 100,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Safe',
                          style: TextStyle(
                            color: const Color(0xFF1F41BB),
                            fontSize: 32.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Scan',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 32.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                AnimatedAuthWidget(
                  delay: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Create Account',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          height: 2,
                        ),
                      ),
                      Text(
                        'Scan links and protect your digital shield.',
                        style: TextStyle(
                          color: const Color(0xFF797878),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedAuthWidget(
                        delay: 300,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Username',
                              style: TextStyle(
                                color: const Color(0xFF626262),
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            AppTextField(
                              fieldController: _usernameController,
                              onFieldSubmitted: (_) {
                                _usernameFocusNode.unfocus();
                                FocusScope.of(context)
                                    .requestFocus(_emailFocusNode);
                              },
                              label: "Enter your username",
                              keyboardType: TextInputType.text,
                              validator: AppValidators.validateUsername,
                              fieldFocusNode: _usernameFocusNode,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),
                      AnimatedAuthWidget(
                        delay: 400,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email',
                              style: TextStyle(
                                color: const Color(0xFF626262),
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            AppTextField(
                              fieldController: _emailController,
                              onFieldSubmitted: (_) {
                                _emailFocusNode.unfocus();
                                FocusScope.of(
                                  context,
                                ).requestFocus(_passwordFocusNode);
                              },
                              label: "Enter email or phone number",
                              keyboardType: TextInputType.emailAddress,
                              validator: AppValidators.validateEmail,
                              fieldFocusNode: _emailFocusNode,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),
                      AnimatedAuthWidget(
                        delay: 500,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Password',
                              style: TextStyle(
                                color: const Color(0xFF626262),
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            AppTextField(
                              fieldController: _passwordController,
                              onFieldSubmitted: (_) {
                                _passwordFocusNode.unfocus();
                                _submit();
                              },
                              label: "Enter Password",
                              keyboardType: TextInputType.visiblePassword,
                              validator:
                                  AppValidators.validateRegisterPassword,
                              fieldFocusNode: _passwordFocusNode,
                              isPassword: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                AnimatedAuthWidget(
                  delay: 600,
                  child: BlocConsumer<AuthCubit, AuthState>(
                    listenWhen: (previous, current) =>
                        current is AuthFailure || current is Authenticated,
                    listener: (context, state) {
                      if (state is AuthFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.errorMessage),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else if (state is Authenticated) {
                        context.go('/');
                      }
                    },
                    buildWhen: (previous, current) =>
                        current is AuthLoading || current is AuthInitial,
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 55.h),
                            backgroundColor: const Color(0xFF1F41BB),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        );
                      }
                      return ElevatedButton(
                        onPressed: _submit,
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 55.h),
                          backgroundColor: const Color(0xFF1F41BB),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 32.h),
                AnimatedAuthWidget(
                  delay: 700,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1.h,
                          color: const Color(0xFFCACACA),
                        ),
                      ),
                      Text(
                        '  Or  ',
                        style: TextStyle(
                          color: const Color(0xFF797878),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: 130.w,
                          height: 1.h,
                          color: const Color(0xFFCACACA),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15.h),
                AnimatedAuthWidget(
                  delay: 800,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 55.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0xFFCACACA)),
                            color: const Color(0xFFF1F1F1),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.facebook,
                                size: 28.w,
                                color: const Color(0xFF0866FF),
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                'Facebook',
                                style: TextStyle(
                                  color: const Color(0xFF797878),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Container(
                          height: 55.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0xFFCACACA)),
                            color: const Color(0xFFF1F1F1),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/svgs/google.svg',
                                width: 24.w,
                                height: 24.w,
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                'Gmail',
                                style: TextStyle(
                                  color: const Color(0xFF797878),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                AnimatedAuthWidget(
                  delay: 900,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: const Color(0xFF797878),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.goNamed(RouteNames.login);
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: const Color(0xFF1F41BB),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
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
