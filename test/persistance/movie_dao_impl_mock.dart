import 'package:hw3_movie_booking_app/data/data.vos/movie_vo.dart';
import 'package:hw3_movie_booking_app/persistance/abstraction_layer/movie_dao.dart';

import '../mock_data/mock_data.dart';

class MovieDaoImplMock extends MovieDao{

  Map<int,MovieVO> movieDatabaseMock = {};

  @override
  List<MovieVO> getAllMovies() {
    return moviesMockForTest();
  }

  @override
  Stream<void> getAllMoviesEventStream() {
    return Stream<void>.value(null);
  }

  @override
  List<MovieVO> getComingSoonMovies() {
    if(moviesMockForTest() != null && moviesMockForTest().isNotEmpty){
      return moviesMockForTest()
          .where((element) => element.isComingSoon ?? false)
          .toList();
    }else{
     return [];
   }
  }

  @override
  Stream<List<MovieVO>> getComingSoonMoviesStream() {
    return Stream.value(
      moviesMockForTest()
      .where((element) => element.isComingSoon ?? false)
      .toList(),
    );
  }

  @override
  List<MovieVO> getNowplayingMovies() {
   if(moviesMockForTest() != null && moviesMockForTest().isNotEmpty){
     return moviesMockForTest()
        .where((element) => element.isNowPlaying ?? false)
        .toList();
   }else{
     return [];
   }
  }

  @override
  Stream<List<MovieVO>> getNowplayingMoviesStream() {
    return Stream.value(
      moviesMockForTest()
      .where((element) => element.isNowPlaying ?? false)
      .toList(),
    );
  }

  @override
  MovieVO? getSingleMovie(int movieId) {
    return moviesMockForTest()
    .firstWhere((element) => 
    element.id == movieId);
  }

  @override
  MovieVO? getSingleMovieData(int movieId) {
    if(moviesMockForTest() != null){
      return moviesMockForTest()
          .where((element) => element.id == movieId)
          .first;
    }
  }

  @override
  Stream<MovieVO?> getSingleMovieStream(int movieId) {
    return Stream.value(
      moviesMockForTest()
      .where((element) => element.id == movieId)
      .first,
    );
  }

  @override
  void saveAllMovies(List<MovieVO> movieList) {
    movieList.forEach((element) {
      movieDatabaseMock[element.id!] = element;
    });
  }

  @override
  saveSingleMovies(MovieVO movie) {
    movieDatabaseMock[movie.id!] = movie;
  }



}