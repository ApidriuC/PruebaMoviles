

import 'package:flutter/material.dart';
import 'package:themoviedb/api/themoviedbservice.dart';
import 'package:themoviedb/ui/spinnerwidget.dart';
import 'package:themoviedb/ui/cajapelicula.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Peliculas',
      theme: ThemeData(
        primarySwatch: Colors.lime,
      ),
      home: HomoPage(),
    );
  }
}

class HomoPage extends StatelessWidget {
  @override
  Widget build(BuildContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text('INTRODUCCIÓN'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text("En el siguiente sitio web se mostraran algunas peliculas las cuales estan catalogadas segun el sitio web 'https://www.themoviedb.org/', como las peliculas más valoradas por vistas y votaciones. A continuación se mostrarán los rankings y un pequeño resumen de cada una de estas peliculas...", style: TextStyle(fontSize: 20),
          ),
          RaisedButton(
            child: Text('Aceptar y continuar'),
            onPressed: () {
              Navigator.of(BuildContext)
                  .push(MaterialPageRoute(builder: (context) => MovieDBPage()));
            },
          ),
        ],
      )),
    );
  }
}

class MovieDBPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Top Peliculas Más Valoradas')),
        body: FutureBuilder(
          future: TheMovieDBService.getTopRatedMovies(),
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var pelicula = snapshot.data![index];
                  return CajaPelicula(peli: pelicula);
                },
              );
            } else {
              return SpinnerWidget();
            }
          },
        ));
  }
}
