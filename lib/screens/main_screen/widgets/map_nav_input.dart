import 'package:flutter/material.dart';

import '../../../services/google_maps_api.dart';
import '../../../themes/theme_constants.dart';

enum TravelMode {
  car,
  bike,
  bus,
  walk,
}

class MapNavInput extends StatefulWidget {
  const MapNavInput({
    super.key,
    required this.size,
    this.mode = TravelMode.car,
    required this.onBackBtnPress,
    required this.onSourceSelect,
    required this.onDestinationSelect,
  });

  final Size size;
  final TravelMode mode;
  final Function(bool) onBackBtnPress;
  final Function(String) onSourceSelect;
  final Function(String) onDestinationSelect;

  @override
  State<MapNavInput> createState() => _MapNavInputState();
}

class _MapNavInputState extends State<MapNavInput> {
  static const List<String> _kOptions = <String>[
    'apple',
    'banana',
    'orange',
  ];

  late TravelMode _mode;

  @override
  void initState() {
    super.initState();
    _mode = widget.mode;
  }

  @override
  void didUpdateWidget(covariant MapNavInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    _mode = widget.mode;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      child: Container(
        width: widget.size.width,
        height: widget.size.height * 0.35,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                widget.onBackBtnPress(false);
              },
              child: const Align(
                alignment: Alignment.topLeft,
                child: Icon(
                  Icons.west,
                  size: 25,
                  color: kBlackLight,
                ),
              ),
            ),
            SizedBox(
              height: widget.size.height * 0.35 * 0.06,
            ),
            Container(
              width: widget.size.width * 0.8,
              height: 50,
              decoration: const BoxDecoration(
                color: kWhiteDark,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text == '') {
                    return const Iterable<String>.empty();
                  }
                  return [textEditingValue.text];
                },
                onSelected: (String selection) {
                  debugPrint('Selected source: $selection');
                },
                optionsViewBuilder: (context, onSelected, options) {
                  return Align(
                    alignment: Alignment.topLeft,
                    child: Material(
                      elevation: 4.0,
                      child: SizedBox(
                        width: widget.size.width * 0.8,
                        height: 200,
                        child: FutureBuilder(
                          future: GoogleMapsApi.fetchQueryMatches(options.first),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.done) {
                              if (snapshot.hasError) {
                                return ListTile(title: Text('Error: ${snapshot.error}'),);
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
                                        widget.onSourceSelect(
                                            snapshot.data![index].last);
                                      },
                                      child: ListTile(title:Text(snapshot.data![index].first),),
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
                fieldViewBuilder: (context, textEditingController, focusNode,
                    onFieldSubmitted) {
                  return TextFormField(
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
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
                      hintText: "Enter Start Location",
                      hintStyle: Theme.of(context).inputDecorationTheme.hintStyle?.copyWith(
                        fontSize: 16,
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
            const SizedBox(
              height: 10,
            ),
            Container(
              width: widget.size.width * 0.8,
              height: 50,
              decoration: const BoxDecoration(
                color: kWhiteDark,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text == '') {
                    return const Iterable<String>.empty();
                  }
                  return [textEditingValue.text];
                },
                onSelected: (String selection) {
                  debugPrint('Selected destination $selection');
                },
                optionsViewBuilder: (context, onSelected, options) {
                  return Align(
                    alignment: Alignment.topLeft,
                    child: Material(
                      elevation: 4.0,
                      child: SizedBox(
                        width: widget.size.width * 0.8,
                        height: 200,
                        child: FutureBuilder(
                          future: GoogleMapsApi.fetchQueryMatches(options.first),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.done) {
                              if (snapshot.hasError) {
                                return ListTile(title: Text('Error: ${snapshot.error}'),);
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
                                        widget.onDestinationSelect(
                                            snapshot.data![index].last);
                                      },
                                      child: ListTile(title:Text(snapshot.data![index].first),),
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
                fieldViewBuilder: (context, textEditingController, focusNode,
                    onFieldSubmitted) {
                  return TextFormField(
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
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
                        color: kDestinationMarkerRed,
                      ),
                      hintText: "Enter Destination Location",
                      hintStyle: Theme.of(context).inputDecorationTheme.hintStyle?.copyWith(
                        fontSize: 16,
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
            const SizedBox(
              height: 12,
            ),
            Expanded(
              child: SizedBox(
                width: widget.size.width * 0.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _mode = TravelMode.car;
                        });
                      },
                      child: Icon(
                        Icons.directions_car,
                        size: 35,
                        color: _mode == TravelMode.car
                            ? kPrimaryColor
                            : Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _mode = TravelMode.bike;
                        });
                      },
                      child: Icon(
                        Icons.two_wheeler,
                        size: 35,
                        color: _mode == TravelMode.bike
                            ? kPrimaryColor
                            : Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _mode = TravelMode.bus;
                        });
                      },
                      child: Icon(
                        Icons.directions_bus,
                        size: 35,
                        color: _mode == TravelMode.bus
                            ? kPrimaryColor
                            : Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _mode = TravelMode.walk;
                        });
                      },
                      child: Icon(
                        Icons.directions_walk,
                        size: 35,
                        color: _mode == TravelMode.walk
                            ? kPrimaryColor
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
