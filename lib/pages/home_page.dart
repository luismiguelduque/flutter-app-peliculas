import 'package:flutter/material.dart';
import 'package:peliculas/providers/films_provider.dart';
import 'package:peliculas/search/search_delegate.dart';

import 'package:peliculas/widgets/card_swiper_widget.dart';
import 'package:peliculas/widgets/horizontal_swiper.dart';


class HomePage extends StatelessWidget {
  final filmsProvider = new FilmsProvider();

  @override
  Widget build(BuildContext context) {
    filmsProvider.getPopulars();
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Peliculas en cines'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              showSearch(
                context: context,
                delegate: DataSearch()
              );
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _cardsSwiper(),
            SizedBox(height: 3.0),
            _popularFilms(context),
          ],
        ),
      )
    );
  }

  Widget _cardsSwiper() {
    return FutureBuilder(
      future: filmsProvider.getNowPlaying(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if(snapshot.hasData){
          return CardSwiper(films: snapshot.data,);
        }else{
          return Container(
            height: 400,
            child: Center(
              child: CircularProgressIndicator()
            )
          );
        }

      },
    );
  }

  Widget _popularFilms(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text('Polulares', style: Theme.of(context).textTheme.subhead)
          ),
          SizedBox(height: 3.0),
          StreamBuilder(
            stream: filmsProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if(snapshot.hasData){
                return HorizontalSwiper(
                  films: snapshot.data,
                  nextPage: filmsProvider.getPopulars
                );
              }else{
                return Center(child: CircularProgressIndicator(),);
              }
            },
          ),
        ],
      ),
    );
  }
}