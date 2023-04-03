import 'package:flutter/material.dart';

import '../../../themes/theme_constants.dart';
import '../../../widgets/custom_text_btn.dart';

class ReportPotholesTab extends StatefulWidget {
  const ReportPotholesTab({super.key});

  @override
  State<ReportPotholesTab> createState() => _ReportPotholesTabState();
}

class _ReportPotholesTabState extends State<ReportPotholesTab> {
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
              child: Image.asset(
                "assets/images/upload.jpeg",
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            SizedBox(
              width: size.width*0.8,
              child: TextField(
                maxLines: 1,
                textAlignVertical: TextAlignVertical.bottom,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500, fontSize: 16,
                ),
                decoration: InputDecoration(
                  hintText: "Enter a Title",
                  hintStyle: Theme.of(context).inputDecorationTheme.hintStyle?.copyWith(fontSize: 16),
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 5),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            SizedBox(
              width: size.width*0.8,
              child: TextField(
                maxLines: 4,
                textAlignVertical: TextAlignVertical.bottom,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500, fontSize: 16,
                ),
                decoration: InputDecoration(
                  hintText: "Enter a Description (Optional)",
                  hintStyle: Theme.of(context).inputDecorationTheme.hintStyle?.copyWith(fontSize: 16),
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
              width: size.width*0.8,
              child: CustomTextBtn(
                text: "Submit & Report",
                size: size,
                hidePrefImage: true,
              ),
            ),
            SizedBox(
              height: size.height*0.3,
            )
          ],
        ),
      ),
    );
  }
}
