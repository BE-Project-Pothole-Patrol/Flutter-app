import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dropdown_search/dropdown_search.dart';

import '../../../models/phone_code_model.dart';
import '../../../themes/theme_constants.dart';

class UserInputForOtp extends StatelessWidget {
  const UserInputForOtp({
    super.key,
    required this.list,
    required this.isError,
    required this.error,
    required this.onTextChanged,
    required this.onSelectionChanged,
  });

  final List<PhoneCodeModel> list;
  final bool isError;
  final String error;
  final Function(String) onTextChanged;
  final Function(String) onSelectionChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              flex: 35,
              child: DropdownSearch<PhoneCodeModel>(
                popupProps: PopupProps.menu(
                  searchFieldProps: TextFieldProps(
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                      hintText: "Country",
                      hintStyle: Theme.of(context)
                          .inputDecorationTheme
                          .hintStyle
                          ?.copyWith(
                            fontSize: 14,
                          ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                  ),
                  showSearchBox: true,
                ),
                onChanged: (value) {
                  debugPrint('Selected Value $value, code ${value?.phoneCode}');
                  onSelectionChanged(value?.phoneCode ?? '91');
                },
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
                onChanged: (value) {
                  onTextChanged(value);
                },
                textAlignVertical: TextAlignVertical.bottom,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLength: 10,
                decoration: InputDecoration(
                  hintText: 'Enter Your No.',
                  errorText: isError ? '' : null,
                  errorStyle: const TextStyle(
                    height: 0,
                  ),
                  hintStyle: Theme.of(context)
                      .inputDecorationTheme
                      .hintStyle
                      ?.copyWith(
                        fontSize: 14,
                      ),
                  counterText: "",
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 30,
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              error,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: kErrorRed,
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}