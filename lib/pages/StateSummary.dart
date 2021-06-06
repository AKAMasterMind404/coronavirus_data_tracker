import 'package:flutter/material.dart';
import 'package:coronavirusdatatracker/data.dart';

getContent(Map m, bool s){
  if(s){
    if(m.isEmpty){return Text("No results found");}
    else{
      String countryname = m["Country"];
      return Container(
        margin: EdgeInsets.only(left: 10,right: 10),
        child: Row(
          children: [
            Icon(Icons.album),
            SizedBox(width: 10),
          ],
        ),
      );
    }
  }
  return Text("Please enter something");
}

class stateSummary extends StatefulWidget {
  @override
  _stateSummaryState createState() => _stateSummaryState();
}

class _stateSummaryState extends State<stateSummary> {
  Map toShow = {};
  bool searched = false;

  TextEditingController t = new TextEditingController();
  String entered = "";

  @override
  Widget build(BuildContext context) {
    Map rcvdData = ModalRoute.of(context).settings.arguments;
    String txt = "Try again later";

    List countryData = rcvdData["Countries"];
    Map smallNames = {};

    List countries = [];
    for (int i = 0; i < countryData.length; i++) {
      smallNames[countryData[i]["Country"].toLowerCase()] = i + 1;
      countries.add(countryData[i]["Country"]);
    }
    print(toShow);
    print(searched);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            ///TEXTFIELD AND DECORATION
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Row(
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),

                      /// ON PRESSED
                      ///
                      onPressed: () {
                        /// IMPORTANT:
                        /// This function runs when the search icon is pressed
                        /// OUTCOMES:
                        /// 1. Nothing is entered::OUTPUT->(toShow, searched)={}, false
                        /// 2. Entry is not in the list::OUTPUT->(toShow, searched)={}, true
                        /// 3. Country is found::OUTPUT->(toShow, searched)={DATA}, true
                        var res = smallNames[entered.toLowerCase()];

                        bool b1;
                        Map m1;

                        if (res != null) {
                          int index = res - 1;
                          String countryName = countries[index];
                          setState(() {
                            toShow = countryData[index];
                            searched = true;
                          });
                        } else {
                          if (entered == "") {
                            searched = false;
                          } else {
                            toShow = {};
                            searched = true;
                          }
                        }
                        m1 = toShow;
                        b1 = searched;

                        setState(() {
                          toShow = m1;
                          searched = b1;
                        });
                      } // onPressed
                      ),

                  /// CONTAINER THAT WRAPS TEXTFORMFIELD
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search for a country",
                      ),
                      onChanged: (text) {
                        entered = text;
                      },
                      controller: t,
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      offset: Offset(4, 5),
                      color: Colors.grey[300],
                      blurRadius: 4)
                ],
                borderRadius: BorderRadius.circular(50),
                color: Colors.greenAccent,
              ),
            ),
            Container(
              child: Expanded(
                  child: getContent(toShow, searched)
              ),
            ),
//            Container(
//              child: Text("Hello"),
//              margin: EdgeInsets.all(20),
//              width: MediaQuery.of(context).size.width-40,
//            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
            child: Text("Home")),
      ),
    );
  }
}
