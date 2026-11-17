import 'package:fit_back/features/auth/screens/auth_check_screen.dart';
import 'package:fit_back/features/workouts/screens/add_weight_screen.dart';
import 'package:fit_back/features/workouts/screens/weight_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitTrack Pro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const WeightScreen(),
    );
  }
}
