import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dropdown_search/dropdown_search.dart';

class UserInputForOtp extends StatelessWidget {
  const UserInputForOtp({
    super.key,
    required this.list,
  });

  final List<PhoneCodeModel> list;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          flex: 35,
          child: DropdownSearch<PhoneCodeModel>(
            popupProps: const PopupProps.menu(
              showSearchBox: true,
            ),
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(),
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.bottom,
            ),
            items: list,
            selectedItem: list[0],
            dropdownBuilder: (context, selectedItem) {
              return Row(
                children: [
                  SvgPicture.asset(
                    'icons/flags/svg/${selectedItem?.countryCode}.svg',
                    package: 'country_icons',
                    width: 15,
                    height: 15,
                  ),
                  const Spacer(),
                  Text(
                    selectedItem?.phoneCode ?? "NA",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              );
            },
          ),
        ),
        const Expanded(
          flex: 5,
          child: SizedBox(),
        ),
        Expanded(
          flex: 60,
          child: TextField(
            textAlignVertical: TextAlignVertical.bottom,
            style: Theme.of(context).textTheme.bodyMedium,
            decoration: InputDecoration(
              hintText: 'Enter Your No.',
              hintStyle: Theme.of(context).inputDecorationTheme.hintStyle?.copyWith(
                fontSize: 14,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
          ),
        ),
      ],
    );
  }
}

class PhoneCodeModel {
  final int id;
  final String phoneCode;
  final String countryCode;
  final String countryName;

  PhoneCodeModel({
    required this.id,
    required this.phoneCode,
    required this.countryCode,
    required this.countryName,
  });

  ///this method will prevent the override of toString
  String userAsString() {
    return phoneCode;
  }

  bool userFilterByCreationDate(String filter) {
    return phoneCode.toString().contains(filter);
  }

  bool isEqual(PhoneCodeModel model) {
    return id == model.id;
  }

  @override
  String toString() => countryName;
}
