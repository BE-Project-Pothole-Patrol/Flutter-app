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
    required this.onPlaceSelect,
  });

  final double width;
  final double marginTop;
  final Function(String) onPlaceSelect;

  Future<List<List<String>>> _fetchQueryMatches(String query) async {
    String encodedQuery = query.trim().replaceAll(" ", "%20");
    final userLocation = await LocationUtil.getUserLocation();
    String autocompleteUrl =
        "${Constants.placesAutocompleteBaseUrl}?input=$encodedQuery&radius=4000000&location=${userLocation.latitude}%2C${userLocation.longitude}&key=${Constants.apiKey}";

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
    return Material(
      child: Container(
        margin: EdgeInsets.only(top: marginTop),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        width: width,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          border: Border.all(color: kWhiteDark,width: 2),
        ),
        child: Autocomplete<String>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            debugPrint(textEditingValue.text);
    
            if (textEditingValue.text.isEmpty) {
              return const Iterable<String>.empty();
            }
    
            return [textEditingValue.text];
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
                  child: FutureBuilder(
                    future: _fetchQueryMatches(options.first),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return ListTile(
                              title: Text('Error: ${snapshot.error}'));
                        } else {
                          return ListView.builder(
                            itemCount: snapshot.data?.length,
                            prototypeItem: const ListTile(
                              title: Text(""),
                            ),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  onSelected(snapshot.data![index].first);
                                  onPlaceSelect(snapshot.data![index].last);
                                },
                                child: ListTile(
                                  title: Text(snapshot.data![index].first),
                                ),
                              );
                            },
                          );
                        }
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
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
      ),
    );
  }
}
