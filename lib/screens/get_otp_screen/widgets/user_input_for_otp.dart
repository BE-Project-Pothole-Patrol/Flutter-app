import 'package:app/themes/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dropdown_search/dropdown_search.dart';

import '../../../models/phone_code_model.dart';

class UserInputForOtp extends StatefulWidget {
  const UserInputForOtp({
    super.key,
    required this.list,
  });

  final List<PhoneCodeModel> list;

  @override
  State<UserInputForOtp> createState() => _UserInputForOtpState();
}

class _UserInputForOtpState extends State<UserInputForOtp> {
  final _controller = TextEditingController();

  bool _validate = false;
  String _validationErr = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
                },
                dropdownDecoratorProps: const DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(),
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.bottom,
                ),
                items: widget.list,
                selectedItem: widget.list[0],
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
                  debugPrint(value);

                  if (value.isEmpty) {
                    setState(() {
                      _validate = true;
                      _validationErr = "Can't be empty!";
                    });
                  } else if (value.length < 10) {
                    setState(() {
                      _validate = true;
                      _validationErr = "Number must be of 10 digits";
                    });
                  }else{
                    setState(() {
                      _validate = false;
                      _validationErr = "";
                    });
                  }
                },
                textAlignVertical: TextAlignVertical.bottom,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLength: 10,
                decoration: InputDecoration(
                  hintText: 'Enter Your No.',
                  errorText: _validate ? '' : null,
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
              _validationErr,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: kErrorRed,
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
            ),
          ),
        )
      ],
    );
  }
}
