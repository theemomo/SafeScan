import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safe_scan/core/route/app_routes.dart';
import 'package:safe_scan/features/auth/presentation/widgets/app_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _passwordFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 70.h, left: 24.w, right: 24.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
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
              SizedBox(height: 24.h),

              Text(
                'Login to safely scan your links and stay ahead of online threats.',
                style: TextStyle(
                  color: const Color(0xFF797878),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                'Email',
                style: TextStyle(
                  color: const Color(0xFF626262),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 13.h),
              AppTextField(
                fieldController: _emailController,
                onFieldSubmitted: (_) {
                  _emailFocusNode.unfocus();
                },
                label: "Enter email or phone number",
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }

                  // Basic email pattern
                  final emailRegex = RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  );
                  if (!emailRegex.hasMatch(value)) {
                    return 'Please enter a valid email';
                  }

                  return null;
                },
                fieldFocusNode: _emailFocusNode,
              ),
              SizedBox(height: 16.h),
              Text(
                'Password',
                style: TextStyle(
                  color: const Color(0xFF626262),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 13.h),
              AppTextField(
                fieldController: _passwordController,
                onFieldSubmitted: (_) {
                  _passwordFocusNode.unfocus();
                },
                label: "Enter Password",
                keyboardType: TextInputType.visiblePassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
                fieldFocusNode: _passwordFocusNode,
                isPassword: true,
              ),
              SizedBox(height: 32.h),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 55.h),
                  backgroundColor: const Color(0xFF1F41BB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 32.h),
              Row(
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
              SizedBox(height: 32.h),
              Container(
                height: 60.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFCACACA)),
                  color: const Color(0xFFF1F1F1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.facebook, size: 28.w, color: Color(0xFF0866FF)),
                    SizedBox(width: 10.w),
                    Text(
                      'Continue with Facebook',
                      style: TextStyle(
                        color: const Color(0xFF797878),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              Container(
                height: 60.h,
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
                      'Continue with Google',
                      style: TextStyle(
                        color: const Color(0xFF797878),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Dont't have an account?  ",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFF797878),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.registerRoute);
                    },
                    child: Text(
                      "Create Account",
                      style: TextStyle(
                        color: const Color(0xFF1F41BB),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
