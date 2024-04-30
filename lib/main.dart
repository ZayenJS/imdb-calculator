import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ironmaster_dumbbell_calculator/database/database.dart';
import 'package:ironmaster_dumbbell_calculator/screens/tabs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool isOpen = (await AppDatabase.instance.database)?.isOpen ?? false;
  if (!isOpen) {
    print("Database could not be opened.");
    exit(1);
  }

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
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
