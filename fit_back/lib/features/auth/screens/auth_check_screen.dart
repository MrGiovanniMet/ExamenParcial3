import 'package:fit_back/core/storage/local_storage_service.dart';
import 'package:fit_back/features/auth/screens/login_screen.dart';
import 'package:fit_back/features/workouts/screens/home_screen.dart';
import 'package:flutter/material.dart';


class AuthCheckScreen extends StatefulWidget {
  const AuthCheckScreen({super.key});

  @override
  State<AuthCheckScreen> createState() => _AuthCheckScreenState();
}

class _AuthCheckScreenState extends State<AuthCheckScreen> {
  
  final LocalStorageService _storageService = LocalStorageService();

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
    
  }

  Future<void> _checkAuthStatus() async {
    final token = await _storageService.getToken();

    if(!mounted){
      return;
    }

    if(token != null && token.isNotEmpty){
      //home
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      // login
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }

  }         



  @override
  Widget build(BuildContext context) {
   return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    ); 
  }
}