import 'package:flutter/foundation.dart';
import 'package:hw3_movie_booking_app/data/data.vos/movie_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/user_vo.dart';
import 'package:hw3_movie_booking_app/data/model/movie_model.dart';
import 'package:hw3_movie_booking_app/data/model/movie_model_impl.dart';

class MovieListPageBloc extends ChangeNotifier{

///Model
  MovieModel movieModel = MovieModelImpl();
  
  ///State Variable
  List<UserVO>? userData;
  List<MovieVO>? nowPlayingMovieList;
  List<MovieVO>? comingSoonMovieList;

  MovieListPageBloc(){

      ///Login User Info database
    movieModel.getLoginUserInfoDatabase().listen((userInfo){
          print("User data from database in view layer insertion =============> ${userInfo}");
          userData = userInfo;
          notifyListeners();
    }).onError((error){
      debugPrint("Something Wrong user data from database ========> ${error.toString()}");
    });

   ///Get SnackList
    movieModel.getSnackList();

    //Get Now Playing Movies Database
    movieModel.getNowPlayingMovieDatabase().listen((movies){
          print("Nowplaying Movie Data access in view layer ==========> ${movies}");
          nowPlayingMovieList = movies;
          notifyListeners();
    }).onError((error){
      debugPrint("Now Playing Movies Database Error ======> ${error.toString()}");
    });

     ///Get Coming Soon Movies Database
    movieModel.getComingSoonMovieDatabase().listen((movies){
         print("Coming Soon Movie Data access in view layer ==========> ${movies}");
        comingSoonMovieList = movies;
          notifyListeners();
    }).onError((error){
      debugPrint("Coming Soon Movies Database Error =========> ${error.toString()} ");
    });

  }

 Future<void> doLogout(){
    ///Logout user
   return movieModel.postLogout();
  }

 Future<void> deleteUserData(){
    ///Delete User Data from Database
  return movieModel.logoutUserInfoDatabase();
  }

}