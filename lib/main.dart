import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

void main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {

  Map m1={};

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData()async{

    Response r = await get(Uri.parse("https://api.covid19api.com/summary"));
    Map d = jsonDecode(r.body);

    setState(() {
      m1 = d;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(m1);
    return SafeArea(
      child: Scaffold(
        body:
          m1.isEmpty?
          Center(child: Text("Loading...."))
          :
          Column(
            children: [
              Center(
                child: Container(
                    child: Image.asset("lib/assets/coronavirus_logo.jpg")
                ),
              )
            ],
          )
      ),
    );
  }
}

