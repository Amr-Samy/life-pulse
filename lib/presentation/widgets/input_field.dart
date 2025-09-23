import 'package:life_pulse/presentation/resources/index.dart';

class InputField extends StatelessWidget {
  InputField({
    super.key,
    required this.controller,
    this.prefix,
    this.keyboardType,
    required this.hintText,
    this.isTextHidden = false,
    this.validator,
    this.enableOptions,
    this.onSuffixTap,
    this.onFieldSubmitted,
    this.suffix,
    this.inputAction,
    this.onChange,
    this.maxLength,
    this.contentPadding,
    this.enabled,
    this.fontSize,
    this.readOnly,
    this.onTap,
    this.labelText,
    this.focusNode,
  });

  final TextEditingController controller;
  final FocusNode? focusNode;
  final Widget? prefix;
  final Widget? suffix;
  final int? maxLength;
  final double? contentPadding;
  final double? fontSize;
  bool isTextHidden;
  String? Function(String? value)? validator;
  final TextInputType? keyboardType;
  final TextInputAction? inputAction;
  final String? hintText;
  final String? labelText;
  bool? enableOptions;
  bool? enabled;
  bool? readOnly;
  Function()? onSuffixTap;
  Function()? onTap;
  Function(String? value)? onFieldSubmitted;
  Function(String? value)? onChange;

  //todo  onchange apply color filter
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      obscureText: isTextHidden,
      enabled: enabled,
      enableInteractiveSelection: enableOptions,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChange,
      readOnly: readOnly ?? false,
      onTap: onTap,
      keyboardType: keyboardType ?? TextInputType.emailAddress,
      textInputAction: inputAction ?? TextInputAction.done,
      maxLines: 1,
      maxLength:maxLength?? 30,
      style: TextStyle(fontSize: fontSize ?? FontSize.s16),
      decoration: InputDecoration(
        contentPadding:contentPadding !=null? EdgeInsets.symmetric(vertical: contentPadding?? 0) :null,
        counterText: '',
        hintText: hintText,
        errorStyle: TextStyle(fontSize: FontSize.s14),
        //labelText: labelText,
        //labelStyle: TextStyle(fontSize: FontSize.s16),
        floatingLabelBehavior: FloatingLabelBehavior.auto, //labelText != null ? FloatingLabelBehavior.always :
        prefixIcon: prefix,
        prefixIconColor: MaterialStateColor.resolveWith((states) =>
        states.contains(MaterialState.focused)
            ? ColorManager.primary
            : Colors.grey
        ),
        suffixIcon: Visibility(
          visible: suffix != null ? true : false,
          child: GestureDetector(
            onTap: onSuffixTap,
              child: suffix
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blueGrey.shade50)
        ),
        suffixIconColor: MaterialStateColor.resolveWith((states) =>
        states.contains(MaterialState.focused)
            ? ColorManager.primary
            : Colors.grey
        ),
      ),
    );
  }
}