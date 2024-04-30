import 'package:flutter/material.dart';
import 'package:ironmaster_dumbbell_calculator/screens/tabs.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ironmaster Dumbbell Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 44, 43, 71),
        ),
        useMaterial3: true,
      ),
      home: const TabsScreen(),
    );
  }
}
