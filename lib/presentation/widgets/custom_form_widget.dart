import 'package:fluent_ui/fluent_ui.dart';

class CustomTextFormBox extends StatelessWidget {
  final String label;
  final String placeholder;
  final Widget? prefix;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;

  const CustomTextFormBox({
    super.key,
    required this.label,
    required this.placeholder,
    this.prefix,
    this.keyboardType,
    this.validator,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return InfoLabel(
      label: label,
      child: TextFormBox(
        placeholder: placeholder,
        prefix: prefix,
        keyboardType: keyboardType,
        validator: validator,
        onSaved: onSaved,
      ),
    );
  }
}
