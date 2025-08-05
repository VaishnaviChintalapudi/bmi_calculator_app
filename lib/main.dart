import 'package:flutter/material.dart';

void main() {
  runApp(const HomeScreen());
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BMICalculator(),
    );
  }
}

class BMICalculator extends StatefulWidget {
  const BMICalculator({super.key});

  @override
  State<BMICalculator> createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  double _height = 50;
  double _weight = 2;
  double? bmiValue;
  String? status;
  String? emoji;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("BMI Calculator",
            style: TextStyle(color: Colors.black, fontSize: 20)),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
            margin: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.pink.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Weight",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Slider(
                      value: _weight,
                      min: 2,
                      max: 500,
                      onChanged: (value) {
                        setState(() {
                          _weight = value;
                          double height = _getHeight();
                          _calculateBMI(height);
                        });
                      }),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "${_weight.toInt()} (kg)",
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Height",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Slider(
                      value: _height,
                      min: 50,
                      max: 250,
                      onChanged: (value) {
                        setState(() {
                          _height = value;
                          double height = _getHeight();
                          _calculateBMI(height);
                        });
                      }),
                  Align(
                      alignment: Alignment.center,
                      child: Text("${_height.toInt()} (cm)")),
                  const SizedBox(
                    height: 10,
                  ),
                  bmiValue != null
                      ? Align(
                          alignment: Alignment.center,
                          child: Text(
                            "BMI Value:  ${bmiValue?.toInt()}",
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _height = 50;
                            _weight = 2;
                            bmiValue = null;
                            status = null;
                          });
                        },
                        child: const Text("Reset Values")),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  status != null
                      ? Align(
                          alignment: Alignment.center,
                          child: Text("$emoji",
                              style: const TextStyle(fontSize: 40)))
                      : const SizedBox.shrink(),
                  const SizedBox(
                    height: 20,
                  ),
                  status != null
                      ? Align(
                          alignment: Alignment.center,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(colors: [
                              Colors.pink,
                              Colors.yellow,
                              Colors.green
                            ])),
                            child: Text("$status",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20)),
                          ),
                        )
                      : const SizedBox.shrink()
                ],
              ),
            )),
      ),
    );
  }

  double _getHeight() {
    double heightInCM = getHeightInCM(_height);
    return heightInCM;
  }

  double getHeightInCM(double height) {
    double h = height / 100;
    return h;
  }

  _calculateBMI(double height) {
    setState(() {
      bmiValue = _weight / (height) * 2;
      if (bmiValue != null) {
        if (bmiValue! < 50.0) {
          status = "Severely underweight";
          emoji = "🧍‍♂️💨";
        } else if (bmiValue! >= 50.0 && bmiValue! < 100) {
          status = "Underweight";
          emoji = "🤔🍃";
        } else if (bmiValue! >= 100 && bmiValue! < 200) {
          status = "Normal (healthy)";
          emoji = "😄💪";
        } else if (bmiValue! >= 200 && bmiValue! < 300) {
          status = "Overweight";
          emoji = "😅🍔";
        } else {
          status = "Obese";
          emoji = "😅🍔";
        }
      }
    });
  }
}
