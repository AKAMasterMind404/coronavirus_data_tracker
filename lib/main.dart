import 'package:coronavirusdatatracker/pages/StateSummary.dart';
import 'package:coronavirusdatatracker/pages/VaccinationDetails.dart';
import 'package:coronavirusdatatracker/pages/general_Info.dart';
import 'package:coronavirusdatatracker/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:coronavirusdatatracker/data.dart';

void main()=>runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/':(context)=> home(),
      'vaccination':(context)=> vaccinationDetails(),
      'stateSummary':(context)=> stateSummary(),
      'info':(context)=> generalInfo(),
    },
  )
);
