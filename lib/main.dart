import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String infoText = "Informe seus dados!";

  void resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      infoText = "Informe seus dados!";
      formKey = GlobalKey<FormState>();
    });
  }

  void calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      print(imc);

      if (imc < 18.6) {
        infoText = "Abaixo do peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        infoText = "Peso ideal (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        infoText = "Levemente acima do peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        infoText = "Obesidade Grau I (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        infoText = "Obesidade Grau II (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 40) {
        infoText = "Obesidade Grau III (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 104, 32, 56),
        actions: <Widget>[
          IconButton(
            onPressed: resetFields,
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.person_outline,
                size: 120.0,
                color: Color.fromARGB(255, 104, 32, 56),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Peso (Kg)", //Peso
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 104, 32, 56),
                  ),
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color.fromARGB(255, 104, 32, 56),
                  fontSize: 25,
                ),
                controller: weightController,
                validator: ((value) {
                  if (value!.isEmpty) {
                    return "Insira seu peso!";
                  }
                }),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Altura (cm)", //Altura
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 104, 32, 56),
                  ),
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF682038),
                  fontSize: 25,
                ),
                controller: heightController,
                validator: ((value) {
                  if (value!.isEmpty) {
                    return "Insira sua altura!";
                  }
                }),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: (() {
                      if (formKey.currentState!.validate()) {
                        calculate();
                      }
                    }),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 104, 32, 56),
                    ),
                    child: const Text(
                      "Calcular",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                infoText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color.fromARGB(255, 104, 32, 56),
                  fontSize: 20,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
