import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toolbox App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/about'),
              child: Text('Sobre Mi'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/age'),
              child: Text('Predecir Edad'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/gender'),
              child: Text('Predecir sexo'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/news'),
              child: Text('Noticias'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/universities'),
              child: Text('Universidades'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/weather'),
              child: Text('Clima'),
            ),
          ],
        ),
      ),
    );
  }
}
