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
