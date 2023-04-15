import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/otp_input_provider.dart';

class OtpTextField extends StatefulWidget {
  const OtpTextField({
    super.key,
    required this.width,
  });

  final double width;

  @override
  State<OtpTextField> createState() => _OtpTextFieldState();
}

class _OtpTextFieldState extends State<OtpTextField> {
  late FocusNode focus1;
  late FocusNode focus2;
  late FocusNode focus3;
  late FocusNode focus4;

  @override
  void initState() {
    super.initState();
    focus1 = FocusNode();
    focus2 = FocusNode();
    focus3 = FocusNode();
    focus4 = FocusNode();
  }

  @override
  void dispose() {
    focus1.dispose();
    focus2.dispose();
    focus3.dispose();
    focus4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: widget.width,
          child: TextField(
            focusNode: focus1,
            textAlignVertical: TextAlignVertical.bottom,
            textAlign: TextAlign.center,
            onChanged: (value) {
              context.read<OtpInputProvider>().updateDigit1(value);
              if (value.length == 1) {
                FocusScope.of(context).requestFocus(focus2);
              }
            },
            maxLength: 1,
            style: Theme.of(context).textTheme.bodyLarge,
            decoration: InputDecoration(
                hintText: '.',
                hintStyle: Theme.of(context)
                    .inputDecorationTheme
                    .hintStyle
                    ?.copyWith(fontSize: 17),
                counterText: ''),
          ),
        ),
        SizedBox(
          width: widget.width,
          child: TextField(
            focusNode: focus2,
            onChanged: (value) {
              context.read<OtpInputProvider>().updateDigit2(value);
              if (value.length == 1) {
                FocusScope.of(context).requestFocus(focus3);
              } else {
                FocusScope.of(context).requestFocus(focus1);
              }
            },
            textAlignVertical: TextAlignVertical.bottom,
            textAlign: TextAlign.center,
            maxLength: 1,
            style: Theme.of(context).textTheme.bodyLarge,
            decoration: InputDecoration(
                hintText: '.',
                hintStyle: Theme.of(context)
                    .inputDecorationTheme
                    .hintStyle
                    ?.copyWith(fontSize: 17),
                counterText: ''),
          ),
        ),
        SizedBox(
          width: widget.width,
          child: TextField(
            focusNode: focus3,
            textAlignVertical: TextAlignVertical.bottom,
            textAlign: TextAlign.center,
            onChanged: (value) {
              context.read<OtpInputProvider>().updateDigit3(value);
              if (value.length == 1) {
                FocusScope.of(context).requestFocus(focus4);
              } else {
                FocusScope.of(context).requestFocus(focus2);
              }
            },
            maxLength: 1,
            style: Theme.of(context).textTheme.bodyLarge,
            decoration: InputDecoration(
                hintText: '.',
                hintStyle: Theme.of(context)
                    .inputDecorationTheme
                    .hintStyle
                    ?.copyWith(fontSize: 17),
                counterText: ''),
          ),
        ),
        SizedBox(
          width: widget.width,
          child: TextField(
            focusNode: focus4,
            textAlignVertical: TextAlignVertical.bottom,
            textAlign: TextAlign.center,
            onChanged: (value) {
              context.read<OtpInputProvider>().updateDigit4(value);
              if (value.isEmpty) {
                FocusScope.of(context).requestFocus(focus3);
              }
            },
            maxLength: 1,
            style: Theme.of(context).textTheme.bodyLarge,
            decoration: InputDecoration(
                hintText: '.',
                hintStyle: Theme.of(context)
                    .inputDecorationTheme
                    .hintStyle
                    ?.copyWith(fontSize: 17),
                counterText: ''),
          ),
        ),
      ],
    );
  }
}
