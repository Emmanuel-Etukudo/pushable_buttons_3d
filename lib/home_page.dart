import 'package:flutter/material.dart';
import 'package:pushable_buttons_3d/glass_morphism_text.dart';
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
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Stack(
        children: [
          Image.asset(
            'assets/images/welcom.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PushableButton(
                    height: 60,
                    elevation: 8,
                    hslColor: HSLColor.fromAHSL(1.0, 30, 0.59, 0.33),
                    opacity: 0.3,
                    blurIntensity: 15,
                    onPressed: () {
                      // Add your action here
                      debugPrint('Button 1 Pressed');
                    },
                    child: GlassMorphismText(
                      text: 'REGISTER',
                      textEffect: GlassTextEffect.frosted,
                      blurRadius: 1.5,
                      letterSpacing: 2,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  PushableButton(
                    width: 300,
                    height: 60,
                    elevation: 8,
                    blurIntensity: 15,
                    hslColor: HSLColor.fromAHSL(1.0, 0, 0.0, 1.0),
                    opacity: 0.3,
                    borderRadius: BorderRadius.circular(30),
                    onPressed: () {
                      // Add your action here
                      debugPrint('Button 2 Pressed');
                    },
                    child: GlassMorphismText(
                      text: 'LOGIN',
                      textEffect: GlassTextEffect.frosted,
                      blurRadius: 1.5,
                      letterSpacing: 2,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
