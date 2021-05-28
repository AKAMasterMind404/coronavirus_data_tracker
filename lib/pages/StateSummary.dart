import 'package:flutter/material.dart';
import 'package:coronavirusdatatracker/data.dart';

class stateSummary extends StatefulWidget {
  @override
  _stateSummaryState createState() => _stateSummaryState();
}

class _stateSummaryState extends State<stateSummary> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Text("STATE SUMMARY"),
            ElevatedButton(onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
                child: Text("Home"))],
        ),
      ),
    );
  }
}

