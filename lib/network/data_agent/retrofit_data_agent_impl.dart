import 'dart:math';

import 'package:dio/dio.dart';
import 'package:hw3_movie_booking_app/data/data.vos/actor_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/card_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/checkout_request_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/cinema_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/movie_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/payment_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/seat_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/snack_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/user_select_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/user_vo.dart';
import 'package:hw3_movie_booking_app/network/app_constants.dart';
import 'package:hw3_movie_booking_app/network/data_agent/movie_data_agent.dart';
import 'package:hw3_movie_booking_app/network/movie_list_api.dart';
import 'package:hw3_movie_booking_app/network/response/get_credit_movie_response.dart';
import 'package:hw3_movie_booking_app/network/the_movie_api.dart';

class RetrofitDataAgentImpl extends MovieDataAgent{

  late TheMovieApi mApi;

  late MovieListApi mListApi;

  static final RetrofitDataAgentImpl _singleton = RetrofitDataAgentImpl._internal();

  factory RetrofitDataAgentImpl(){
    return _singleton;
  }

  RetrofitDataAgentImpl._internal(){
    final dio = Dio();
    dio.options = BaseOptions(
      headers:{
        HEADER_ACCEPT: APPLICATION_JSON,
        HEADER_CONTENT_TYPE: APPLICATION_JSON,
      },
    );
    mApi = TheMovieApi(dio);
    mListApi = MovieListApi(dio);
  }

  @override
  Future<List<dynamic>?> postRegisterWithEmail(String name, String email, String phone, String password,String googleAccessToken,String facebookAccessToken) {
    print("Data Register network layer ===========> ${name} ${email} ${phone} ${password} ${googleAccessToken} ${facebookAccessToken}");

    return mApi.postRegisterWithEmail(name,email,phone,password,googleAccessToken,facebookAccessToken)
        .asStream()
        .map((data) => [data.data,data.token])
        .first;
  }


  @override
  Future<List?> postLoginWithEmail(String email, String password) {
    print("Data login network layer ===========> ${email} ${password}");
    return mApi.postLoginWithEmail(email, password)
        .asStream()
        .map((data) => [data.data,data.token])
        .first;
  }

  @override
  Future<List?> postLoginWithGoogle(String token) {
    print("Google login network layer ===========> ${token}");
    return mApi.postLoginWithGoogle(token)
        .asStream()
        .map((event) => [event.data,event.token])
        .first;
  }

  @override
  Future<List?> postLoginWithFacebook(String token) {
    print("Facebook login network layer ===========> ${token}");
   return mApi.postLoginWithFacebook(token)
       .asStream()
       .map((event) => [event.data,event.token])
       .first;
  }

  @override
  Future<void> postLogout(String logoutToken) {
    print("Data logout network layer ===========> ${logoutToken}");
      return mApi.postLogout(logoutToken);
  }

  @override
  Future<List<MovieVO>?> getComingSoonMovies(int page) {
      return mListApi.getComingSoonMovies(API_KEY, LANGUAGE, page.toString())
          .asStream()
          .map((response) => response.results )
          .first;
  }

  @override
  Future<List<MovieVO>?> getNowPlayingMovies(int page) {
      return mListApi.getNowPlayingMovies(API_KEY, LANGUAGE, page.toString())
          .asStream()
          .map((response) => response.results)
          .first;
  }

  @override
  Future<List<ActorVO>?> getCreditsByMovie(int movieId) {
    return mListApi.getCreditsByMovie(movieId.toString(), API_KEY, LANGUAGE)
        .asStream()
        .map((response) => response.cast)
        .first;
  }

  @override
  Future<MovieVO?> getMovieDetails(int movieId) {
    return mListApi.getMovieDetails(movieId.toString(), API_KEY, LANGUAGE);
  }

  @override
  Future<List<CinemaVO>?> getCinemaDayTimeslot(String userToken, String movieId, String date) {
    print("Cinema Day TimeSlot network layer =========> ${userToken} ${movieId} ${date}");
   return mApi.getCinemaDayTimeslot(userToken, movieId, date)
       .asStream()
       .map((response) => response.data)
       .first;
  }

  @override
  Future<List<List<SeatVO>>?> getCinemaSeatingPlan(String userToken, String cinemaDayTimeslotId, String bookingDate) {
    print("Cinema Seating Plan Network Layer =========> ${userToken} ${cinemaDayTimeslotId} ${bookingDate}");
    return mApi.getCinemaSeatingPlan(userToken, cinemaDayTimeslotId, bookingDate)
        .asStream()
        .map((response) => response.data)
        .first;
  }

  @override
  Future<List<PaymentVO>?> getPaymentMethod(String userToken) {
    print("Get Payment Network layer =========> ${userToken}");
    return mApi.getPaymentMethodResponse(userToken)
        .asStream()
        .map((response) => response.data)
        .first;
  }

  @override
  Future<List<SnackVO>?> getSnackList(String userToken) {
    print("Get Snack List Network layer =========> ${userToken}");
    return mApi.getSnackListResponse(userToken)
        .asStream()
        .map((response) => response.data)
        .first;
  }

  @override
  Future<List<CardVO>?> createCard(String userToken, String cardNumber, String cardHolder, String expirationDate, String cvc) {
    print("Create Card Network layer =======> ${userToken} ${cardNumber} ${cardHolder} ${expirationDate} ${cvc}");
    return mApi.postCreateCard(userToken, cardNumber, cardHolder, expirationDate, cvc)
        .asStream()
        .map((response) => response.data)
        .first;
  }

  @override
  Future<UserVO?> getProfile(String userToken) {
    return mApi.getProfile(userToken)
        .asStream()
        .map((response) => response.data)
        .first;
  }

  @override
  Future<UserSelectVO?> checkout(String userToken, CheckoutRequestVO checkoutRequest) {
    return mApi.postCheckout(userToken, checkoutRequest)
        .asStream()
        .map((response) => response.data)
        .first;
  }





}