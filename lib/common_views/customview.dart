import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextView extends StatelessWidget {
  final String data;
  final TextStyle style;
  final int maxLines;
  final TextOverflow overflow;
  final TextAlign textAlign;
  final bool softWrap;

  const TextView(
    this.data, {
    Key key,
    this.style,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.softWrap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      data ?? "",
      style: style,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      softWrap: softWrap,
    );
  }
}

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Color cursorColor;
  final TextStyle style;
  final InputDecoration decoration;
  final bool autofocus;
  final List<TextInputFormatter> inputFormatters;
  final TextAlign textAlign;
  final int maxLines;
  final bool enabled;
  final bool obscureText;
  final ValueChanged<String> onChanged;
  final TextInputAction textInputAction;
  final VoidCallback onEditingComplete;
  final FocusNode focusNode;

  const MyTextField({
    Key key,
    this.controller,
    this.keyboardType,
    this.cursorColor,
    this.style,
    this.decoration:const InputDecoration(),
    this.autofocus:false,
    this.inputFormatters,
    this.textAlign:TextAlign.start,
    this.maxLines:1,
    this.enabled,
    this.obscureText:false,
    this.onChanged,
    this.textInputAction,
    this.onEditingComplete,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      cursorColor: cursorColor,
      style: style,
      decoration: decoration,
      autofocus: autofocus,
      inputFormatters: getInputFormatters(inputFormatters),
      textAlign: textAlign,
      maxLines: maxLines,
      enabled: enabled,
      obscureText: obscureText,
      onChanged: onChanged,
      textInputAction: textInputAction,
      onEditingComplete: onEditingComplete,
      focusNode: focusNode,
    );
  }

  static List<TextInputFormatter> getInputFormatters(List<TextInputFormatter> inputFormatters) {
    if (inputFormatters == null) {
      return [
        WhitelistingTextInputFormatter(RegExp(
            '[\u{0020}-\u{007E}\u{00A0}-\u{00BE}\u{2E80}-\u{A4CF}\u{F900}-\u{FAFF}\u{FE30}-\u{FE4F}\u{FF00}-\u{FFEF}\u{0080}-\u{009F}\u{2000}-\u{201f}]'))
      ];
    } else {
      inputFormatters.add(WhitelistingTextInputFormatter(RegExp(
          '[\u{0020}-\u{007E}\u{00A0}-\u{00BE}\u{2E80}-\u{A4CF}\u{F900}-\u{FAFF}\u{FE30}-\u{FE4F}\u{FF00}-\u{FFEF}\u{0080}-\u{009F}\u{2000}-\u{201f}]')));
      return inputFormatters;
    }
  }
}
