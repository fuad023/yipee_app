import 'package:flutter/material.dart';

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String output = "0";
  String _output = "0";
  double num1 = 0;
  double num2 = 0;
  String operand = "";

  buttonPressed(String buttonText) {
    if (buttonText == "C") {
      _output = "0";
      num1 = 0;
      num2 = 0;
      operand = "";
    } else if (buttonText == "⌫") {
      _output = _output.length > 1 ? _output.substring(0, _output.length - 1) : "0";
    } else if (buttonText == "=") {
      num2 = double.parse(_output);
      if (operand == "+") {
        _output = (num1 + num2).toString();
      } else if (operand == "-") {
        _output = (num1 - num2).toString();
      } else if (operand == "×") {
        _output = (num1 * num2).toString();
      } else if (operand == "÷") {
        _output = (num2 != 0) ? (num1 / num2).toString() : "Error";
      }
      num1 = 0;
      num2 = 0;
      operand = "";
    } else if (buttonText == "+" || buttonText == "-" || buttonText == "×" || buttonText == "÷") {
      num1 = double.parse(_output);
      operand = buttonText;
      _output = "0";
    } else {
      _output = (_output == "0") ? buttonText : _output + buttonText;
    }
    setState(() {
      output = _output;
    });
  }

  Widget buildButton(String text, Color color) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => buttonPressed(text),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
          backgroundColor: color,
        ),
        child: Text(text, style: const TextStyle(fontSize: 48)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Calculator")),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
            child: Text(output, style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold)),
          ),
          const Expanded(child: Divider()),
          Column(
            children: [
              Row(children: [buildButton("7", Colors.white), buildButton("8", Colors.white), buildButton("9", Colors.white), buildButton("÷", Colors.black)]),
              Row(children: [buildButton("4", Colors.white), buildButton("5", Colors.white), buildButton("6", Colors.white), buildButton("×", Colors.black)]),
              Row(children: [buildButton("1", Colors.white), buildButton("2", Colors.white), buildButton("3", Colors.white), buildButton("-", Colors.black)]),
              Row(children: [buildButton("C", Colors.white), buildButton("0", Colors.white), buildButton("=", Colors.white), buildButton("+", Colors.black)]),
            ],
          ),
        ],
      ),
    );
  }
}