import 'package:hw3_movie_booking_app/data/data.vos/movie_vo.dart';

abstract class MovieDao{

  void saveAllMovies(List<MovieVO> movieList);
  saveSingleMovies(MovieVO movie);
  List<MovieVO> getAllMovies();
  MovieVO? getSingleMovie(int movieId);

  Stream<void> getAllMoviesEventStream();
  List<MovieVO> getNowplayingMovies();
  Stream<List<MovieVO>> getNowplayingMoviesStream();
  List<MovieVO> getComingSoonMovies();
  Stream<List<MovieVO>> getComingSoonMoviesStream();
  MovieVO? getSingleMovieData(int movieId);
  Stream<MovieVO?> getSingleMovieStream(int movieId);

}