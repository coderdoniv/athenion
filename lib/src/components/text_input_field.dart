import 'package:athenion/src/components/size_fade_switcher.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextInputField extends StatelessWidget {
  const TextInputField(
      {this.errorText,
      required this.hintText,
      this.obscureText = false,
      required this.controller,
      this.keyboardType = TextInputType.text,
      this.minLines = 1,
      this.maxLines = 1,
      this.enabled = true,
      this.prefixIcon,
      this.suffixIcon,
      this.focusNode,
      this.autofocus = false,
      super.key});

  final String hintText;
  final bool obscureText;
  final String? errorText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final int minLines;
  final int maxLines;
  final bool enabled;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final FocusNode? focusNode;
  final bool autofocus;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFD0D0D0))),
          child: TextField(
            controller: controller,
            minLines: minLines,
            maxLines: maxLines,
            enabled: enabled,
            obscureText: obscureText,
            keyboardType: keyboardType,
            focusNode: focusNode,
            autofocus: autofocus,
            style: GoogleFonts.montserrat(fontSize: 14),
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
                hintStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFC2C2C2),
                )),
          ),
        ),
        SizeFadeSwitcher(errorText != null
            ? Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
                child: Text(errorText!,
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.error)),
              )
            : const SizedBox.shrink())
      ],
    );
  }
}
