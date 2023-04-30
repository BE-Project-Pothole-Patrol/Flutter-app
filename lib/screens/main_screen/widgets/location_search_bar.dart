import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../themes/theme_constants.dart';
import '../../../utils/constants.dart' as Constants;
import '../../../utils/location_util.dart';

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

  Future<List<List<String>>> _fetchQueryMatches(String query) async {
    String encodedQuery = query.trim().replaceAll(" ", "%20");
    final geo = await LocationUtil.getUserLocation();
    String autocompleteUrl =
        "${Constants.placesAutocompleteBaseUrl}?input=$encodedQuery&radius=4000000&location=${geo.latitude}%2C${geo.longitude}&key=${Constants.apiKey}";

    final res = await http.get(Uri.parse(autocompleteUrl));

    if (res.statusCode == 200) {
      debugPrint('Success!');
      debugPrint(res.body);

      Map<String, dynamic> data = jsonDecode(res.body);

      List<List<String>> places = [];
      for (final place in data['predictions']) {
        places.add([place['description'], place['place_id']]);
      }

      return places;
    } else {
      debugPrint('There was some error in fetching places...');
      debugPrint(res.body);
      throw Exception('Error :(');
    }
  }

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
          debugPrint(textEditingValue.text);

          if (textEditingValue.text.isEmpty) {
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
                  itemCount: options.length,
                  prototypeItem: const ListTile(
                    title: Text(""),
                  ),
                  itemBuilder: (context, index) {
                    final String option = options.elementAt(index);
                    return GestureDetector(
                      onTap: () => onSelected(option),
                      child: ListTile(
                        title: Text(option),
                      ),
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
                  fontSize: 17,
                ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter item name';
              }
              return null;
            },
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.location_on,
                size: 30,
                color: kPrimaryColor,
              ),
              hintText: "Search Location",
              hintStyle:
                  Theme.of(context).inputDecorationTheme.hintStyle?.copyWith(
                        fontSize: 17,
                      ),
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
