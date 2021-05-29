import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:coronavirusdatatracker/data.dart';
import 'package:coronavirusdatatracker/pages/StateSummary.dart';

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  Map summaryData = {};
  Map vaccinationData = {};

  String covidSummaryString = "https://api.covid19api.com/summary";
  String testURLvaccination = "https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/calendarByPin?pincode=411033&date=29-5-2021";


  @override
  void initState() {
    getSummary();
    getVaccinationData(411033, 29, 5, 2021);
    super.initState();
  }

  Future<void> getVaccinationData(
      int pincode, int day, int month, int year) async {
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
//    print(MediaQuery.of(context).size.width*0.035);
    double bigText = MediaQuery.of(context).size.width / 25;
    double d = MediaQuery.of(context).size.width * 0.035;
    double h = MediaQuery.of(context).size.width / 2.6;
    int gRange = 100;
    double dividend = 1.5;
    double nationalStats = MediaQuery.of(context).size.width;
//    print(summaryData);
    bool O = MediaQuery.of(context).orientation == Orientation.portrait;
    if(O){
      nationalStats*=2;
//      dividend=1.0;
    }

    double ww = MediaQuery.of(context).size.width;
    double hh = MediaQuery.of(context).size.height;

//    print(ww);
//    print(hh);

    List<Widget> c = [

      /// COUNTRY SUMMARY
      InkWell(
        onTap: () {
          Navigator.pushReplacementNamed(
              context,
              "stateSummary",arguments: summaryData//{"name" : "Bijendra", "rollNo": 65210}
              );
        },
        child: Container(
          padding: EdgeInsets.all(5),
          height: h / dividend,
          width: nationalStats,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      "lib/assets/book1.jpg",
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Summary",
                      style: TextStyle(),
                    ),
                Text("Lorem Ipsum"),
                  ],
                ),
              ],
            ),
            decoration: BoxDecoration(
              // BORDER COLOR
              border: Border.all(
                color: Colors.grey[300],
              ),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(offset: Offset(2, 2), color: Colors.grey[200])
              ],
              color: Colors.grey[100],
            ),
          ),
        ),
      ),

      /// VACCINATION
      InkWell(
        onTap: () {
          Navigator.pushReplacementNamed(context, 'vaccination');
        },
        child: Container(
          padding: EdgeInsets.all(5),
          height: h / dividend,
          width: nationalStats,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      "lib/assets/medical2.jpg",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Vaccination",
                      style: TextStyle(),
                    ),
                    Container(child:Text("Lorem Ipsum"))
                  ],
                ),
              ],
            ),
            decoration: BoxDecoration(
              // BORDER COLOR
              border: Border.all(
                color: Colors.grey[300],
              ),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(offset: Offset(2, 2), color: Colors.grey[200])
              ],
              color: Colors.grey[100],
            ),
          ),
        ),
      ),

    ];

    return SafeArea(
      child: Scaffold(
          body: summaryData.isEmpty
              ? Center(child: Text("Loading...."))
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // CORONAVIRUS LOGO
                      Center(
                        child: Container(
                            height: h,
                            width: MediaQuery.of(context).size.width,
                            child: Image.asset(
                              "lib/assets/coronavirus_logo.jpg",
                              fit: BoxFit.fill,
                            )),
                      ),
                      // </CORONAVIRUS LOGO>

                      Padding(
                        padding: EdgeInsets.only(bottom: 6, left: 20),
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Text(
                            "Global Statistics",
                            style: TextStyle(
                              fontSize: bigText,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(6),
                            width: MediaQuery.of(context).size.width * (1 / 3),
                            child: Container(
                              height: h,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(2, 2),
                                        color: Colors.grey[300])
                                  ],
                                  color: Colors.grey[gRange],
                                  borderRadius: BorderRadius.circular(6)),
                              child: NumberColumn(
                                  fsize: d,
                                  cases: summaryData["Global"]
                                      ["TotalConfirmed"],
                                  acr: "c"),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(6),
                            width: MediaQuery.of(context).size.width * (1 / 3),
                            child: Container(
                              height: h,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(2, 2),
                                        color: Colors.grey[300])
                                  ],
                                  color: Colors.grey[gRange],
                                  borderRadius: BorderRadius.circular(6)),
                              child: NumberColumn(
                                  fsize: d,
                                  cases: summaryData["Global"]["TotalDeaths"],
                                  acr: "d"),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(6),
                            width: MediaQuery.of(context).size.width * (1 / 3),
                            child: Container(
                              height: h,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(2, 2),
                                        color: Colors.grey[300])
                                  ],
                                  color: Colors.grey[gRange],
                                  borderRadius: BorderRadius.circular(6)),
                              child: NumberColumn(
                                  fsize: d,
                                  cases: summaryData["Global"]
                                      ["TotalRecovered"],
                                  acr: "r"),
                            ),
                          ),
                        ],
                      ),
//                      O ?
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 6, left: 20),
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Text(
                                "Country Wise Statistics",
                                style: TextStyle(
                                  fontSize: bigText,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          /// COUNTRY SUMMARY
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context,
                                  "stateSummary",arguments: summaryData//{"name" : "Bijendra", "rollNo": 65210}
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              height: h / dividend,
                              width: nationalStats,
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child: Image.asset(
                                          "lib/assets/book1.jpg",
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Summary",
                                          style: TextStyle(),
                                        ),
                                        Text("Lorem Ipsum"),
                                      ],
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  // BORDER COLOR
                                  border: Border.all(
                                    color: Colors.grey[300],
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(offset: Offset(2, 2), color: Colors.grey[200])
                                  ],
                                  color: Colors.grey[100],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 6, left: 20),
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Text(
                                "Vaccination Data",
                                style: TextStyle(
                                  fontSize: bigText,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          /// VACCINATION
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacementNamed(context, 'vaccination');
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              height: h / dividend,
                              width: nationalStats,
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child: Image.asset(
                                          "lib/assets/medical2.jpg",
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Vaccination",
                                          style: TextStyle(),
                                        ),
                                        Container(child:Text("Lorem Ipsum"))
                                      ],
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  // BORDER COLOR
                                  border: Border.all(
                                    color: Colors.grey[300],
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(offset: Offset(2, 2), color: Colors.grey[200])
                                  ],
                                  color: Colors.grey[100],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                  ],
              ),
        )),
    );
  }
}