import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String apiKey = '47bb4969738e4889b49212146242906';
const String apiUrl = 'https://api.weatherapi.com/v1/current.json?key=$apiKey&q=Santo%20Domingo&lang=es';

class WeatherView extends StatefulWidget {
  @override
  _WeatherViewState createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  Map<String, dynamic>? _weatherData;

  Future<void> _fetchWeather() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _weatherData = data;
        });
      } else {
        throw Exception('Error al cargar los datos del clima');
      }
    } catch (e) {
      print('Error al obtener los datos del clima: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  String _getBackgroundImage() {
    
    if (_weatherData != null && _weatherData!['current'] != null) {
      String condition = _weatherData!['current']['condition']['text'].toLowerCase();
      if (condition.contains('clear') || condition.contains('sunny')) {
        return 'assets/clearSky.jpg';
      } else if (condition.contains('cloud')) {
        return 'assets/cloudy.jpg';
      } else if (condition.contains('rain') || condition.contains('storm')) {
        return 'assets/rainy.jpg';
      } else {
        return 'assets/cloudy.jpg';
      }
    }
    return 'assets/cloudy.jpg';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clima en Santo Domingo'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(_getBackgroundImage()),
            fit: BoxFit.cover,
          ),
        ),
        child: _weatherData == null
            ? Center(child: CircularProgressIndicator())
            : Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Temperatura: ${_weatherData!['current']['temp_c']} °C',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Descripción: ${_weatherData!['current']['condition']['text']}',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      Image.network(
                        'https:${_weatherData!['current']['condition']['icon']}',
                        scale: 1.0,
                        height: 100, // Ajuste la altura del icono según sea necesario
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          _fetchWeather(); // Botón para actualizar el clima
                        },
                        child: Text('Actualizar Clima'),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
