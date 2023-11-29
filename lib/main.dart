import 'package:flutter/material.dart';
import 'buttons.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ); // MaterialApp
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userInput = '';
  var answer = '';

// Array of button
  final List<String> buttons = [
    'C',
    '+/-',
    '%',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: new AppBar(
      //   backgroundColor: Colors.purple[900],
      //   centerTitle: true,
      //   title: new Text("Calculator"),
      // ), //AppBar
      backgroundColor: Color(0XFF3E4243),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical:40,horizontal: 10),
              child: const Text(
                'CALCULATOR',
                style: TextStyle(
                  fontSize: 20.0,
                  letterSpacing: 5.0,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(5),
                      alignment: Alignment.centerRight,
                      child: Text(
                        userInput,
                        style: TextStyle(fontSize: 18, color: Colors.white24),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      alignment: Alignment.centerRight,
                      child: Text(
                        answer,
                        style: const TextStyle(
                            fontSize: 50,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ]),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 5.0,
                      crossAxisSpacing: 5.0,
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    // Clear Button
                    if (index == 0) {
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            userInput = '';
                            answer = '0';
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.blue[50],
                        textColor: Colors.black,
                      );
                    }

                    // +/- button
                    else if (index == 1) {
                      return MyButton(
                        buttonText: buttons[index],
                        color: Colors.blue[50],
                        textColor: Colors.black,
                      );
                    }
                    // % Button
                    else if (index == 2) {
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            userInput += buttons[index];
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.blue[50],
                        textColor: Colors.black,
                      );
                    }
                    // Delete Button
                    else if (index == 3) {
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            userInput =
                                userInput.substring(0, userInput.length - 1);
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.blue[50],
                        textColor: Colors.black,
                      );
                    }
                    // Equal_to Button
                    else if (index == 18) {
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            equalPressed();
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.amber,
                        textColor: Colors.white,
                      );
                    }

                    // other buttons
                    else {
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            userInput += buttons[index];
                          });
                        },
                        buttonText: buttons[index],
                        color: isOperator(buttons[index])
                            ? const Color(0XFF4C355F)
                            : Colors.grey[700],
                        textColor: isOperator(buttons[index])
                            ? Colors.white
                            : Colors.black,
                      );
                    }
                  }), // GridView.builder
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

// function to calculate the input operation
  void equalPressed() {
    String finaluserinput = userInput;
    finaluserinput = userInput.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();
  }
}

// import 'dart:ui';
//
// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       home: MyHomePage(title: 'Calculator'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   Widget calcbutton(String btntxt, Color btncolor, Color txtcolor) {
//     return ElevatedButton(
//       onPressed: () {
//         //TODO button func
//         calculationLogic(btntxt);
//       },
//       style: TextButton.styleFrom(
//         shape: const CircleBorder(),
//         backgroundColor: btncolor,
//         // padding: const EdgeInsets.all(20),
//         elevation: 15,
//         minimumSize: const Size(75, 75),
//         maximumSize: const Size(80, 80),
//         shadowColor: btncolor,
//       ),
//       child: Text(
//         btntxt,
//         style: TextStyle(
//           fontSize: 35,
//           color: txtcolor,
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF292D30),
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: const Color(0xFF292D30),
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: <Widget>[
//             const Padding(padding: EdgeInsets.all(10.0)),
//             // Input Field
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(0.0),
//                       child: Text(
//                         history,
//                         style: const TextStyle(
//                           fontSize: 50.0,
//                           color: Colors.white24,
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 5.0, vertical: 0.0),
//                       child: Text(
//                         text,
//                         style: const TextStyle(
//                           fontSize: 100.0,
//                           color: Colors.white,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 //buttons
//                 calcbutton('AC', Colors.grey, Colors.black),
//                 calcbutton('+/-', Colors.grey, Colors.black),
//                 calcbutton('%', Colors.grey, Colors.black),
//                 calcbutton('/', Colors.amber[700]!, Colors.white),
//               ],
//             ),
//             const SizedBox(
//               height: 10.0,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 //buttons
//                 calcbutton('7', Colors.grey[850]!, Colors.white),
//                 calcbutton('8', Colors.grey[850]!, Colors.white),
//                 calcbutton('9', Colors.grey[850]!, Colors.white),
//                 calcbutton('X', Colors.amber[700]!, Colors.white),
//               ],
//             ),
//             const SizedBox(
//               height: 10.0,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 //buttons
//                 calcbutton('4', Colors.grey[850]!, Colors.white),
//                 calcbutton('5', Colors.grey[850]!, Colors.white),
//                 calcbutton('6', Colors.grey[850]!, Colors.white),
//                 calcbutton('-', Colors.amber[700]!, Colors.white),
//               ],
//             ),
//             const SizedBox(
//               height: 10.0,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 //buttons
//                 calcbutton('1', Colors.grey[850]!, Colors.white),
//                 calcbutton('2', Colors.grey[850]!, Colors.white),
//                 calcbutton('3', Colors.grey[850]!, Colors.white),
//                 calcbutton('+', Colors.amber[700]!, Colors.white),
//               ],
//             ),
//             const SizedBox(
//               height: 10.0,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {},
//                   style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.fromLTRB(34, 20, 128, 20),
//                       shape: StadiumBorder(),
//                       backgroundColor: Colors.grey[850],
//                       elevation: 15),
//                   child: const Text(
//                     '0',
//                     style: TextStyle(
//                       fontSize: 35,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 calcbutton('.', Colors.grey[850]!, Colors.white),
//                 calcbutton('=', Colors.grey[850]!, Colors.white),
//               ],
//             )
//           ],
//         ),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
//
//   //calculator logic
//   dynamic text = '0';
//   double numOne = 0;
//   double numTwo = 0;
//
//   dynamic result = '';
//   dynamic finalResult = '';
//   dynamic opr = '';
//   dynamic preOpr = '';
//   dynamic history = ' ';
//
//   calculationLogic(btnText) {
//     if (btnText == 'AC') {
//       text = '0';
//       history = ' ';
//       numOne = 0;
//       numTwo = 0;
//       result = '';
//       finalResult = '0';
//       opr = '';
//       preOpr = '';
//       setState(() {
//         history = ' ';
//       });
//     } else if (opr == '=' && btnText == '=') {
//       if (preOpr == '+') {
//         finalResult = add();
//       } else if (preOpr == '-') {
//         finalResult = sub();
//       } else if (preOpr == 'x') {
//         finalResult = mul();
//       } else if (preOpr == '/') {
//         finalResult = div();
//       }
//     } else if (btnText == '+' ||
//         btnText == '-' ||
//         btnText == 'x' ||
//         btnText == '/' ||
//         btnText == '=') {
//       if (numOne == 0) {
//         numOne = double.parse(result);
//       } else {
//         numTwo = double.parse(result);
//       }
//
//       if (opr == '+') {
//         finalResult = add();
//       } else if (opr == '-') {
//         finalResult = sub();
//       } else if (opr == 'x') {
//         finalResult = mul();
//       } else if (opr == '/') {
//         finalResult = div();
//       }
//       preOpr = opr;
//       opr = btnText;
//       result = '';
//     } else if (btnText == '%') {
//       result = numOne / 100;
//       finalResult = doesContainDecimal(result);
//     } else if (btnText == '.') {
//       if (!result.toString().contains('.')) {
//         result = result.toString() + '.';
//       }
//       finalResult = result;
//     } else if (btnText == '+/-') {
//       result.toString().startsWith('-')
//           ? result = result.toString().substring(1)
//           : result = '-' + result.toString();
//       finalResult = result;
//     } else {
//       result = result + btnText;
//       finalResult = result;
//     }
//
//     setState(() {
//       text = finalResult;
//       history = numOne.toString() + preOpr +  numTwo.toString();
//     });
//   }
//
//   String add() {
//     result = (numOne + numTwo).toString();
//     numOne = double.parse(result);
//     return doesContainDecimal(result);
//   }
//
//   String sub() {
//     result = (numOne - numTwo).toString();
//     numOne = double.parse(result);
//     return doesContainDecimal(result);
//   }
//
//   String mul() {
//     result = (numOne * numTwo).toString();
//     numOne = double.parse(result);
//     return doesContainDecimal(result);
//   }
//
//   String div() {
//     result = (numOne / numTwo).toString();
//     numOne = double.parse(result);
//     return doesContainDecimal(result);
//   }
//
//   String doesContainDecimal(dynamic result) {
//     if (result.toString().contains('.')) {
//       List<String> splitDecimal = result.toString().split('.');
//       if (!(int.parse(splitDecimal[1]) > 0))
//         return result = splitDecimal[0].toString();
//     }
//     return result;
//   }
// }
