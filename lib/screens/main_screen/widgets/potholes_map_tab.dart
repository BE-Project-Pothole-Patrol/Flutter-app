import 'package:flutter/material.dart';

class PotholesMapTab extends StatefulWidget {
  const PotholesMapTab({super.key});

  @override
  State<PotholesMapTab> createState() => _PotholesMapTabState();
}

class _PotholesMapTabState extends State<PotholesMapTab> {
  @override
  Widget build(BuildContext context) {
        return SingleChildScrollView(
      child: Center(
        child: Container(
          child: Text(
            "Potholes Map Tab",
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
      ),
    );
  }
}