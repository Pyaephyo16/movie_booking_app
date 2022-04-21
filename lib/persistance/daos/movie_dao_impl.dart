import 'package:hive/hive.dart';
import 'package:hw3_movie_booking_app/data/data.vos/movie_vo.dart';
import 'package:hw3_movie_booking_app/persistance/abstraction_layer/movie_dao.dart';
import 'package:hw3_movie_booking_app/persistance/hive_constants.dart';

class MovieDaoImpl extends MovieDao{

  static final MovieDaoImpl _singleton = MovieDaoImpl._internal();

  factory MovieDaoImpl(){
    return _singleton;
  }

  MovieDaoImpl._internal();

  @override
  void saveAllMovies(List<MovieVO> movieList)async{
      Map<int,MovieVO> getMovieMap = Map.fromIterable(
        movieList,
        key: (movie) => movie.id,
        value: (movie) => movie,
      );
      await getMovieBox().putAll(getMovieMap);
  }

  @override
  saveSingleMovies(MovieVO movie)async{
    return getMovieBox().put(movie.id,movie);
  }


  @override
  List<MovieVO> getAllMovies(){
    return getMovieBox().values.toList();
  }

  @override
  MovieVO? getSingleMovie(int movieId){
    return getMovieBox().get(movieId);
  }

  ///Reactive Programming
  
    @override
  Stream<void> getAllMoviesEventStream(){
    return getMovieBox().watch();
  }

  @override
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

  @override
  Stream<List<MovieVO>> getNowplayingMoviesStream(){
          return Stream.value(getAllMovies()
            .where((element) => element.isNowPlaying ?? false)
            .toList());
  }

  @override
  List<MovieVO> getComingSoonMovies(){
      if(getAllMovies() != null && getAllMovies().isNotEmpty){
        return getAllMovies()
        .where((element) => element.isComingSoon ?? false)
        .toList();
      }else{
        return [];
      }
  }

  @override
   Stream<List<MovieVO>> getComingSoonMoviesStream(){
        return Stream.value(getAllMovies()
        .where((element) => element.isComingSoon ?? false)
        .toList()); 
  }

  @override
  MovieVO? getSingleMovieData(int movieId){
    if(getSingleMovie(movieId) != null){
      print("Movie Detail check in database ====> ${getSingleMovie(movieId)}");
      return getSingleMovie(movieId);
    }else{
      return MovieVO.emptySituation();
    }
  }

  @override
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