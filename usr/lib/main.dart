import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String output = "0";
  String _output = "0";
  double num1 = 0;
  double num2 = 0;
  String operand = "";

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _output = "0";
        num1 = 0;
        num2 = 0;
        operand = "";
      } else if (buttonText == "+" || buttonText == "-" || buttonText == "/" || buttonText == "x") {
        num1 = double.parse(output);
        operand = buttonText;
        _output = "0";
      } else if (buttonText == ".") {
        if (_output.contains(".")) {
          return;
        } else {
          _output = _output + buttonText;
        }
      } else if (buttonText == "=") {
        num2 = double.parse(output);
        if (operand == "+") {
          _output = (num1 + num2).toString();
        }
        if (operand == "-") {
          _output = (num1 - num2).toString();
        }
        if (operand == "x") {
          _output = (num1 * num2).toString();
        }
        if (operand == "/") {
          _output = (num1 / num2).toString();
        }
        num1 = 0;
        num2 = 0;
        operand = "";
      } else {
        if (_output == "0") {
          _output = buttonText;
        } else {
          _output = _output + buttonText;
        }
      }
      output = _output;
      // Format output to remove .0 if it's a whole number
      if (output.endsWith(".0")) {
        output = output.substring(0, output.length - 2);
      }
    });
  }

  Widget buildButton(String buttonText, {Color buttonColor = Colors.black54, Color textColor = Colors.white}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(24.0),
          ),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(
              vertical: 24.0,
              horizontal: 12.0,
            ),
            child: Text(
              output,
              style: const TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const Expanded(
            child: Divider(),
          ),
          Column(
            children: [
              Row(
                children: [
                  buildButton("C", buttonColor: Colors.grey, textColor: Colors.black),
                  buildButton("+/-", buttonColor: Colors.grey, textColor: Colors.black),
                  buildButton("%", buttonColor: Colors.grey, textColor: Colors.black),
                  buildButton("/", buttonColor: Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton("7"),
                  buildButton("8"),
                  buildButton("9"),
                  buildButton("x", buttonColor: Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton("4"),
                  buildButton("5"),
                  buildButton("6"),
                  buildButton("-", buttonColor: Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton("1"),
                  buildButton("2"),
                  buildButton("3"),
                  buildButton("+", buttonColor: Colors.orange),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                       margin: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                         style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black54,
                            shape: const StadiumBorder(),
                            padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 24),
                          ),
                        onPressed: () => buttonPressed("0"),
                        child: const Text(
                          "0",
                          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  buildButton("."),
                  buildButton("=", buttonColor: Colors.orange),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
