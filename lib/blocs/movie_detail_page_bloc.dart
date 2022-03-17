import 'package:flutter/foundation.dart';
import 'package:hw3_movie_booking_app/data/data.vos/actor_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/movie_vo.dart';
import 'package:hw3_movie_booking_app/data/model/movie_model.dart';
import 'package:hw3_movie_booking_app/data/model/movie_model_impl.dart';

class MovieDetailPageBloc extends ChangeNotifier{

    ///Movie Model
  MovieModel movieModel = MovieModelImpl();

  ///State Variable
  MovieVO? movieDetails;
  List<ActorVO>? cast;
  String? imageView;

  MovieDetailPageBloc(int movieId,bool isNowPlaying){

    ///Movie Details Database
    movieModel.getMovieDetailsDatabase(movieId,isNowPlaying).listen((movie){
        print("Movie Detail insertion into view layer ===============> ${movie}");
        movieDetails = movie;
        imageView = movie?.posterPath;
        notifyListeners();
    }).onError((error){
      debugPrint("Movie Details Database Error ${error.toString()}");
    });

    // ///Credits By Movie Database
    movieModel.getCreditsByMovieDatabase(movieId).listen((castData){
       //cast = castData.cast<ActorVO>();
        print("Get data from hive in view layer ${castData?.actorList}");
          cast = castData?.actorList;
          notifyListeners();
    }).onError((error){
      debugPrint("Credits By Movie Database Error ==========> ${error.toString()}");
    });

  }

}
