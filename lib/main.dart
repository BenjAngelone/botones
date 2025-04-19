import 'package:flutter/material.dart';
import 'Controles.dart'; // Asegúrate de que este archivo esté en la misma carpeta o ajusta el path.

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Controles de Rocio',
      theme: ThemeData(
        // Definimos un tema personalizado para un look moderno.
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: const Color.fromARGB(255, 37, 37, 37),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 4.0,
          backgroundColor: Color.fromARGB(255, 43, 43, 43),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isRecording = false;

  // Alterna el estado de grabación y muestra un mensaje.
  void toggleRecording() {
    setState(() {
      isRecording = !isRecording;
    });

    final message = isRecording ? 'Grabación iniciada 🎥' : 'Grabación detenida 🛑';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor: isRecording ? const Color.fromARGB(255, 19, 19, 37) : Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Controles 9',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white,),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Controls(
            toggleRecording: toggleRecording,
          ),
        ),
      ),
    );
  }
}
