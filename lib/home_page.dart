import 'package:flutter/material.dart';
import 'package:pushable_buttons_3d/pushable_button.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    );
    final shadow = BoxShadow(
      color: Colors.grey.withOpacity(0.5),
      spreadRadius: 5,
      blurRadius: 7,
      offset: Offset(0, 2),
    );
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/bg.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                //mainAxisSize: MainAxisSize.min,
                children: [
                  PushableButton(
                    height: 60,
                    elevation: 8,
                    hslColor: HSLColor.fromAHSL(1.0, 356, 1.0, 0.43),
                    opacity: 0.2,
                    //shadow: shadow,
                    onPressed: () {},
                    child: Text('PUSH ME 😎', style: textStyle),
                  ),
                  SizedBox(height: 20),
                  PushableButton(
                    height: 60,
                    elevation: 8,
                    hslColor: HSLColor.fromAHSL(1.0, 0, 0.0, 1.0),
                    opacity: 0.2,
                    //shadow: shadow,
                    onPressed: () {},
                    child: Text('ENROLL NOW', style: textStyle),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
