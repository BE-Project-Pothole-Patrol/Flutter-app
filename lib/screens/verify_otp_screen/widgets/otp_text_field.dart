import 'package:flutter/material.dart';

class OtpTextField extends StatelessWidget {
  const OtpTextField({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: width,
          child: TextField(
            textAlignVertical: TextAlignVertical.bottom,
            textAlign:TextAlign.center,
            maxLength: 1,
            style: Theme.of(context).textTheme.bodyLarge,
            decoration: InputDecoration(
              hintText: '.',
              hintStyle:Theme.of(context).inputDecorationTheme.hintStyle?.copyWith(
                fontSize: 17
                ),
              counterText: ''
            ),
          ),
        ),
        SizedBox(
          width: width,
          child: TextField(
            textAlignVertical: TextAlignVertical.bottom,
            textAlign:TextAlign.center,
            maxLength: 1,
            style: Theme.of(context).textTheme.bodyLarge,
            decoration: InputDecoration(
              hintText: '.',
              hintStyle:Theme.of(context).inputDecorationTheme.hintStyle?.copyWith(
                fontSize: 17
                ),
              counterText: ''
            ),
          ),
        ),
        SizedBox(
          width: width,
          child: TextField(
            textAlignVertical: TextAlignVertical.bottom,
            textAlign:TextAlign.center,
            maxLength: 1,
            style: Theme.of(context).textTheme.bodyLarge,
            decoration: InputDecoration(
              hintText: '.',
              hintStyle:Theme.of(context).inputDecorationTheme.hintStyle?.copyWith(
                fontSize: 17
                ),
              counterText: ''
            ),
          ),
        ),
        SizedBox(
          width: width,
          child: TextField(
            textAlignVertical: TextAlignVertical.bottom,
            textAlign:TextAlign.center,
            maxLength: 1,
            style: Theme.of(context).textTheme.bodyLarge,
            decoration: InputDecoration(
              hintText: '.',
              hintStyle:Theme.of(context).inputDecorationTheme.hintStyle?.copyWith(
                fontSize: 17
                ),
              counterText: ''
            ),
          ),
        ),
      ],
    );
  }
}