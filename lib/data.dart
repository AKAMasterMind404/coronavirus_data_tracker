import 'package:flutter/material.dart';

String amountParser(int amount) {
  if (amount < 1000) {
    return amount.toString();
  }

  String newamount = amount.toString();

  int rem = newamount.length % 3;

  String init = newamount.substring(0, rem);
  String remain = newamount.substring(rem);

  init != "" ? init += "," : null;

  String ans = "";

  for (int i = 0; i < remain.length; i++) {
    ans += remain[i];
    if (i + 1 != remain.length && (i + 1) % 3 == 0) {
      ans += ",";
    }
  }
  return init + ans;
}
// summaryData["Global"]["TotalConfirmed"]
// Total Confirmed Cases

Column NumberColumn({int cases,String acr, double fsize}) {

  Map m1={
    "d":["Total Deaths",Colors.redAccent,"lib/assets/skull2.png"],  // Total Deaths
    "c":["Total Cases",Colors.orangeAccent,"lib/assets/covid.png"], //  Total Confirmed Cases
    "r":["Recoveries",Colors.greenAccent,"lib/assets/recovered.png"],  // Total Recoveries
  };

  String text = m1[acr][0];

  return Column(
//      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
    Container(
      height: fsize*6,
      child: Image.asset(m1[acr][2], fit: BoxFit.fill,),
    ),
    SizedBox(height: 5,),
    FittedBox(
      fit: BoxFit.fill,
      child: Text(
//      "10",
        "${amountParser(cases)}",
        style: TextStyle(
            color: m1[acr][1], fontWeight: FontWeight.bold,
        fontSize: fsize*0.8,
        ),
      ),
    ),
    SizedBox(height: 5),
    FittedBox(
      fit: BoxFit.fill,
      child: Text(
        text,
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold,
        fontSize: fsize*0.8,
        ),
      ),
    )
    ]
  );
}
//Row(
//mainAxisAlignment: MainAxisAlignment.spaceAround,
//children: [
//Column(children: [
//Text("${amountParser(summaryData["Global"]["TotalDeaths"])}",
//style: TextStyle(
//color: Colors.redAccent,
//fontWeight: FontWeight.bold)),
//Text("Total Deaths",
//style: TextStyle(
//color: Colors.black,
//fontWeight: FontWeight.bold))
//]),
//Column(children: [
//Text("${amountParser(summaryData["Global"]["TotalRecovered"])}",
//style: TextStyle(
//color: Colors.greenAccent,
//fontWeight: FontWeight.bold)),
//Text("Total Recovered",
//style: TextStyle(
//color: Colors.black,
//fontWeight: FontWeight.bold))
//])
//]),