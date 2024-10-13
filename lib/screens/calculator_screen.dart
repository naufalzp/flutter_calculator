import 'package:flutter/material.dart';
import 'package:flutter_calculator/widgets/calculator_button.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _history = '';
  String _expression = '';

  void numClick(String text) {
    setState(() {
      if (_expression.isNotEmpty &&
          isOperator(text) &&
          isOperator(_expression[_expression.length - 1])) {
        _expression = _expression.substring(0, _expression.length - 1) + text;
      } else {
        _expression += text;
      }
    });
  }

  bool isOperator(String text) {
    return text == '+' ||
        text == '-' ||
        text == '*' ||
        text == '/' ||
        text == '%';
  }

  void allClear(String text) {
    setState(() {
      _history = '';
      _expression = '';
    });
  }

  void backspace(String text) {
    setState(() {
      if (_expression.isNotEmpty) {
        _expression = _expression.substring(0, _expression.length - 1);
      }
    });
  }

  void clear(String text) {
    setState(() {
      _expression = '';
    });
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void evaluate(String text) {
    if (_expression.isNotEmpty && RegExp(r'\d$').hasMatch(_expression)) {
      Parser p = Parser();
      try {
        Expression exp = p.parse(_expression);
        ContextModel cm = ContextModel();

        double result = exp.evaluate(EvaluationType.REAL, cm);
        String formattedResult = formatResult(result);

        setState(() {
          _history = _expression;
          _expression = formattedResult;
        });
      } catch (e) {
        _showErrorSnackBar('Invalid expression');
      }
    } else {
      _showErrorSnackBar('Invalid expression');
    }
  }

  String formatResult(double result) {
    if (result == result.roundToDouble()) {
      return result.toStringAsFixed(0);
    } else {
      return result.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E2D3D),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              alignment: const Alignment(1.0, 1.0),
              child: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Text(
                  _history,
                  style: const TextStyle(
                    fontSize: 24,
                    color: Color(0xFFB5BFC7),
                  ),
                ),
              ),
            ),
            Container(
              alignment: const Alignment(1.0, 1.0),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  _expression,
                  style: const TextStyle(
                    fontSize: 48,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CalculatorButton(
                  text: 'AC',
                  fillColor: 0xFF6C757D,
                  textSize: 20,
                  callback: allClear,
                ),
                CalculatorButton(
                  text: 'C',
                  fillColor: 0xFF6C757D,
                  callback: clear,
                ),
                CalculatorButton(
                  text: '%',
                  fillColor: 0xFF394E59,
                  textColor: 0xFF4CAF50,
                  callback: numClick,
                ),
                CalculatorButton(
                  text: '/',
                  fillColor: 0xFF394E59,
                  textColor: 0xFF4CAF50,
                  callback: numClick,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CalculatorButton(
                  text: '7',
                  callback: numClick,
                ),
                CalculatorButton(
                  text: '8',
                  callback: numClick,
                ),
                CalculatorButton(
                  text: '9',
                  callback: numClick,
                ),
                CalculatorButton(
                  text: '*',
                  fillColor: 0xFF394E59,
                  textColor: 0xFF4CAF50,
                  textSize: 24,
                  callback: numClick,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CalculatorButton(
                  text: '4',
                  callback: numClick,
                ),
                CalculatorButton(
                  text: '5',
                  callback: numClick,
                ),
                CalculatorButton(
                  text: '6',
                  callback: numClick,
                ),
                CalculatorButton(
                  text: '-',
                  fillColor: 0xFF394E59,
                  textColor: 0xFF4CAF50,
                  textSize: 38,
                  callback: numClick,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CalculatorButton(
                  text: '1',
                  callback: numClick,
                ),
                CalculatorButton(
                  text: '2',
                  callback: numClick,
                ),
                CalculatorButton(
                  text: '3',
                  callback: numClick,
                ),
                CalculatorButton(
                  text: '+',
                  fillColor: 0xFF394E59,
                  textColor: 0xFF4CAF50,
                  textSize: 30,
                  callback: numClick,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CalculatorButton(
                  text: '.',
                  callback: numClick,
                ),
                CalculatorButton(
                  text: '0',
                  callback: numClick,
                ),
                CalculatorButton(
                  text: '⌫',
                  fillColor: 0xFF394E59,
                  textSize: 20,
                  callback: backspace,
                ),
                CalculatorButton(
                  text: '=',
                  fillColor: 0xFF4CAF50,
                  textColor: 0xFFFFFFFF,
                  callback: evaluate,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
