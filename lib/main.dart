import 'package:flutter/material.dart';
import 'views/age_view.dart';
import 'views/gender_view.dart';
import 'views/news_view.dart';
import 'views/universities_view.dart';
import 'views/weather_view.dart';
import 'views/about_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toolbox App',
      theme: ThemeData(
        primaryColor: Colors.blue,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue,
          centerTitle: true,
          elevation: 0,
          actionsIconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeView(),
        '/age': (context) => AgePredictionView(),
        '/gender': (context) => GenderPredictionView(),
        '/news': (context) => NewsView(),
        '/universities': (context) => UniversityView(),
        '/weather': (context) => WeatherView(),
        '/about': (context) => AboutView(),
      },
    );
  }
}

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.build, color: Colors.white),
            ),
            Text('Toolbox App'),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () => Navigator.pushNamed(context, '/about'),
                icon: Icon(Icons.person),
                label: Text('Sobre Mi'),
              ),
              SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () => Navigator.pushNamed(context, '/age'),
                icon: Icon(Icons.access_time),
                label: Text('Predecir Edad'),
              ),
              SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () => Navigator.pushNamed(context, '/gender'),
                icon: Icon(Icons.face),
                label: Text('Predecir Género'),
              ),
              SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () => Navigator.pushNamed(context, '/news'),
                icon: Icon(Icons.article),
                label: Text('Noticias'),
              ),
              SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () => Navigator.pushNamed(context, '/universities'),
                icon: Icon(Icons.school),
                label: Text('Universidades'),
              ),
              SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () => Navigator.pushNamed(context, '/weather'),
                icon: Icon(Icons.wb_sunny),
                label: Text('Clima'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
