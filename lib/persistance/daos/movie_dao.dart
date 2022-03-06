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

  ///Reactive Programming
  
  Stream<void> getAllMoviesEventStream(){
    return getMovieBox().watch();
  }


  List<MovieVO> getNowplayingMovies(){
      if(getAllMovies() != null && getAllMovies().isNotEmpty){
         print("Persistance layer data output check =========> ${getAllMovies()}");
          return getAllMovies()
            .where((element) => element.isNowPlaying ?? false)
            .toList();
      }else{
        return [];
      }
  }

  Stream<List<MovieVO>> getNowplayingMoviesStream(){
          return Stream.value(getAllMovies()
            .where((element) => element.isNowPlaying ?? false)
            .toList());
  }

  List<MovieVO> getComingSoonMovies(){
      if(getAllMovies() != null && getAllMovies().isNotEmpty){
        return getAllMovies()
        .where((element) => element.isComingSoon ?? false)
        .toList();
      }else{
        return [];
      }
  }

   Stream<List<MovieVO>> getComingSoonMoviesStream(){
        return Stream.value(getAllMovies()
        .where((element) => element.isComingSoon ?? false)
        .toList()); 
  }

  MovieVO? getSingleMovieData(int movieId){
    if(getSingleMovie(movieId) != null){
      print("Movie Detail check in database ====> ${getSingleMovie(movieId)}");
      return getSingleMovie(movieId);
    }else{
      return MovieVO.emptySituation();
    }
  }

  Stream<MovieVO?> getSingleMovieStream(int movieId){
      return Stream.value(getSingleMovie(movieId));
  }


  ///Delete
   DeleteMoviesData(){
     return getMovieBox().clear();
  }



  Box<MovieVO> getMovieBox(){
    return Hive.box<MovieVO>(BOX_NAME_MOVIE_VO);
  }
}