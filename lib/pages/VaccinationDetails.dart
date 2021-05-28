import 'package:flutter/material.dart';
import 'package:coronavirusdatatracker/data.dart';

class vaccinationDetails extends StatefulWidget {
  @override
  _vaccinationDetailsState createState() => _vaccinationDetailsState();
}

class _vaccinationDetailsState extends State<vaccinationDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Text("VACCINATION DETAILS"),
            ElevatedButton(onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
                child: Text("Home"))],
        ),
      ),
    );
  }
}
