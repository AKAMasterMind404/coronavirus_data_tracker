import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:coronavirusdatatracker/data.dart';

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  Map summaryData = {};
  Map vaccinationData = {};

  String covidSummaryString = "https://api.covid19api.com/summary";

  @override
  void initState() {
    getSummary();
    getVaccinationData(411033, 27, 5, 2021);
    super.initState();
  }

  Future<void> getVaccinationData(int pincode, int day, int month, int year) async {
    String vaccinationDetailsString =
        "https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/calendarByPin?" +
            "pincode=" +
            pincode.toString() +
            "&date=" +
            day.toString() +
            "-" +
            month.toString() +
            "-" +
            year.toString();

    Response r2 = await get(Uri.parse(vaccinationDetailsString));
    Map vd = jsonDecode(r2.body);

    setState(() {
      vaccinationData = vd;
    });
  }

  Future<void> getSummary() async {
    Response r1 = await get(Uri.parse(covidSummaryString));
    Map cs = jsonDecode(r1.body);

    setState(() {
      summaryData = cs;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(vaccinationData);
    double d = MediaQuery.of(context).size.aspectRatio*30;
    double h = MediaQuery.of(context).size.width/2.2;
    int gRange = 100;

//    print(summaryData);
    return SafeArea(
      child: Scaffold(
          body: summaryData.isEmpty
              ? Center(child: Text("Loading...."))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // CORONAVIRUS LOGO
                    Center(
                      child: Container(
                          child:
                              Image.asset("lib/assets/coronavirus_logo.jpg")),
                    ),
                    // </CORONAVIRUS LOGO>

                    Padding(
                      padding: const EdgeInsets.all(6),
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Text(
                          "Global Statistics",
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.aspectRatio*40,
                              fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(6),
                          width: MediaQuery.of(context).size.width*(1/3),
                          height: h,
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                boxShadow: [BoxShadow(offset: Offset(2,2), color: Colors.grey[300])],
                                color: Colors.grey[gRange],
                                borderRadius: BorderRadius.circular(6)
                            ),
                            child: NumberColumn(
                                fsize: d,
                                cases: summaryData["Global"]["TotalConfirmed"],
                                acr: "c"),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(6),
                          width: MediaQuery.of(context).size.width*(1/3),
                          height: h,
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                boxShadow: [BoxShadow(offset: Offset(2,2), color: Colors.grey[300])],
                                color: Colors.grey[gRange],
                                borderRadius: BorderRadius.circular(6)
                            ),
                            child: NumberColumn(
                                fsize:d,
                                cases: summaryData["Global"]["TotalDeaths"],
                                acr: "d"),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(6),
                          width: MediaQuery.of(context).size.width*(1/3),
                          height: h,
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                boxShadow: [BoxShadow(offset: Offset(2,2), color: Colors.grey[300])],
                                color: Colors.grey[gRange],
                                borderRadius: BorderRadius.circular(6)
                            ),
                            child: NumberColumn(
                                fsize:d,
                                cases: summaryData["Global"]["TotalRecovered"],
                                acr: "r"),
                          ),
                        ),
                      ],
                    ),

                  ],
                )),
    );
  }
}
