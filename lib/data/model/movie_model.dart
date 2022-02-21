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
  Future<List<MovieVO>?> getNowPlayingMovies();
  Future<List<MovieVO>?> getComingSoonMovies();
  Future<MovieVO?> getMovieDetails(int movieId);
  Future<List<ActorVO>?> getCreditsByMovie(int movieId);
  Future<List<CinemaVO>?> getCinemaDayTimeslot(String movieId,String date);
  Future<List<SeatVO>?> getCinemaSeatingPlan(String cinemaDayTimeslotId,String bookingDate);
  Future<List<SnackVO>?> getSnackList();
  //String userToken
  Future<List<PaymentVO>?> getPaymentMethod();
   Future<UserVO?> getProfile();
  Future<void> createCard(String cardNumber,String cardHolder,String expirationDate,String cvc);
  Future<UserSelectVO?> checkout(CheckoutRequestVO checkoutRequest);

  ///Database
  Future<List<UserVO>> getRegisterUserInfoDatabase();
  Future<List<UserVO>> getLoginUserInfoDatabase();
  Future<void> logoutUserInfoDatabase();
  Future<List<CardVO>?> getCardsFromProfileDatabase();
  Future<List<MovieVO>?> getNowPlayingMovieDatabase();
  Future<List<MovieVO>?> getComingSoonMovieDatabase();
  Future<MovieVO?> getMovieDetailsDatabase(int movieId);
  Future<List<SnackVO>?> getSnacksFromDatabase();

  Future<ActorListForHiveVO> getCreditsByMovieDatabase(int movieId);
  Future<CinemaListForHiveVO> getCinemaDayTimeslotDatabase(String date);
}