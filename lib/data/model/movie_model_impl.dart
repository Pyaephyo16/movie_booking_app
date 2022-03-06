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
import 'package:hw3_movie_booking_app/persistance/daos/payment_method_dao.dart';
import 'package:hw3_movie_booking_app/persistance/daos/snack_dao.dart';
import 'package:hw3_movie_booking_app/persistance/daos/user_dao.dart';
import 'package:stream_transform/stream_transform.dart';

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
  PaymentMethodDao paymentMethodDao = PaymentMethodDao();

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
      print("Check insert data into database ==========> ${user}");
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
    return Future.value(_dataAgent.postLogout(getUserTokenFromDatabase()));
  }

  @override
  void getComingSoonMovies() {
    _dataAgent.getComingSoonMovies(1).then((value){
      List<MovieVO> comingSoon = value?.map((data){
        data.isNowPlaying = false;
        data.isComingSoon = true;
        return data;
      }).toList() ?? [];
       print("Coming Soon Movie Data insertion to database ==============> ${comingSoon}");
      mMovieDao.saveAllMovies(comingSoon);
      //return Future.value(value);
    });
  }

  @override
  void getNowPlayingMovies() {
     _dataAgent.getNowPlayingMovies(1).then((value){
      List<MovieVO> nowPlaying = value?.map((data){
        data.isNowPlaying = true;
        data.isComingSoon = false;
        return data;
      }).toList() ?? [];
    print("Nowplaying Movie Data insertion to database ==============> ${nowPlaying}");
      mMovieDao.saveAllMovies(nowPlaying);
      //return Future.value(value);
    });
  }

  @override
  void getCreditsByMovie(int movieId){
     _dataAgent.getCreditsByMovie(movieId).then((value){
      ActorListForHiveVO actorList = ActorListForHiveVO(value);
      print("Actor list Put to Hive Data =============> ${actorList}");
      mActorDao.saveAllActors(movieId,actorList);
      //return Future.value(value);
    });
  }


  @override
  void getMovieDetails(int movieId) {
     _dataAgent.getMovieDetails(movieId).then((value){
       print("Movie Detail insertion into database =======> ${value}");
      mMovieDao.saveSingleMovies(value!);
      //return Future.value(value);
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
  void getCinemaDayTimeslot(String movieId, String date) {
    print("Cinema Day TimeSlot data layer =========> ${movieId} ${date}");
     _dataAgent.getCinemaDayTimeslot(getUserTokenFromDatabase(), movieId, date).then((data){
      List<CinemaVO> getTimeData = data?.map((timeData){
        timeData.timeslots?.map((chooseTime){
          chooseTime.isSelected = false;
          return chooseTime;
        }).toList() ?? [];
        return timeData;
      }).toList() ?? [];
      CinemaListForHiveVO cinemaList = CinemaListForHiveVO(getTimeData);
      print("Cinema Day Timeslot Put to Hive Data =============> ${cinemaList}");
      mCinemaDao.saveAllCinemaDayTimeslot(date,cinemaList);
      //return Future.value(data);
    });
  }

  @override
  Future<List<SeatVO>?> getCinemaSeatingPlan(String cinemaDayTimeslotId, String bookingDate) {
    print("Cinema Seating Plan Data Layer =========> ${cinemaDayTimeslotId} ${bookingDate}");
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
  void getPaymentMethod() {
     _dataAgent.getPaymentMethod(getUserTokenFromDatabase()).then((cards){
      List<PaymentVO> getCards = cards?.map((data){
        data.isSelected = false;
        return data;
      }).toList() ?? [];
      print("All Payment Methods into database ===================> ${getCards}");
      paymentMethodDao.saveAllPaymentMethod(getCards);
      //return Future.value(cards);
    });
  }

  @override
  void getSnackList() {
     _dataAgent.getSnackList(getUserTokenFromDatabase()).then((snacks){
      List<SnackVO> getSnack = snacks?.map((data){
        data.quantity = 0;
        return data;
      }).toList() ?? [];
      print("Snack list insertion into hive =====================> ${snacks}");
      mSnackDao.saveAllSnacks(snacks ?? []);
     // return Future.value(snacks);
    });
  }


  @override
  Future<void> createCard( String cardNumber, String cardHolder, String expirationDate, String cvc) {
    print("Create Card Data layer =======>  ${cardNumber} ${cardHolder} ${expirationDate} ${cvc}");
    return _dataAgent.createCard(getUserTokenFromDatabase(), cardNumber, cardHolder, expirationDate, cvc);
  }


  @override
  Future<UserVO?> getProfile() {
    return _dataAgent.getProfile(getUserTokenFromDatabase()).then((value){
      print("All cards put into database ======================> ${value?.cards}");
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
  Stream<List<UserVO>> getLoginUserInfoDatabase() {
    //return Future.value(mUserDao.getUserInfo());
    return mUserDao
          .getUserInfoEventStream()
          .startWith(mUserDao.getUserInfoStream())
          .map((event) => mUserDao.getUserInfoData()
          );
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
  Stream<List<CardVO>> getCardsFromProfileDatabase() {
    //return Future.value(cardDao.getAllCards());
    this.getProfile();
    return cardDao
    .getAllCardsEventStream()
    .startWith(cardDao.getAllCardsStream())
    .map((event) => cardDao.getAllCardsData());
  }

  @override
  Stream<List<MovieVO>> getComingSoonMovieDatabase() {
    // return Future.value(
    //   mMovieDao.getAllMovies()
    //   .where((value) => value.isComingSoon ?? true)
    //   .toList(),
    // );
      this.getComingSoonMovies();
      return mMovieDao
      .getAllMoviesEventStream()
      .startWith(mMovieDao.getComingSoonMoviesStream())
      .map((event) => mMovieDao.getComingSoonMovies());
  }

  @override
  Stream<List<MovieVO>> getNowPlayingMovieDatabase() {
    // return Future.value(
    //   mMovieDao.getAllMovies()
    //   .where((value) => value.isNowPlaying ?? true)
    //   .toList(),
    // );
      this.getNowPlayingMovies();
      return mMovieDao
        .getAllMoviesEventStream()
        .startWith(mMovieDao.getNowplayingMoviesStream())
        .map((event) => mMovieDao.getNowplayingMovies());
  }

  @override
  Stream<MovieVO?> getMovieDetailsDatabase(int movieId) {
    //return Future.value(mMovieDao.getSingleMovie(movieId));
      this.getMovieDetails(movieId);
      this.getNowPlayingMovieDatabase();
      this.getComingSoonMovieDatabase();
      return mMovieDao
      .getAllMoviesEventStream()
      .startWith(mMovieDao.getSingleMovieStream(movieId))
      .map((event) => mMovieDao.getSingleMovieData(movieId));
  }

  @override
  Stream<ActorListForHiveVO?> getCreditsByMovieDatabase(int movieId) {
    // print("Get Data from Hive =========> ${mActorDao.getAllActors(movieId)}");
    // return Future.value(
    //   mActorDao.getAllActors(movieId),
    // );
    this.getCreditsByMovie(movieId);
    return mActorDao
    .getActorEventStream()
    .startWith(mActorDao.getAllActorsStream(movieId))
    .map((event) => mActorDao.getAllActorsStream(movieId));
  }

  @override
  Stream<CinemaListForHiveVO?> getCinemaDayTimeslotDatabase(String date) {
    print("Get CinemaDayTimeslot  from Hive =========> ${ mCinemaDao.getAllCinemaDayTimeslot(date)}");
    // return Future.value(
    //   mCinemaDao.getAllCinemaDayTimeslot(date),
    // );
        this.getCinemaDayTimeslot("", date);
      return mCinemaDao
      .getAllCinemaDaytimeslotEventStream()
      .startWith(mCinemaDao.getCinemaDayTimeslotStream(date))
      .map((event) => mCinemaDao.getCinemaDayTimeslot(date));
  }

  @override
  Stream<List<SnackVO>?> getSnacksFromDatabase() {
    //return Future.value(mSnackDao.getAllSnacks());
      this.getSnackList();
      return mSnackDao
      .getAllSnacksEventStream()
      .startWith(mSnackDao.getAllSnacksStream())
      .map((event) => mSnackDao.getAllSnacksData());
  }

  @override
  Stream<List<PaymentVO>> getPaymentMethodFromDatabase() {
      // return Future.value(
      //   paymentMethodDao.getAllPaymentMethod()
      // );
      this.getPaymentMethod();
      return paymentMethodDao
      .getAllPaymentMethodEventStream()
      .startWith(paymentMethodDao.getPaymentMethodStream())
      .map((event) => paymentMethodDao.getPaymentMethod());
  }


///Delete Test
  @override
  Future<void> deleteAllCards() {
    return Future.value(cardDao.deleteAllCards());
  }

  @override
  Future<void> deleteMoviesData() {
   return Future.value(mMovieDao.DeleteMoviesData());
  }

}