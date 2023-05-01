import 'package:flutter/material.dart';

import '../../../themes/theme_constants.dart';
import '../../../services/google_maps_api.dart';

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
          borderRadius: const BorderRadius.all(Radius.circular(20)),
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
                    future: GoogleMapsApi.fetchQueryMatches(options.first),
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
