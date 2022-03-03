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

abstract class MovieModel{
  ///Network
  Future<UserVO> postRegisterWithEmail(String name,String email,String phone,String password,String googlAccessToken,String facebookAccessToken);
  Future<UserVO> postLoginWithEmail(String email,String password);
  Future<UserVO> postLoginWithGoogle(String token);
  Future<UserVO> postLoginWithFacebook(String token);
  Future<void> postLogout();
  void getNowPlayingMovies();
  void getComingSoonMovies();
  void getMovieDetails(int movieId);
  void getCreditsByMovie(int movieId);
  void getCinemaDayTimeslot(String movieId,String date);
  Future<List<SeatVO>?> getCinemaSeatingPlan(String cinemaDayTimeslotId,String bookingDate);
  void getSnackList();
  void getPaymentMethod();
  Future<UserVO?> getProfile();
  Future<void> createCard(String cardNumber,String cardHolder,String expirationDate,String cvc);
  Future<UserSelectVO?> checkout(CheckoutRequestVO checkoutRequest);

  ///Database
  Future<List<UserVO>> getRegisterUserInfoDatabase();
  Stream<List<UserVO>> getLoginUserInfoDatabase();
  Future<void> logoutUserInfoDatabase();
  Stream<List<MovieVO>> getNowPlayingMovieDatabase();
  Stream<List<MovieVO>> getComingSoonMovieDatabase();
  Stream<MovieVO?> getMovieDetailsDatabase(int movieId);
  Stream<List<SnackVO>?> getSnacksFromDatabase();
  Stream<List<PaymentVO>> getPaymentMethodFromDatabase();
   Stream<List<CardVO>> getCardsFromProfileDatabase();

  Stream<ActorListForHiveVO?> getCreditsByMovieDatabase(int movieId);
  Stream<CinemaListForHiveVO?> getCinemaDayTimeslotDatabase(String date);


  Future<void> deleteAllCards();
}