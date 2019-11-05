import 'package:flutter/material.dart';
import 'package:peliculas/pages/film_detail.dart';


import 'package:peliculas/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas',
      initialRoute: '/',
      routes: {
        '/': ( BuildContext context ) => HomePage(),
        'detail' :  ( BuildContext context ) => FilmDetail(),
      },
    );
  }
}