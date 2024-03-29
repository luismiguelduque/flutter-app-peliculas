import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/models/film_model.dart';

class CardSwiper extends StatelessWidget {

  final List<Film> films;

  CardSwiper({ @required this.films });

  @override
  Widget build(BuildContext context) {
    final _scrinSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: 8.0),
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _scrinSize.width * 0.7,
        itemHeight: _scrinSize.height * 0.5,
        itemBuilder: (BuildContext context,int index){
          films[index].uniqueId = '${films[index].id}+card';
          return GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, 'detail', arguments: films[index]);
            },
            child: Hero(
              tag: films[index].uniqueId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  image: NetworkImage(films[index].getPosterImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
        itemCount: films.length,
        //pagination: new SwiperPagination(),
        //control: new SwiperControl(),
      ),
    );
  }
}