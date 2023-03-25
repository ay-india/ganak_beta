// import 'dart:math' as math;
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;
  void btnclicked(String val) {
    setState(() {
      if (val == "C") {
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      } else if (val == "⌫") {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (val == "=") {
        equationFontSize = 38.0;
        resultFontSize = 48.0;
        expression = equation;
        expression = expression.replaceAll('x', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          //to solve expression we will create object of Parser class
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Invalid Format";
          resultFontSize = 38.0;
        }
      } else {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if (equation == "0") {
          equation = val;
        } else {
          equation = equation + val;
        }
      }
    });
  }

  Widget customButton(String val) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.10,
        child: OutlinedButton(
          // padding: EdgeInsets.all(25.0),
          onPressed: () => btnclicked(val),
          child: Text(
            val,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ganak-Beta",
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.history,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Container(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.20,
              // padding: EdgeInsets.all(20.0),
              alignment: Alignment.centerRight,
              child: Text(
                "$equation",
                style: TextStyle(
                  fontSize: equationFontSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.20,
              alignment: Alignment.bottomRight,
              child: Text(
                "$result",
                style: TextStyle(
                  fontSize: resultFontSize,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          Row(
            children: [
              customButton("÷"),
              customButton("x"),
              customButton("-"),
              customButton("+"),
            ],
          ),
          Row(
            children: [
              customButton("1"),
              customButton("2"),
              customButton("3"),
              customButton("("),
            ],
          ),
          Row(
            children: [
              customButton("4"),
              customButton("5"),
              customButton("6"),
              customButton(")"),
            ],
          ),
          Row(
            children: [
              customButton("7"),
              customButton("8"),
              customButton("9"),
              customButton("C"),
            ],
          ),
          Row(
            children: [
              customButton("."),
              customButton("0"),
              customButton("⌫"),
              customButton("="),
            ],
          ),
        ]),
      ),
    );
  }
}
