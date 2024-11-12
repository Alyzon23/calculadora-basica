import 'package:flutter/material.dart';

void main() {
  runApp(CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Container(
            width: 360,
            height: 640,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Calculadora(),
          ),
        ),
      ),
    );
  }
}

class Calculadora extends StatefulWidget {
  @override
  _CalculadoraState createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  String display = '0';
  String operacion = '';
  double primerNumero = 0;
  double segundoNumero = 0;

  final List<String> buttons = [
    'C', '÷', 'x', '⌫',
    '7', '8', '9', '-',
    '4', '5', '6', '+',
    '1', '2', '3', '=',
    '0', '.',
  ];

  void botonPresionado(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        display = '0';
        primerNumero = 0;
        segundoNumero = 0;
        operacion = '';
      } else if (buttonText == '⌫') {
        display = display.length > 1 ? display.substring(0, display.length - 1) : '0';
      } else if (buttonText == '+' || buttonText == '-' || buttonText == 'x' || buttonText == '÷') {
        primerNumero = double.parse(display);
        operacion = buttonText;
        display = '0';
      } else if (buttonText == '=') {
        segundoNumero = double.parse(display);
        if (operacion == '+') display = (primerNumero + segundoNumero).toString();
        if (operacion == '-') display = (primerNumero - segundoNumero).toString();
        if (operacion == 'x') display = (primerNumero * segundoNumero).toString();
        if (operacion == '÷') display = segundoNumero != 0 ? (primerNumero / segundoNumero).toString() : 'Error';
        operacion = '';
      } else {
        display = display == '0' ? buttonText : display + buttonText;
      }
    });
  }

  Widget buildButton(String buttonText, Color buttonColor, Color textColor) {
    return GestureDetector(
      onTap: () => botonPresionado(buttonText),
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: buttonColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(color: textColor, fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Fondo con nombre y curso
        Positioned(
          bottom: 40,
          left: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Alyzon Egas',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              Text(
                'Cuarto "A"',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ],
          ),
        ),

        // Calculadora
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Pantalla de resultados
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              alignment: Alignment.centerRight,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 235, 218, 248).withOpacity(0.8),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Text(
                display,
                style: TextStyle(fontSize: 48, color: Colors.black87, fontWeight: FontWeight.w300),
              ),
            ),

            // Botones de la calculadora
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(8),
                itemCount: buttons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  String buttonText = buttons[index];
                  Color buttonColor = Colors.pink[100]!; 
                  Color textColor = Colors.black87;

                  // Asignar colores pastel personalizados
                  if (buttonText == 'C') {
                    buttonColor = const Color.fromARGB(255, 244, 125, 95).withOpacity(0.8);
                    textColor = Colors.white;
                  } else if (buttonText == '=') {
                    buttonColor = Colors.greenAccent.withOpacity(0.8);
                    textColor = Colors.white;
                  } else if (['+', '-', 'x', '÷'].contains(buttonText)) {
                    buttonColor = const Color.fromARGB(255, 216, 71, 252).withOpacity(0.7);
                    textColor = Colors.white;
                  } else {
                    buttonColor = Colors.teal[100]!; 
                    textColor = Colors.black;
                  }

                  return buildButton(buttonText, buttonColor, textColor);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
