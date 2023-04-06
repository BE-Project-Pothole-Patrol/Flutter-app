import 'package:flutter/material.dart';

import '../../../themes/theme_constants.dart';

class LocationSearchBar extends StatelessWidget {
  const LocationSearchBar({
    super.key,
    required this.width,
    required this.marginTop,
  });

  final double width;
  final double marginTop;

  static const List<String> _kOptions = <String>[
    'apple',
    'banana',
    'orange',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: marginTop),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      width: width,
      height: 50,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Autocomplete<String>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text == '') {
            return const Iterable<String>.empty();
          }
          return _kOptions.where((String option) {
            return option.contains(textEditingValue.text.toLowerCase());
          });
        },
        onSelected: (String selection) {
          debugPrint('You just selected $selection');
        },
        optionsViewBuilder: (context, onSelected, options) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              elevation: 4.0,
              child: SizedBox(
                width: width * 0.95,
                height: 200,
                child: ListView.builder(
                  itemCount: _kOptions.length,
                  prototypeItem: const ListTile(
                    title: Text(""),
                  ),
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_kOptions[index]),
                    );
                  },
                ),
              ),
            ),
          );
        },
        fieldViewBuilder:
            (context, textEditingController, focusNode, onFieldSubmitted) {
          return TextFormField(
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter item name';
              }
              return null;
            },
            textAlignVertical: TextAlignVertical.bottom,
            decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.location_on,
                size: 35,
                color: kPrimaryColor,
              ),
              hintText: "Search Location",
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
            controller: textEditingController,
            focusNode: focusNode,
          );
        },
      ),
    );
  }
}
