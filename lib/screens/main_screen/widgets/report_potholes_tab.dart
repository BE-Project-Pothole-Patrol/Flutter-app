import 'package:flutter/material.dart';

class ReportPotholesTab extends StatefulWidget {
  const ReportPotholesTab({super.key});

  @override
  State<ReportPotholesTab> createState() => _ReportPotholesTabState();
}

class _ReportPotholesTabState extends State<ReportPotholesTab> {
  @override
  Widget build(BuildContext context) {
        return SingleChildScrollView(
      child: Center(
        child: Container(
          child: Text(
            "Report Potholes Tab",
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
      ),
    );
  }
}