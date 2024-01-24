// ignore_for_file: use_key_in_widget_constructors, todo

import 'package:flutter/material.dart';
import 'dart:math'; // Imported math library to use pi

//https://medium.com/flutter-community/flutter-layout-cheat-sheet-5363348d037e

//This app makes use of the Row, Column,
//Expanded, Padding, Transform, Container,
//BoxDecoration, BoxShape, Colors,
//Border, Center, Align, Alignment,
//EdgeInsets, Text, and TextStyle Widgets
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //first level widget of Material Design
      home: Scaffold(
        //default route
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title: const Text("App1 - UI Layout"),
          backgroundColor: Colors.blue,
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            // Column for Container 1 and 2
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    border: Border.all(width: 3),
                  ),
                  child: const Center(child: Text("Container 1")),
                ),
                Transform.rotate(
                  angle: pi / 4,
                  child: Container(
                    height: 100,
                    width: 100,
                    color: Colors.white,
                    child: const Center(child: Text("Container 2")),
                  ),
                ),
              ],
            ),
            // Column for Container 3 and 4
            Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(
                        10.0), // Padding inside Container 3
                    child: Container(
                      width: 100,
                      color: Colors.yellow,
                      child: const Align(
                        alignment: Alignment.bottomCenter,
                        child: Text("Container 3"),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                    height: 10), // Space between Container 3 and Container 4
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(
                        10.0), // Padding inside Container 4
                    child: Container(
                      width: 100,
                      color: Colors.blue,
                      child: const Align(
                        alignment: Alignment.centerRight,
                        child: Text("Container 4"),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Column for Container 5 and 6
            Column(
              mainAxisSize:
                  MainAxisSize.max, // Column takes the full available height
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      top: 150.0,
                      left: 10.0,
                      right: 10.0,
                      bottom: 40.0), // Fixed padding value
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                    child: const Center(
                      child: Text("Container 5",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
                const SizedBox(
                    height:
                        250), // Fixed space between Container 5 and Container 6
                Expanded(
                  child: Container(
                    width: 100,
                    color: Colors.red,
                    child: const Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.all(1.0), // Padding inside Con 6
                        child: Text(
                          "Con 6",
                          style: TextStyle(fontSize: 30, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
