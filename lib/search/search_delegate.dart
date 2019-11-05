import 'package:flutter/material.dart';
import 'package:peliculas/models/film_model.dart';
import 'package:peliculas/providers/films_provider.dart';

class DataSearch extends SearchDelegate {

  String selection = '';
  final filmsProvider = new FilmsProvider();
  final films = [
    'toy story',
    'the stractors',
    'gotzilla',
    'poquemon',
    'yumanji'
  ];

  final recentFilms = [
    'spiderman',
    'batman'
  ];


  @override
  List<Widget> buildActions(BuildContext context) {
    // Acciones del appbar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del appbar
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow ,
          progress: transitionAnimation,
        ),
        onPressed: (){
          close(context, null);
        },
      );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados a mostrar
    return Container();
  }
  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen al escribir
    if(query.isEmpty){
      return Container();
    }
    return FutureBuilder(
      future: filmsProvider.getSearching(query),
      builder: (BuildContext context, AsyncSnapshot<List<Film>> snapshot) {
        if(snapshot.hasData){
          final films = snapshot.data;
          return ListView(
            children: films.map((f){
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(f.getPosterImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  width: 50.0,
                  fit: BoxFit.contain,
                ),
                title: Text(f.title),
                subtitle: Text(f.originalTitle),
                onTap: (){
                  close(context, null);
                  f.uniqueId = '';
                  Navigator.pushNamed(context, 'detail', arguments: f);
                },
              );
            }).toList()
          );
        }else{
          return Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }

/*@override
  Widget buildSuggestions(BuildContext context) {

    final suggestedSearch = (query.isEmpty)
                            ? recentFilms
                            : films.where(
                              (film)=>film.toLowerCase().startsWith(query.toLowerCase())).toList();

    // Son las sugerencias que aparecen al escribir
    return ListView.builder(
      itemCount: suggestedSearch.length,
      itemBuilder: (context, i){
        return ListTile(
          leading: Icon( Icons.movie ),
          title: Text(suggestedSearch[i]),
        );
      },
    );
  }*/

}
