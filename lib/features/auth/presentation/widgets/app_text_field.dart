import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 1. CONVERTED TO STATEFUL WIDGET
class AppTextField extends StatefulWidget {
  final TextEditingController fieldController;
  final FocusNode fieldFocusNode;
  final Function(String)? onFieldSubmitted;
  final String label;
  final FormFieldValidator<String>? validator;
  final int maxLines;
  final TextInputType keyboardType;
  final bool isPassword; // NEW: Flag for password field

  const AppTextField({
    super.key,
    required this.fieldController,
    required this.onFieldSubmitted,
    required this.label,
    required this.validator,
    required this.fieldFocusNode,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.isPassword = false, // Default is false
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  // 2. STATE VARIABLE TO TOGGLE VISIBILITY
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    // Initialize _obscureText based on the isPassword property
    _obscureText = widget.isPassword;
  }

  // 3. WIDGET BUILDER
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.fieldController,
      validator: widget.validator,
      focusNode: widget.fieldFocusNode,
      onFieldSubmitted: widget.onFieldSubmitted,

      // 4. CORE PASSWORD LOGIC
      // Only obscure text if it's a password field AND the toggle is set to hide
      obscureText: _obscureText,

      textInputAction: TextInputAction.next,
      keyboardType: widget.maxLines > 1
          ? TextInputType.multiline
          : widget.keyboardType,
      maxLines: widget.maxLines,

      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(14.r),
        alignLabelWithHint: true,
        label: Text(
          widget.label,
          style: const TextStyle(color: Color(0xFFA7A7A7)),
        ),
        filled: true,
        fillColor: const Color(0xFFFFFFFF),

        // 5. CONDITIONAL SUFFIX ICON (EYE ICON)
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: const Color(0xFFA7A7A7), // Gray icon color
                ),
                onPressed: () {
                  // Toggle the password visibility state
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null, // No icon if it's not a password field
        // Borders remain unchanged from your original request,
        // using BorderRadius.circular(10)
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFCACACA)),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFCACACA)),
          borderRadius: BorderRadius.circular(10),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFCACACA)),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
