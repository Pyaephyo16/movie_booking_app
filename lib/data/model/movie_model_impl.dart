// import 'package:flutter/material.dart';
// import 'package:hw3_movie_booking_app/data/data.vos/actor_vo.dart';
// import 'package:hw3_movie_booking_app/data/data.vos/actorlist_for_hive_vo.dart';
// import 'package:hw3_movie_booking_app/data/data.vos/card_vo.dart';
// import 'package:hw3_movie_booking_app/data/data.vos/checkout_request_vo.dart';
// import 'package:hw3_movie_booking_app/data/data.vos/cinema_vo.dart';
// import 'package:hw3_movie_booking_app/data/data.vos/cinemalist_for_hive_vo.dart';
// import 'package:hw3_movie_booking_app/data/data.vos/movie_vo.dart';
// import 'package:hw3_movie_booking_app/data/data.vos/payment_vo.dart';
// import 'package:hw3_movie_booking_app/data/data.vos/seat_vo.dart';
// import 'package:hw3_movie_booking_app/data/data.vos/snack_vo.dart';
// import 'package:hw3_movie_booking_app/data/data.vos/user_select_vo.dart';
// import 'package:hw3_movie_booking_app/data/data.vos/user_vo.dart';
// import 'package:hw3_movie_booking_app/data/model/movie_model.dart';
// import 'package:hw3_movie_booking_app/network/data_agent/movie_data_agent.dart';
// import 'package:hw3_movie_booking_app/network/data_agent/retrofit_data_agent_impl.dart';
// import 'package:hw3_movie_booking_app/persistance/daos/actor_dao.dart';
// import 'package:hw3_movie_booking_app/persistance/daos/cards_from_profile_daos.dart';
// import 'package:hw3_movie_booking_app/persistance/daos/cinema_day_timeslot_dao.dart';
// import 'package:hw3_movie_booking_app/persistance/daos/movie_dao.dart';
// import 'package:hw3_movie_booking_app/persistance/daos/snack_dao.dart';
// import 'package:hw3_movie_booking_app/persistance/daos/user_dao.dart';
//
// class MovieModelImpl extends MovieModel{
//
//   MovieDataAgent _dataAgent = RetrofitDataAgentImpl();
//
//   static final MovieModelImpl _singleton = MovieModelImpl._internal();
//
//   factory MovieModelImpl(){
//     return _singleton;
//   }
//
//   MovieModelImpl._internal();
//
//   ///Database variable
//   UserDao mUserDao = UserDao();
//   CardsFromProfileDao cardDao = CardsFromProfileDao();
//   MovieDao mMovieDao = MovieDao();
//   ActorDao mActorDao = ActorDao();
//   CinemaDayTimeslotDao mCinemaDao = CinemaDayTimeslotDao();
//   SnackDao mSnackDao = SnackDao();
//
//   ///For user token
//   String getUserTokenFromDatabase(){
//     List<UserVO> foruserToken = mUserDao.getUserBox().values.toList();
//
//     var userToken = foruserToken[0].token;
//     return "Bearer ${userToken}";
//   }
//
//
//   ///Network
//   @override
//   Future<UserVO> postRegisterWithEmail(String name, String email, String phone, String password,String googlAccessToken,String facebookAccessToken) {
//     print("Data register in datalayer =========> ${name}  ${phone} ${email} ${password} ${googlAccessToken} ${facebookAccessToken}");
//     return _dataAgent.postRegisterWithEmail(name, email, phone, password,googlAccessToken,facebookAccessToken).then((userInfo){
//           var user = userInfo?[0] as UserVO;
//           user.token = userInfo?[1] as String;
//           mUserDao.saveUserInfo(user);
//           return Future.value(user);
//     });
//   }
//
//   @override
//   Future<UserVO> postLoginWithEmail(String email, String password) {
//     print("Data login data layer ========> ${email} ${password}");
//     return _dataAgent.postLoginWithEmail(email, password).then((userInfo){
//       var user = userInfo?[0] as UserVO;
//       user.token = userInfo?[1] as String;
//       mUserDao.saveUserInfo(user);
//       return Future.value(user);
//     });
//   }
//
//   @override
//   Future<UserVO> postLoginWithGoogle(String token) {
//     print("Google login data layer ===========> ${token}");
//     return _dataAgent.postLoginWithGoogle(token).then((userInfo){
//       var user = userInfo?[0] as UserVO;
//       user.token = userInfo?[1] as String;
//       mUserDao.saveUserInfo(user);
//       return Future.value(user);
//     });
//   }
//
//   @override
//   Future<UserVO> postLoginWithFacebook(String token) {
//     print("Facebook login data layer ===========> ${token}");
//    return _dataAgent.postLoginWithFacebook(token).then((userInfo) {
//       var user = userInfo?[0] as UserVO;
//       user.token = userInfo?[1] as String;
//       mUserDao.saveUserInfo(user);
//       return Future.value(user);
//    });
//   }
//
//   @override
//   Future<void> postLogout(String logoutToken) {
//     print("Data logout data layer ===========> ${logoutToken}");
//     return Future.value(_dataAgent.postLogout(logoutToken));
//   }
//
//   @override
//   Future<List<MovieVO>?> getComingSoonMovies() {
//     return _dataAgent.getComingSoonMovies(1).then((value){
//       List<MovieVO> comingSoon = value?.map((data){
//           data.isNowPlaying = false;
//           data.isComingSoon = true;
//           return data;
//       }).toList() ?? [];
//       mMovieDao.saveAllMovies(comingSoon);
//       return Future.value(value);
//     });
//   }
//
//   @override
//   Future<List<MovieVO>?> getNowPlayingMovies() {
//    return _dataAgent.getNowPlayingMovies(1).then((value){
//      List<MovieVO> nowPlaying = value?.map((data){
//           data.isNowPlaying = true;
//           data.isComingSoon = false;
//           return data;
//      }).toList() ?? [];
//      mMovieDao.saveAllMovies(nowPlaying);
//      return Future.value(value);
//    });
//   }
//
//   @override
//   Future<List<ActorVO>?> getCreditsByMovie(int movieId){
//     return _dataAgent.getCreditsByMovie(movieId).then((value){
//       ActorListForHiveVO actorList = ActorListForHiveVO(value);
//       print("Put to Hive Data =============> ${actorList}");
//       mActorDao.saveAllActors(movieId,actorList);
//         return Future.value(value);
//     });
//   }
//
//
//   @override
//   Future<MovieVO?> getMovieDetails(int movieId) {
//     return _dataAgent.getMovieDetails(movieId).then((value){
//           mMovieDao.saveSingleMovies(value!);
//           return Future.value(value);
//     });
//   }
//
//
//   // @override
//   // Future<List<CinemaVO>?> getCinemaDayTimeslot(String userToken, String movieId, String date) {
//   //   print("Cinema Day TimeSlot data layer =========> ${userToken} ${movieId} ${date}");
//   //   return _dataAgent.getCinemaDayTimeslot(userToken, movieId, date).then((data){
//   //     List<CinemaVO> getTimeData = data?.map((timeData){
//   //       timeData.timeslots?.map((chooseTime){
//   //         chooseTime.isSelected = false;
//   //         return chooseTime;
//   //       }).toList() ?? [];
//   //       return timeData;
//   //     }).toList() ?? [];
//   //     return Future.value(data);
//   //   });
//   // }
//   @override
//   Future<List<CinemaVO>?> getCinemaDayTimeslot(String userToken, String movieId, String date) {
//     print("Cinema Day TimeSlot data layer =========> ${userToken} ${movieId} ${date}");
//     return _dataAgent.getCinemaDayTimeslot(userToken, movieId, date).then((data){
//          List<CinemaVO> getTimeData = data?.map((timeData){
//             timeData.timeslots?.map((chooseTime){
//                 chooseTime.isSelected = false;
//                 return chooseTime;
//             }).toList() ?? [];
//             return timeData;
//          }).toList() ?? [];
//         CinemaListForHiveVO cinemaList = CinemaListForHiveVO(data);
//          print("Put to Hive Data =============> ${cinemaList}");
//          mCinemaDao.saveAllCinemaDayTimeslot(date,cinemaList);
//          return Future.value(data);
//     });
//   }
//
//   @override
//   Future<List<SeatVO>?> getCinemaSeatingPlan(String userToken, String cinemaDayTimeslotId, String bookingDate) {
//     print("Cinema Seating Plan Data Layer =========> ${userToken} ${cinemaDayTimeslotId} ${bookingDate}");
//     return _dataAgent.getCinemaSeatingPlan(userToken, cinemaDayTimeslotId, bookingDate)
//     .then((seatData){
//
//       List<List<SeatVO>>? getSeat = seatData?.map((data){
//           List<SeatVO>? lastList = data.map((fixData){
//             fixData.isSelected = false;
//             return fixData;
//           }).toList();
//           return data;
//       }).toList() ?? [];
//
//       int length = seatData?.length ?? 1;
//        List<SeatVO> fixedSeat = [];
//       for(int i=0;i<length;i++){
//         for(int j=0;j<seatData![i].length;j++){
//             fixedSeat.add(seatData[i][j]);
//         }
//       }
//         print("Test Adding list ==========> ${fixedSeat}");
//         //print("Outer length =======> ${length}");
//         //print("Test Adding list length ==========> ${fixedSeat.length}");
//         return Future.value(fixedSeat);
//     });
//   }
//
//
//
//   @override
//   Future<List<PaymentVO>?> getPaymentMethod() {
//     //print("Payment Method Data layer ========> ${userToken}");
//     return _dataAgent.getPaymentMethod(getUserTokenFromDatabase()).then((cards){
//         List<PaymentVO> getCards = cards?.map((data){
//             data.isSelected = false;
//             return data;
//         }).toList() ?? [];
//         return Future.value(cards);
//     });
//   }
//
//   @override
//   Future<List<SnackVO>?> getSnackList(String userToken) {
//     print("Snack List Data layer ========> ${userToken}");
//     return _dataAgent.getSnackList(userToken).then((snacks){
//       List<SnackVO> getSnack = snacks?.map((data){
//         data.quantity = 0;
//         return data;
//       }).toList() ?? [];
//       mSnackDao.saveAllSnacks(snacks ?? []);
//       return Future.value(snacks);
//     });
//   }
//
//
//   @override
//   Future<void> createCard(String userToken, String cardNumber, String cardHolder, String expirationDate, String cvc) {
//     print("Create Card Data layer =======> ${userToken} ${cardNumber} ${cardHolder} ${expirationDate} ${cvc}");
//       return _dataAgent.createCard(userToken, cardNumber, cardHolder, expirationDate, cvc);
//   }
//
//
//   @override
//   Future<UserVO?> getProfile(String userToken) {
//     return _dataAgent.getProfile(userToken).then((value){
//         cardDao.getCardsFromProfileDatabase(value?.cards ?? []);
//         return Future.value(value);
//     });
//   }
//
//   @override
//   Future<UserSelectVO?> checkout(String userToken, CheckoutRequestVO checkoutRequest) {
//     return _dataAgent.checkout(userToken, checkoutRequest);
//   }
//
//
//   ///Database
//   @override
//   Future<List<UserVO>> getLoginUserInfoDatabase() {
//       return Future.value(mUserDao.getUserInfo());
//   }
//
//   @override
//   Future<List<UserVO>> getRegisterUserInfoDatabase() {
//     return Future.value(mUserDao.getUserInfo());
//   }
//
//   @override
//   Future<void> logoutUserInfoDatabase() {
//       return Future.value(mUserDao.deleteUserInfo());
//   }
//
//   @override
//   Future<List<CardVO>?> getCardsFromProfileDatabase() {
//     return Future.value(cardDao.getAllCards());
//   }
//
//   @override
//   Future<List<MovieVO>?> getComingSoonMovieDatabase() {
//     return Future.value(
//         mMovieDao.getAllMovies().where((value) => value.isComingSoon ?? true).toList(),
//     );
//   }
//
//   @override
//   Future<List<MovieVO>?> getNowPlayingMovieDatabase() {
//     return Future.value(
//       mMovieDao.getAllMovies().where((value) => value.isNowPlaying ?? true).toList(),
//     );
//   }
//
//   @override
//   Future<MovieVO?> getMovieDetailsDatabase(int movieId) {
//     return Future.value(mMovieDao.getSingleMovie(movieId));
//   }
//
//   @override
//   Future<ActorListForHiveVO> getCreditsByMovieDatabase(int movieId) {
//     print("Get Data from Hive =========> ${mActorDao.getAllActors(movieId)}");
//     return Future.value(
//         mActorDao.getAllActors(movieId),
//     );
//   }
//
//   @override
//   Future<CinemaListForHiveVO> getCinemaDayTimeslotDatabase(String date) {
//     print("Get Data from Hive =========> ${ mCinemaDao.getAllCinemaDayTimeslot(date)}");
//     return Future.value(
//         mCinemaDao.getAllCinemaDayTimeslot(date),
//     );
//   }
//
//   @override
//   Future<List<SnackVO>?> getSnacksFromDatabase() {
//       return Future.value(mSnackDao.getAllSnacks());
//   }
//
// }


//__________________________________________________________________________________________________________



import 'package:flutter/material.dart';
import 'package:hw3_movie_booking_app/data/data.vos/actor_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/actorlist_for_hive_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/card_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/checkout_request_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/cinema_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/cinemalist_for_hive_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/movie_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/payment_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/seat_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/snack_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/user_select_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/user_vo.dart';
import 'package:hw3_movie_booking_app/data/model/movie_model.dart';
import 'package:hw3_movie_booking_app/network/data_agent/movie_data_agent.dart';
import 'package:hw3_movie_booking_app/network/data_agent/retrofit_data_agent_impl.dart';
import 'package:hw3_movie_booking_app/persistance/daos/actor_dao.dart';
import 'package:hw3_movie_booking_app/persistance/daos/cards_from_profile_daos.dart';
import 'package:hw3_movie_booking_app/persistance/daos/cinema_day_timeslot_dao.dart';
import 'package:hw3_movie_booking_app/persistance/daos/movie_dao.dart';
import 'package:hw3_movie_booking_app/persistance/daos/snack_dao.dart';
import 'package:hw3_movie_booking_app/persistance/daos/user_dao.dart';

class MovieModelImpl extends MovieModel{

  MovieDataAgent _dataAgent = RetrofitDataAgentImpl();

  static final MovieModelImpl _singleton = MovieModelImpl._internal();

  factory MovieModelImpl(){
    return _singleton;
  }

  MovieModelImpl._internal();

  ///Database variable
  UserDao mUserDao = UserDao();
  CardsFromProfileDao cardDao = CardsFromProfileDao();
  MovieDao mMovieDao = MovieDao();
  ActorDao mActorDao = ActorDao();
  CinemaDayTimeslotDao mCinemaDao = CinemaDayTimeslotDao();
  SnackDao mSnackDao = SnackDao();

  ///For user token
  String getUserTokenFromDatabase(){
    List<UserVO> foruserToken = mUserDao.getUserBox().values.toList();

    var userToken = foruserToken[0].token;
    return "Bearer ${userToken}";
  }


  ///Network
  @override
  Future<UserVO> postRegisterWithEmail(String name, String email, String phone, String password,String googlAccessToken,String facebookAccessToken) {
    print("Data register in datalayer =========> ${name}  ${phone} ${email} ${password} ${googlAccessToken} ${facebookAccessToken}");
    return _dataAgent.postRegisterWithEmail(name, email, phone, password,googlAccessToken,facebookAccessToken).then((userInfo){
      var user = userInfo?[0] as UserVO;
      user.token = userInfo?[1] as String;
      mUserDao.saveUserInfo(user);
      return Future.value(user);
    });
  }

  @override
  Future<UserVO> postLoginWithEmail(String email, String password) {
    print("Data login data layer ========> ${email} ${password}");
    return _dataAgent.postLoginWithEmail(email, password).then((userInfo){
      var user = userInfo?[0] as UserVO;
      user.token = userInfo?[1] as String;
      mUserDao.saveUserInfo(user);
      return Future.value(user);
    });
  }

  @override
  Future<UserVO> postLoginWithGoogle(String token) {
    print("Google login data layer ===========> ${token}");
    return _dataAgent.postLoginWithGoogle(token).then((userInfo){
      var user = userInfo?[0] as UserVO;
      user.token = userInfo?[1] as String;
      mUserDao.saveUserInfo(user);
      return Future.value(user);
    });
  }

  @override
  Future<UserVO> postLoginWithFacebook(String token) {
    print("Facebook login data layer ===========> ${token}");
    return _dataAgent.postLoginWithFacebook(token).then((userInfo) {
      var user = userInfo?[0] as UserVO;
      user.token = userInfo?[1] as String;
      mUserDao.saveUserInfo(user);
      return Future.value(user);
    });
  }

  @override
  Future<void> postLogout() {
    //print("Data logout data layer ===========> ${logoutToken}");
    return Future.value(_dataAgent.postLogout(getUserTokenFromDatabase()));
  }

  @override
  Future<List<MovieVO>?> getComingSoonMovies() {
    return _dataAgent.getComingSoonMovies(1).then((value){
      List<MovieVO> comingSoon = value?.map((data){
        data.isNowPlaying = false;
        data.isComingSoon = true;
        return data;
      }).toList() ?? [];
      mMovieDao.saveAllMovies(comingSoon);
      return Future.value(value);
    });
  }

  @override
  Future<List<MovieVO>?> getNowPlayingMovies() {
    return _dataAgent.getNowPlayingMovies(1).then((value){
      List<MovieVO> nowPlaying = value?.map((data){
        data.isNowPlaying = true;
        data.isComingSoon = false;
        return data;
      }).toList() ?? [];
      mMovieDao.saveAllMovies(nowPlaying);
      return Future.value(value);
    });
  }

  @override
  Future<List<ActorVO>?> getCreditsByMovie(int movieId){
    return _dataAgent.getCreditsByMovie(movieId).then((value){
      ActorListForHiveVO actorList = ActorListForHiveVO(value);
      print("Put to Hive Data =============> ${actorList}");
      mActorDao.saveAllActors(movieId,actorList);
      return Future.value(value);
    });
  }


  @override
  Future<MovieVO?> getMovieDetails(int movieId) {
    return _dataAgent.getMovieDetails(movieId).then((value){
      mMovieDao.saveSingleMovies(value!);
      return Future.value(value);
    });
  }


  // @override
  // Future<List<CinemaVO>?> getCinemaDayTimeslot(String userToken, String movieId, String date) {
  //   print("Cinema Day TimeSlot data layer =========> ${userToken} ${movieId} ${date}");
  //   return _dataAgent.getCinemaDayTimeslot(userToken, movieId, date).then((data){
  //     List<CinemaVO> getTimeData = data?.map((timeData){
  //       timeData.timeslots?.map((chooseTime){
  //         chooseTime.isSelected = false;
  //         return chooseTime;
  //       }).toList() ?? [];
  //       return timeData;
  //     }).toList() ?? [];
  //     return Future.value(data);
  //   });
  // }
  @override
  Future<List<CinemaVO>?> getCinemaDayTimeslot(String movieId, String date) {
    //print("Cinema Day TimeSlot data layer =========> ${userToken} ${movieId} ${date}");
    return _dataAgent.getCinemaDayTimeslot(getUserTokenFromDatabase(), movieId, date).then((data){
      List<CinemaVO> getTimeData = data?.map((timeData){
        timeData.timeslots?.map((chooseTime){
          chooseTime.isSelected = false;
          return chooseTime;
        }).toList() ?? [];
        return timeData;
      }).toList() ?? [];
      CinemaListForHiveVO cinemaList = CinemaListForHiveVO(data);
      print("Put to Hive Data =============> ${cinemaList}");
      mCinemaDao.saveAllCinemaDayTimeslot(date,cinemaList);
      return Future.value(data);
    });
  }

  @override
  Future<List<SeatVO>?> getCinemaSeatingPlan(String cinemaDayTimeslotId, String bookingDate) {
    //print("Cinema Seating Plan Data Layer =========> ${userToken} ${cinemaDayTimeslotId} ${bookingDate}");
    return _dataAgent.getCinemaSeatingPlan(getUserTokenFromDatabase(), cinemaDayTimeslotId, bookingDate)
        .then((seatData){

      List<List<SeatVO>>? getSeat = seatData?.map((data){
        List<SeatVO>? lastList = data.map((fixData){
          fixData.isSelected = false;
          return fixData;
        }).toList();
        return data;
      }).toList() ?? [];

      int length = seatData?.length ?? 1;
      List<SeatVO> fixedSeat = [];
      for(int i=0;i<length;i++){
        for(int j=0;j<seatData![i].length;j++){
          fixedSeat.add(seatData[i][j]);
        }
      }
      print("Test Adding list ==========> ${fixedSeat}");
      //print("Outer length =======> ${length}");
      //print("Test Adding list length ==========> ${fixedSeat.length}");
      return Future.value(fixedSeat);
    });
  }



  @override
  Future<List<PaymentVO>?> getPaymentMethod() {
    //print("Payment Method Data layer ========> ${userToken}");
    return _dataAgent.getPaymentMethod(getUserTokenFromDatabase()).then((cards){
      List<PaymentVO> getCards = cards?.map((data){
        data.isSelected = false;
        return data;
      }).toList() ?? [];
      return Future.value(cards);
    });
  }

  @override
  Future<List<SnackVO>?> getSnackList() {
   // print("Snack List Data layer ========> ${userToken}");
    return _dataAgent.getSnackList(getUserTokenFromDatabase()).then((snacks){
      List<SnackVO> getSnack = snacks?.map((data){
        data.quantity = 0;
        return data;
      }).toList() ?? [];
      mSnackDao.saveAllSnacks(snacks ?? []);
      return Future.value(snacks);
    });
  }


  @override
  Future<void> createCard( String cardNumber, String cardHolder, String expirationDate, String cvc) {
    //print("Create Card Data layer =======> ${userToken} ${cardNumber} ${cardHolder} ${expirationDate} ${cvc}");
    return _dataAgent.createCard(getUserTokenFromDatabase(), cardNumber, cardHolder, expirationDate, cvc);
  }


  @override
  Future<UserVO?> getProfile() {
    return _dataAgent.getProfile(getUserTokenFromDatabase()).then((value){
      cardDao.getCardsFromProfileDatabase(value?.cards ?? []);
      return Future.value(value);
    });
  }

  @override
  Future<UserSelectVO?> checkout( CheckoutRequestVO checkoutRequest) {
    return _dataAgent.checkout(getUserTokenFromDatabase(), checkoutRequest);
  }


  ///Database
  @override
  Future<List<UserVO>> getLoginUserInfoDatabase() {
    return Future.value(mUserDao.getUserInfo());
  }

  @override
  Future<List<UserVO>> getRegisterUserInfoDatabase() {
    return Future.value(mUserDao.getUserInfo());
  }

  @override
  Future<void> logoutUserInfoDatabase() {
    return Future.value(mUserDao.deleteUserInfo());
  }

  @override
  Future<List<CardVO>?> getCardsFromProfileDatabase() {
    return Future.value(cardDao.getAllCards());
  }

  @override
  Future<List<MovieVO>?> getComingSoonMovieDatabase() {
    return Future.value(
      mMovieDao.getAllMovies().where((value) => value.isComingSoon ?? true).toList(),
    );
  }

  @override
  Future<List<MovieVO>?> getNowPlayingMovieDatabase() {
    return Future.value(
      mMovieDao.getAllMovies().where((value) => value.isNowPlaying ?? true).toList(),
    );
  }

  @override
  Future<MovieVO?> getMovieDetailsDatabase(int movieId) {
    return Future.value(mMovieDao.getSingleMovie(movieId));
  }

  @override
  Future<ActorListForHiveVO> getCreditsByMovieDatabase(int movieId) {
    print("Get Data from Hive =========> ${mActorDao.getAllActors(movieId)}");
    return Future.value(
      mActorDao.getAllActors(movieId),
    );
  }

  @override
  Future<CinemaListForHiveVO> getCinemaDayTimeslotDatabase(String date) {
    print("Get Data from Hive =========> ${ mCinemaDao.getAllCinemaDayTimeslot(date)}");
    return Future.value(
      mCinemaDao.getAllCinemaDayTimeslot(date),
    );
  }

  @override
  Future<List<SnackVO>?> getSnacksFromDatabase() {
    return Future.value(mSnackDao.getAllSnacks());
  }

}