import 'package:hive/hive.dart';
import 'package:hw3_movie_booking_app/data/data.vos/movie_vo.dart';
import 'package:hw3_movie_booking_app/persistance/hive_constants.dart';

class MovieDao{

  static final MovieDao _singleton = MovieDao._internal();

  factory MovieDao(){
    return _singleton;
  }

  MovieDao._internal();

  void saveAllMovies(List<MovieVO> movieList)async{
      Map<int,MovieVO> getMovieMap = Map.fromIterable(
        movieList,
        key: (movie) => movie.id,
        value: (movie) => movie,
      );
      await getMovieBox().putAll(getMovieMap);
  }

  saveSingleMovies(MovieVO movie)async{
    return getMovieBox().put(movie.id,movie);
  }



  List<MovieVO> getAllMovies(){
    return getMovieBox().values.toList();
  }

  MovieVO? getSingleMovie(int movieId){
    return getMovieBox().get(movieId);
  }



  Box<MovieVO> getMovieBox(){
    return Hive.box<MovieVO>(BOX_NAME_MOVIE_VO);
  }
}