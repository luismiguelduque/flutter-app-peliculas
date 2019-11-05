import 'package:flutter/material.dart';
import 'package:peliculas/models/film_model.dart';

class HorizontalSwiper extends StatelessWidget {
  final List<Film> films;
  final Function nextPage;

  HorizontalSwiper({ @required this.films, @required this.nextPage });

  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3
  );



  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener((){
      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent-200){
        nextPage();
      }
    });

    return Container(
      height: _screenSize.height * 0.25,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: films.length,
        itemBuilder: (context, i){
          return createCard(context, films[i]);
        },
      ),
    );
  }

  Widget createCard(BuildContext context, Film film){
    film.uniqueId = '${film.id}+poster';
    final card = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: <Widget>[
          Hero(
            tag: film.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: FadeInImage(
                image: NetworkImage(film.getPosterImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 90,
              ),
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            film.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );

    return GestureDetector(
      child: card,
      onTap: (){
        Navigator.pushNamed(context, 'detail', arguments: film);
      },
    );
  }
}