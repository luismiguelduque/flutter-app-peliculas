
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/actors_model.dart';
import 'package:peliculas/models/film_model.dart';

class FilmsProvider{
  String _apiKey     = "a720f24f7b5095abb02c8a0df949a3df";
  String _url        = "api.themoviedb.org";
  String _language   = "es-ES";

  int _popularspage = 0;
  bool _loading = false;


  List<Film> _populars = new List();
  final _popularsStreamController = StreamController<List<Film>>.broadcast();

  Function(List<Film>) get popularsSink => _popularsStreamController.sink.add;

  Stream<List<Film>> get popularesStream => _popularsStreamController.stream;

  void disposeStreams(){
    _popularsStreamController?.close();
  }

  Future<List<Film>> _getResponse(Uri url) async{

    final response = await http.get(url);
    final decodedResponse = json.decode(response.body);
    final films = Films.fromJsonList(decodedResponse['results']);
    return films.items;

  }

  Future<List<Film>> getNowPlaying() async{

    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key' : _apiKey,
      'language' : _language,
    });
    return await _getResponse(url);

  }

  Future<List<Film>> getPopulars() async{
    if(_loading) return [];
    _loading=true;
    _popularspage++;
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key' : _apiKey,
      'language' : _language,
      'page': _popularspage.toString(),
    });

    final response = await _getResponse(url);
    _populars.addAll(response);
    popularsSink(_populars);
    _loading = false;
    return response;
  }

  Future<List<Actor>> getCast(String filmId) async {
    final url = Uri.https(_url, '3/movie/$filmId/credits', {
      'api_key' : _apiKey,
      'language' : _language
    });

    final response = await http.get(url);
    final decodeData = json.decode(response.body);
    final cast = new Cast.fromJsonList(decodeData['cast']);
    return cast.actors;
  }

  Future<List<Film>> getSearching(String query) async{

    final url = Uri.https(_url, '3/search/movie', {
      'api_key' : _apiKey,
      'language' : _language,
      'query': query
    });
    return await _getResponse(url);

  }

}