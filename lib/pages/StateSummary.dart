import 'package:flutter/material.dart';
import 'package:coronavirusdatatracker/data.dart';

class stateSummary extends StatefulWidget {
  @override
  _stateSummaryState createState() => _stateSummaryState();
}

class _stateSummaryState extends State<stateSummary> {
  @override
  Widget build(BuildContext context) {

    Map rcvdData = ModalRoute.of(context).settings.arguments;

    String txt = "Try again later";

    List countries = rcvdData["Countries"];

    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
            itemCount: countries.length,
            itemBuilder: (context,index)=>Container(
          child:
          rcvdData!={}?
          Text("${countries[index]["Country"]}")
              :
           Text(txt)
        )),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/');
          },
          child: Text("Home")),
      ),
    );
  }
}
