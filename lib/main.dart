import 'package:flutter/material.dart';

void main() {
  runApp(CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.purple,
      ),
      home: Calculadora(),
    );
  }
}

class Calculadora extends StatefulWidget {
  @override
  _CalculadoraState createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  String _output = "0";
  String _temp = "";
  String _operation = "";

  void _onButtonPressed(String value) {
    setState(() {
      if (value == "C") {
        _output = "0";
        _temp = "";
        _operation = "";
      } else if (value == "=") {
        if (_operation.isNotEmpty && _temp.isNotEmpty) {
          double num1 = double.parse(_output);
          double num2 = double.parse(_temp);
          switch (_operation) {
            case "+":
              _output = (num1 + num2).toString();
              break;
            case "-":
              _output = (num1 - num2).toString();
              break;
            case "×":
              _output = (num1 * num2).toString();
              break;
            case "÷":
              _output = (num2 != 0 ? (num1 / num2).toString() : "Error");
              break;
          }
          _temp = "";
          _operation = "";
        }
      } else if (["+", "-", "×", "÷"].contains(value)) {
        _operation = value;
        _temp = "";
      } else {
        if (_operation.isEmpty) {
          _output = _output == "0" ? value : _output + value;
        } else {
          _temp += value;
        }
      }
    });
  }

  Widget _buildButton(String label) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => _onButtonPressed(label),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 207, 78, 230), 
            padding: EdgeInsets.symmetric(vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
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
        title: Text("Cristina Ortiz"),
        centerTitle: true,
        //backgroundColor: const Color.fromARGB(255, 189, 75, 209),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.grey[200],
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(20),
              child: Text(
                _output,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                Row(
                  children: [
                    _buildButton("7"),
                    _buildButton("8"),
                    _buildButton("9"),
                    _buildButton("÷"),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("4"),
                    _buildButton("5"),
                    _buildButton("6"),
                    _buildButton("×"),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("1"),
                    _buildButton("2"),
                    _buildButton("3"),
                    _buildButton("-"),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("C"),
                    _buildButton("0"),
                    _buildButton("="),
                    _buildButton("+"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
