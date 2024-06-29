import 'package:flutter/material.dart';

class AboutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sobre Mi'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/mifoto.jpg'),
            ),
            SizedBox(height: 20),
            Text('Nombre: Carlos Isaac Sanchez Coplin'),
            Text('Email: carlossanchezcoplin@gmail.com'),
            Text('Teléfono: 849-255-1513'),
          ],
        ),
      ),
    );
  }
}
