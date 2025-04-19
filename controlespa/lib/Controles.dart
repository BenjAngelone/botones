import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final GlobalKey<_ControlsState> controlsKey = GlobalKey<_ControlsState>();
class Controls extends StatefulWidget {
  final VoidCallback toggleRecording; // Recibe la función

  const Controls({Key? key, required this.toggleRecording}) : super(key: key);

  @override
  _ControlsState createState() => _ControlsState();
}

class _ControlsState extends State<Controls> {
  int contador_gas=0;
  int valorgas=0;
  int porcentajegas=0;
  int Distanciagas=0;
  int promediogas=0;

  String Autito = 'assets/arrow.png';
  int unitgas=0;
  String MostrarGas="";
  bool motorEncendido = false;
  bool lucesEncendidas = false;
  bool puertaBloqueada = true;
  String StartIMG = 'assets/Stop.png';
  String LucesIMG = 'assets/Bajaoff.png';
  String PuertasIMG = 'assets/Lock.png';
  String GasImg='assets/GAS.png';
  String ArrIMG='assets/Arranque.png';


  @override
  void initState() {
    super.initState(); 
    
   
    
  
     // Puedes llamar a esta función aquí si necesitas obtener el valor al iniciar
  }
  void sendGetRequestWithoutAwait(String endpoint) {
  http.get(Uri.parse('http://192.168.199.203/$endpoint')).timeout(
    const Duration(seconds: 5), 
    onTimeout: () {
      print('Error: Servidor no responde dentro del tiempo establecido.');
      return http.Response('Timeout', 408); 
    },
  ).then((response) {
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }).catchError((error) {
    // Manejo de otros tipos de error
    //print('Error: $error');
  });
    //print("hola");
}

  void _handleDoubleTapMotor() {
    widget.toggleRecording();
    _toggleMotor();
  }
  var now = DateTime.now();
  void ArranqueOn(){
          sendGetRequestWithoutAwait("ArranqueOff");
      
  }
  void ArranqueOff(){
          sendGetRequestWithoutAwait("ArranqueOn");

  }

  void _toggleMotor() {
    setState(() {
      //Wh.fetchWeather();
      motorEncendido = !motorEncendido;
      if (!motorEncendido) {
        StartIMG = 'assets/Stop.png';
        sendGetRequestWithoutAwait("ContactoOff");
        _togglePuerta(1);
        toggleLucesBajas(2);
      } else {
        StartIMG = 'assets/Start.png';
        now = DateTime.now();
        sendGetRequestWithoutAwait("ContactoOn");

        Future.delayed(const Duration(seconds: 20), () {
          _togglePuerta(2);
           // Llama a la función después del delay
        });
        Future.delayed(const Duration(seconds: 20), () {
          toggleLucesBajas(1);
           // Llama a la función después del delay
        });
      }
      }
    );
  }

  void toggleLucesBajas([int forzado = 0]) {
    setState(() {
      print("luces");
      if (forzado == 1) {
        lucesEncendidas = true;
      } else if (forzado == 2) {
        lucesEncendidas = false;
      } else {
        lucesEncendidas = !lucesEncendidas;}

        if (lucesEncendidas) {
          LucesIMG = 'assets/Bajaon.png';
          Autito = 'assets/arrowOn.png';
          print("prendidas");
          sendGetRequestWithoutAwait("LucesOn");
          
        } else {
          Autito = 'assets/arrow.png';
          LucesIMG = 'assets/Bajaoff.png';
          print("apagadas");
          sendGetRequestWithoutAwait("LucesOff");
        }
      
    });
  }

  void _togglePuerta([int forzadop = 0]) {
    setState(() {
      if (forzadop == 1) {
       
        puertaBloqueada =true; }
      else if (forzadop == 2) {
        puertaBloqueada = false;
      }else {  
     
      puertaBloqueada = !puertaBloqueada; } 

      if (!puertaBloqueada) {
        PuertasIMG = 'assets/Lock.png';
        sendGetRequestWithoutAwait("Lock");
      } else {
        PuertasIMG = 'assets/Unlock.png';
        sendGetRequestWithoutAwait("Unlock");
      }
    });
  }
  
  void Calculos_Gas(){
    
    porcentajegas = ((valorgas/12)*100).round();
    Distanciagas= ((14/11.8 )* valorgas).round();
    promediogas = 11;
  }
 

  // Placeholder para evitar errores, reemplázalo con tus funciones
 

 

  @override
Widget build(BuildContext context) {
  return Container(
    child: Column(
      children: [
        const SizedBox(height: 50),
        GestureDetector(
              onTap: toggleLucesBajas,
              child: Image.asset(
                "assets/9.png",
                width: 300,
                height:300,
              ),
            ),
        const SizedBox(height: 50),
        Row(
          children: [
            const SizedBox(width: 20),
            GestureDetector(
              onDoubleTap: _handleDoubleTapMotor,
              child: Image.asset(
                StartIMG,
                width: 100,
                height: 100,
              ),
            ),
            const SizedBox(width: 20),
            GestureDetector(
              onTap: toggleLucesBajas,
              child: Image.asset(
                LucesIMG,
                width: 100,
                height: 100,
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: _togglePuerta,
              child: Image.asset(
                PuertasIMG,
                width: 100,
                height: 100,
              ),
            ),
          ],
        ),
        const SizedBox(height: 50),
        Text(
          "El rayo es el Arranque",
          textAlign: TextAlign.center, // Centra el texto horizontalmente
          style: TextStyle(
            color: Colors.white, // Color blanco para el texto
            fontSize: 20.0, // Tamaño de la fuente más grande
            fontWeight: FontWeight.bold, // Negrita para resaltar el texto
            fontStyle: FontStyle.italic, // Cursiva para darle un toque romántico
          ),
        ),

        
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center, // Centra verticalmente
          crossAxisAlignment: CrossAxisAlignment.center, 
          children: [
            GestureDetector(
              onTapDown: (_) => ArranqueOff(), // Llama a la función al presionar
              onTapUp: (_) => ArranqueOn(),
              child: Icon(
                Icons.flash_on, // Ícono de rayo predeterminado en Flutter
                size: 50.0, // Tamaño del ícono
                color: const Color.fromARGB(255, 255, 255, 255), // Color del ícono
              ),
            ),
          ],
        ),
      ],
    ),
  );
}}
