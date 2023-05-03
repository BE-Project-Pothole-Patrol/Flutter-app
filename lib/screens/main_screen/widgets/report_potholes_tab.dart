import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';

import '../../../routing/args/camera_screen_args.dart';
import '../../../themes/theme_constants.dart';
import '../../../utils/notification_util.dart';
import '../../../utils/secure_storage_util.dart';
import '../../../widgets/custom_text_button.dart';
import '../../../utils/constants.dart' as Constants;
import '../../../utils/location_util.dart';

class ReportPotholesTab extends StatefulWidget {
  const ReportPotholesTab({
    super.key,
    required this.camera,
    required this.isPending,
  });

  final CameraDescription camera;
  final Function(bool) isPending;

  @override
  State<ReportPotholesTab> createState() => _ReportPotholesTabState();
}

class _ReportPotholesTabState extends State<ReportPotholesTab> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  bool _isTitleValid = true;
  bool _isReportBtnEnabled = false;
  bool _isImageUriValid = false;
  String _title = '';
  String _desc = '';
  String _imageUri = '';

  @override
  void initState() {
    super.initState();
    debugPrint("Report Potholes Tab initState()");
    _titleController.addListener(_onTitleChange);
    _descriptionController.addListener(_onDescriptionChange);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> reportPothole(String title, String descripton,
      Map<String, dynamic> geoLocation, File imageFile) async {
    String token = await SecureStorageUtil.getCurrentAccessToken();

    final req =
        http.MultipartRequest('POST', Uri.parse(Constants.localReportPotholeUrl))
          ..headers['Authorization'] = 'Bearer $token'
          ..fields['title'] = title
          ..fields['desc'] = descripton
          ..fields['geo_location'] = jsonEncode(geoLocation)
          ..files.add(
            http.MultipartFile(
              'road_img',
              imageFile.readAsBytes().asStream(),
              imageFile.lengthSync(),
              filename: basename(imageFile.path),
              contentType: MediaType('image', 'jpg'),
            ),
          );

    final res = await req.send();
    final body = await res.stream.bytesToString();

    // //code just for testing it out
    // final Map<String, dynamic> data = jsonDecode(body);
    if (res.statusCode == 201) {
      debugPrint('Successfully recd. your report!');
      debugPrint(body);
    } else {
      debugPrint('There was some error!');
      throw Exception(body);
    }
  }

  void _onTitleChange() {
    debugPrint('Listening to Title Change ${_titleController.text}');
    String value = _titleController.text;
    if (value.length >= 10) {
      setState(() {
        _isTitleValid = true;
        _isReportBtnEnabled = _isTitleValid && _isImageUriValid;
      });
    } else {
      setState(() {
        _isTitleValid = false;
        _isReportBtnEnabled = false;
      });
    }
    _title = value;
  }

  void _onDescriptionChange() {
    _desc = _descriptionController.text;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.02,
            ),
            Text(
              "Report",
              style: Theme.of(context).textTheme.displayMedium,
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            SizedBox(
              width: size.width * 0.8,
              child: Text(
                "Click a picture of any pothole/damaged road and report",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: kBlackLight.withOpacity(0.7),
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Container(
              padding: const EdgeInsets.all(1),
              width: size.width * 0.8,
              height: size.width * 0.6,
              decoration: BoxDecoration(
                border: Border.all(color: kBorderGrey),
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: GestureDetector(
                onTap: () async {
                  var path = await Navigator.pushNamed(
                    context,
                    "/cameraScreen",
                    arguments: CameraScreenArgs(camera: widget.camera),
                  );

                  if (!mounted || path == null) return;

                  debugPrint(path.toString());

                  setState(() {
                    _imageUri = path as String? ?? '';
                    _isImageUriValid = _imageUri.isNotEmpty;
                    _isReportBtnEnabled = _isTitleValid && _isImageUriValid;
                  });
                },
                child: _imageUri.isEmpty
                    ? Image.asset(
                        "assets/images/upload.jpeg",
                        fit: BoxFit.fill,
                      )
                    : Image.file(File(_imageUri)),
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            SizedBox(
              width: size.width * 0.8,
              child: TextField(
                maxLines: 1,
                maxLength: 50,
                textAlignVertical: TextAlignVertical.bottom,
                controller: _titleController,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                decoration: InputDecoration(
                  counterText: '',
                  hintText: "Enter a Title",
                  hintStyle: Theme.of(context)
                      .inputDecorationTheme
                      .hintStyle
                      ?.copyWith(fontSize: 16),
                  errorText: !_isTitleValid ? "" : null,
                  errorStyle: const TextStyle(
                    height: 0,
                  ),
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 5),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
              ),
            ),
            SizedBox(
              width: size.width * 0.8,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  !_isTitleValid ? "Please Enter at least 10 characters" : '',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: kErrorRed,
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                      ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.00,
            ),
            SizedBox(
              width: size.width * 0.8,
              child: TextField(
                maxLines: 4,
                maxLength: 200,
                textAlignVertical: TextAlignVertical.bottom,
                controller: _descriptionController,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                decoration: InputDecoration(
                  counterText: '',
                  hintText: "Enter a Description (Optional)",
                  hintStyle: Theme.of(context)
                      .inputDecorationTheme
                      .hintStyle
                      ?.copyWith(fontSize: 16),
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 5),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            SizedBox(
              width: size.width * 0.8,
              child: CustomTextButton(
                text: "Submit & Report",
                size: size,
                hidePrefImage: true,
                isEnabled: _isReportBtnEnabled,
                onTap: () async {
                  debugPrint('Reporting... $_title $_desc');
                  
                  widget.isPending(true);

                  LocationUtil.getUserLocation().then((value) {
                    SecureStorageUtil.saveLastAccessedLocation("${value.latitude} ${value.longitude}");
                    Map<String, dynamic> geoLocation = {
                      'type': 'Point',
                      'coordinates': [value.longitude, value.latitude],
                    };

                    reportPothole(_title, _desc, geoLocation, File(_imageUri))
                        .then((value) {
                      debugPrint('Success!');
                      widget.isPending(false);
                      _titleController.clear();
                      _descriptionController.clear();

                      setState(() {
                        _isTitleValid = true;
                        _isImageUriValid = false;
                        _isReportBtnEnabled = false;
                        _title = '';
                        _desc = '';
                        _imageUri = '';
                      });

                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Your report has been received"),
                      ));
                    }).catchError((e) {
                      debugPrint('There was some error!');
                      debugPrint(e.toString());
                    });
                  }).catchError((e) {
                    debugPrint(e.toString());
                  }).whenComplete(() => widget.isPending(false));
                },
              ),
            ),
            SizedBox(
              height: size.height * 0.3,
            )
          ],
        ),
      ),
    );
  }
}
