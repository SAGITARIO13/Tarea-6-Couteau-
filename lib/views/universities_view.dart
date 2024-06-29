import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class UniversityView extends StatefulWidget {
  @override
  _UniversityViewState createState() => _UniversityViewState();
}

class _UniversityViewState extends State<UniversityView> {
  final TextEditingController _controller = TextEditingController();
  List _universities = [];
  bool _isLoading = false;

  Future<void> _fetchUniversities(String country) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse('http://universities.hipolabs.com/search?country=$country'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _universities = data;
        });
      } else {
        throw Exception('Error al cargar las universidades');
      }
    } catch (e) {
      print('Error al obtener las universidades: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('No se pudo obtener la lista de universidades para el país especificado.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('No se pudo abrir la página web de la universidad.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Universidades por País'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Ingrese el país'),
            ),
            ElevatedButton(
              onPressed: () => _fetchUniversities(_controller.text),
              child: Text('Buscar'),
            ),
            Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : _universities.isEmpty
                      ? Center(child: Text('No hay universidades disponibles'))
                      : ListView.builder(
                          itemCount: _universities.length,
                          itemBuilder: (context, index) {
                            final university = _universities[index];
                            return ListTile(
                              title: Text(university['name'] ?? ''),
                              subtitle: Text(university['domains'][0] ?? ''),
                              trailing: IconButton(
                                icon: Icon(Icons.link),
                                onPressed: () {
                                  if (university['web_pages'].length > 0) {
                                    _launchURL(university['web_pages'][0]);
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Error'),
                                          content: Text('No hay página web válida disponible para esta universidad.'),
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text('OK'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                },
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
