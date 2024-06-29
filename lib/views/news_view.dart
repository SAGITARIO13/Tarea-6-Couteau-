import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class NewsView extends StatefulWidget {
  @override
  _NewsViewState createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  List _news = [];
  String? _siteLogoUrl;

  Future<void> _fetchSiteInfo() async {
    final String apiUrl = 'https://cloudservices.com.do/wp-json/';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _siteLogoUrl = data['https://cloudservices.com.do/wp-content/uploads/2020/04/Logo-CloudServicesDominicana-1.png'];
        });
      } else {
        throw Exception('No se pudo cargar la información del sitio');
      }
    } catch (e) {
      print('Error al obtener la información del sitio: $e');
    }
  }

  Future<void> _fetchNews() async {
    final String apiUrl = 'https://cloudservices.com.do/wp-json/wp/v2/posts';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _news = data;
        });
      } else {
        throw Exception('No se pudo cargar las noticias');
      }
    } catch (e) {
      print('Error al obtener las noticias: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchSiteInfo();
    _fetchNews();
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo abrir $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Noticias de Cloud Services'),
      ),
      body: _news.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _news.length,
              itemBuilder: (context, index) {
                final newsItem = _news[index];
                return ListTile(
                  leading: _siteLogoUrl != null
                      ? Image.network(
                          _siteLogoUrl!,
                          height: 50,
                          width: 50,
                        )
                      : SizedBox.shrink(),
                  title: Text(newsItem['title']['rendered'] ?? ''),
                  subtitle: Text(
                    _stripHtmlTags(newsItem['excerpt']['rendered']),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.link),
                    onPressed: () {
                      _launchURL(newsItem['link']);
                    },
                  ),
                );
              },
            ),
    );
  }

  String _stripHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlText.replaceAll(exp, '');
  }
}
