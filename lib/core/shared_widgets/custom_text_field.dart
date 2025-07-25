import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant_task/core/utils/app_colors.dart';
import 'package:restaurant_task/core/utils/constants.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final String? helperText;
  final String? errorText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final void Function()? onTap;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool obscureText;
  final bool readOnly;
  final bool enabled;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? prefixText;
  final String? suffixText;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? border;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final Color? fillColor;
  final bool filled;
  final TextStyle? textStyle;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final List<TextInputFormatter>? inputFormatters;
  final bool autofocus;
  final FocusNode? focusNode;
  final TextCapitalization textCapitalization;

  const CustomTextField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.helperText,
    this.errorText,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixText,
    this.suffixText,
    this.contentPadding,
    this.border,
    this.focusedBorder,
    this.errorBorder,
    this.fillColor,
    this.filled = true,
    this.textStyle,
    this.labelStyle,
    this.hintStyle,
    this.inputFormatters,
    this.autofocus = false,
    this.focusNode,
    this.textCapitalization = TextCapitalization.none,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = false;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final defaultBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(Constants.borderRadius),
      borderSide: const BorderSide(color: AppColors.outline, width: 1),
    );

    final focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(Constants.borderRadius),
      borderSide: const BorderSide(color: AppColors.primary, width: 2),
    );

    final errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(Constants.borderRadius),
      borderSide: const BorderSide(color: AppColors.error, width: 1),
    );

    final focusedErrorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(Constants.borderRadius),
      borderSide: const BorderSide(color: AppColors.error, width: 2),
    );

    return TextFormField(
      controller: widget.controller,
      focusNode: _focusNode,
      validator: widget.validator,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      onTap: widget.onTap,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      obscureText: _obscureText,
      readOnly: widget.readOnly,
      enabled: widget.enabled,
      maxLines: widget.obscureText ? 1 : widget.maxLines,
      minLines: widget.minLines,
      maxLength: widget.maxLength,
      inputFormatters: widget.inputFormatters,
      autofocus: widget.autofocus,
      textCapitalization: widget.textCapitalization,
      style: widget.textStyle ?? const TextStyle(
        fontSize: Constants.fontSizeLarge,
        color: AppColors.textPrimary,
      ),
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        helperText: widget.helperText,
        errorText: widget.errorText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: AppColors.iconSecondary,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : widget.suffixIcon,
        prefixText: widget.prefixText,
        suffixText: widget.suffixText,
        contentPadding: widget.contentPadding ?? const EdgeInsets.symmetric(
          horizontal: Constants.paddingLarge,
          vertical: Constants.paddingMedium,
        ),
        border: widget.border ?? defaultBorder,
        enabledBorder: widget.border ?? defaultBorder,
        focusedBorder: widget.focusedBorder ?? focusedBorder,
        errorBorder: widget.errorBorder ?? errorBorder,
        focusedErrorBorder: focusedErrorBorder,
        fillColor: widget.fillColor ?? AppColors.surface,
        filled: widget.filled,
        labelStyle: widget.labelStyle ?? TextStyle(
          color: _focusNode.hasFocus ? AppColors.primary : AppColors.textSecondary,
          fontSize: Constants.fontSizeMedium,
        ),
        hintStyle: widget.hintStyle ?? const TextStyle(
          color: AppColors.textHint,
          fontSize: Constants.fontSizeMedium,
        ),
        helperStyle: const TextStyle(
          color: AppColors.textSecondary,
          fontSize: Constants.fontSizeSmall,
        ),
        errorStyle: const TextStyle(
          color: AppColors.error,
          fontSize: Constants.fontSizeSmall,
        ),
      ),
    );
  }
}

class EmailTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final String? errorText;

  const EmailTextField({
    super.key,
    this.controller,
    this.validator,
    this.onChanged,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      labelText: 'Email Address',
      hintText: 'Enter your email address',
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      prefixIcon: const Icon(Icons.email_outlined),
      validator: validator,
      onChanged: onChanged,
      errorText: errorText,
      textCapitalization: TextCapitalization.none,
    );
  }
}

class PasswordTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final String? labelText;
  final String? errorText;
  final TextInputAction textInputAction;

  const PasswordTextField({
    super.key,
    this.controller,
    this.validator,
    this.onChanged,
    this.labelText,
    this.errorText,
    this.textInputAction = TextInputAction.done,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      labelText: labelText ?? 'Password',
      hintText: 'Enter your password',
      obscureText: true,
      textInputAction: textInputAction,
      prefixIcon: const Icon(Icons.lock_outlined),
      validator: validator,
      onChanged: onChanged,
      errorText: errorText,
    );
  }
}

class SearchTextField extends StatelessWidget {
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final VoidCallback? onClear;
  final String hintText;

  const SearchTextField({
    super.key,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    this.hintText = 'Search...',
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      hintText: hintText,
      prefixIcon: const Icon(Icons.search),
      suffixIcon: controller?.text.isNotEmpty == true
          ? IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                controller?.clear();
                onClear?.call();
              },
            )
          : null,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      textInputAction: TextInputAction.search,
      fillColor: AppColors.surfaceContainer,
    );
  }
} 