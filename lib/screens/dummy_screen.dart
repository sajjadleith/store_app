import 'package:flutter/material.dart';

class DummyScreen extends StatefulWidget {
  const DummyScreen({super.key});

  @override
  State<DummyScreen> createState() => _DummyScreenState();
}

class _DummyScreenState extends State<DummyScreen> {
  int _number = 0;
  String changeString = "Mustafa";
  Color changeColor = Colors.red;
  Color changeColorScaf = Colors.white;
  List indexes = [10, 2, 0, 5, 6];
  int currentIndex = 0;

  void changeMg() {
    changeString = "Mg";
    changeColor = Colors.blue;
    changeColorScaf = Colors.grey.shade300;
    indexes[1] = 600;
    changeIndex(3);
    setState(() {});
  }

  void changeIndex(int index) {
    currentIndex = index;
  }

  @override
  void initState() {
    super.initState();
    print("before");
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("after");
    return Scaffold(
      backgroundColor: changeColorScaf,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("$_number")),
          SizedBox(height: 50),
          Text(
            changeString,
            style: TextStyle(color: changeColor, fontSize: 30),
          ),
          SizedBox(height: 50),
          Column(
            children: List.generate(
              indexes.length,
              (index) => Text("text ${indexes[index]}"),
            ),
          ),
          SizedBox(height: 30),
          Text("index $currentIndex"),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _number = _number + 1;
          setState(() {});
          changeMg();
        },
      ),
    );
  }
}
