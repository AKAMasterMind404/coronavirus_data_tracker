import 'package:flutter/material.dart';
import 'package:coronavirusdatatracker/data.dart';

class generalInfo extends StatefulWidget {
  @override
  _generalInfoState createState() => _generalInfoState();
}

class _generalInfoState extends State<generalInfo> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Text("GENERAL INFO"),
              ElevatedButton(onPressed: () {
                Navigator.pushReplacementNamed(context, '/');
              },
                  child: Text("Home"))],
          ),
        ),
      ),
    );
  }
}
