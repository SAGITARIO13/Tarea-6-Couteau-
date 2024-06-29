import 'package:flutter/material.dart';

class AgePredictionView extends StatefulWidget {
  @override
  _AgePredictionViewState createState() => _AgePredictionViewState();
}

class _AgePredictionViewState extends State<AgePredictionView> {
  final TextEditingController _controller = TextEditingController();
  String _ageResult = '';
  String _message = '';
  String _imageUrl = '';

  void _predictAge(String name) {
    // Simulación de carga de datos
    int age = _mockPredictAge(name);

    setState(() {
      _ageResult = 'Edad: $age';
      if (age < 18) {
        _message = 'Joven';
        _imageUrl =
            'https://img.freepik.com/vector-premium/adolescentes-chico-chica-amigo-companero-pie_18591-4618.jpg';
      } else if (age < 65) {
        _message = 'Adulto';
        _imageUrl =
            'https://i.pinimg.com/originals/d7/d6/55/d7d65519c699888a075eab7a7be20df9.jpg';
      } else {
        _message = 'Anciano';
        _imageUrl =
            'https://image.shutterstock.com/image-vector/elderly-people-cartoon-260nw-1510277039.jpg';
      }
    });
  }

  // Simulación de la predicción de edad (aquí deberías llamar a tu API real)
  int _mockPredictAge(String name) {
    // Lógica de predicción simulada
    return name.length * 5;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Predecir Edad'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Ingresa un nombre',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _predictAge(_controller.text),
              child: Text('Predecir'),
            ),
            SizedBox(height: 20),
            Text(
              _ageResult,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              _message,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            _imageUrl.isNotEmpty
                ? Image.network(
                    _imageUrl,
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
