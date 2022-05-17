import 'dart:async';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'dart:math';

void main(){
  runApp(MaterialApp(
    home: brokenCalculator(),
  ));
}

class brokenCalculator extends StatefulWidget {
  const brokenCalculator({ Key? key }) : super(key: key);

  @override
  _brokenCalculatorState createState() => _brokenCalculatorState();
}

class _brokenCalculatorState extends State<brokenCalculator> {

  String expression = '';
  String result = '';

  buttonPressed(String buttonText){
    setState(() {
      getRandomSymbol<T>(List<T> operators) {
      final random = new Random();
      var i = random.nextInt(operators.length);
      return operators[i];
      }
      var operators = ['+','-','x','÷'];
      var randomOperator = getRandomSymbol(operators);


      getRandomnumber<T>(List<T> numbers) {
      final random = new Random();
      var i = random.nextInt(numbers.length);
      return numbers[i];
      }
      var numbers = ['1','2','3','4','5','6','7','8','9','0',];
      var nums = getRandomnumber(numbers);


      if(buttonText == 'AC'){
        expression = '';
        result = '';
      }
      else if(buttonText == '⌫'){
        result = result.substring(0,result.length-1);
      }
      else if(buttonText == '='){
        expression = result;
        expression = expression.replaceAll('x', '*');
        expression = expression.replaceAll('÷', '/');

        try{
          Parser p =Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm).toStringAsFixed(2)}';
        }
        catch(e){
          result = 'error';
        }
        expression = expression.replaceAll('*', 'x');
        expression = expression.replaceAll('/', '÷');
      }
      else if(buttonText=='+'  ||  buttonText=='-'  ||  buttonText=='x'  ||  buttonText=='÷'){
        result = result + randomOperator;
      }
      else{
        result = result + nums;
      }
    });
  }

  Widget buildButton(String buttonText, Color? buttonColor){
    return Container(
      height: 80,
      width: 80,
      child: FittedBox(
        child: FloatingActionButton(
          onPressed: () => buttonPressed(buttonText),
          backgroundColor: buttonColor,
          child: Text(buttonText),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueGrey[900],
        title: const Text('Broken Calculator'),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0,0,10,0),
              child: Container(
                color: Colors.blueGrey[900],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 90),
                    Text(
                      '$expression',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white54,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '$result',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 50,
                        color: Colors.white
                      ),
                    )
                  ],
                )

              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              color: Colors.blueGrey[800],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildButton('AC', Colors.blueGrey[900]),
                      buildButton('⌫', Colors.blueGrey[900]),
                      Container(
                        height: 80,
                        width: 80,
                        child: FittedBox(
                          child: Text(''),
                        ),
                      ),
                      buildButton('÷', Colors.white54),
                    ],
                  ),
                  Row(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildButton('7', Colors.blueGrey[900]),
                      buildButton('8', Colors.blueGrey[900]),
                      buildButton('9', Colors.blueGrey[900]),
                      buildButton('x', Colors.white54),
                    ],
                  ),
                  Row(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildButton('4', Colors.blueGrey[900]),
                      buildButton('5', Colors.blueGrey[900]),
                      buildButton('6', Colors.blueGrey[900]),
                      buildButton('-', Colors.white54),
                    ],
                  ),
                  Row(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildButton('1', Colors.blueGrey[900]),
                      buildButton('2', Colors.blueGrey[900]),
                      buildButton('3', Colors.blueGrey[900]),
                      buildButton('+', Colors.white54),
                    ],
                  ),
                  Row(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildButton('0', Colors.blueGrey[900]),
                      buildButton('00', Colors.blueGrey[900]),
                      buildButton('.', Colors.blueGrey[900]),
                      buildButton('=', Colors.white54),
                    ],
                  ),
                  const Text(
                    'It\'s Broken... Just like me 🙂',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontFamily: 'Dongle'
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}