import 'package:hw3_movie_booking_app/data/data.vos/user_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/user_select_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/snack_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/seat_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/payment_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/movie_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/cinemalist_for_hive_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/checkout_request_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/actorlist_for_hive_vo.dart';
import 'package:hw3_movie_booking_app/data/model/movie_model.dart';

import '../mock_data/mock_data.dart';

class MovieModelImplMock extends MovieModel{

  @override
  Future<UserSelectVO?> checkout(CheckoutRequestVO checkoutRequest) {
    return Future.value(getMockCheckoutForTest());
  }

  @override
  Future<void> createCard(String cardNumber, String cardHolder, String expirationDate, String cvc) {
    return Future.value(createCardMockForTest());
  }

  @override
  Stream<UserVO?> getCardsFromProfileDatabase() {
    return Stream.value(profileMockForTest());
  }

  @override
  void getCinemaDayTimeslot(String movieId, String date) {
      //NO need to mock
  }

  @override
  Stream<CinemaListForHiveVO?> getCinemaDayTimeslotDatabase(String date) {
    return Stream.value(cinemaToDatabaseMock());
   
  }

  @override
  Future<List<SeatVO>?> getCinemaSeatingPlan(String cinemaDayTimeslotId, String bookingDate) {
    return Future.value(seatingForIntegrationForTest());
  }

  @override
  Stream<List<MovieVO>> getComingSoonMovieDatabase() {
    return Stream.value(
      moviesMockForTest()
      .where((element) => element.isComingSoon ?? false)
      .toList(),
      );
  }

  @override
  void getComingSoonMovies() {
    //NO need to mock
  }

  @override
  void getCreditsByMovie(int movieId) {
    //NO need to mock
  }

  @override
  Stream<ActorListForHiveVO?> getCreditsByMovieDatabase(int movieId) {
    return Stream.value(actorToDatabaseMock());
  }

  @override
  Stream<List<UserVO>> getLoginUserInfoDatabase() {
    return Stream.value([profileMockForTest()]);
  }

  @override
  void getMovieDetails(int movieId) {
    //No need to mock
  }

  @override
  Stream<MovieVO?> getMovieDetailsDatabase(int movieId, bool isNowPlaying) {
    return Stream.value(
      moviesMockForTest().first,
    );
  }

  @override
  Stream<List<MovieVO>> getNowPlayingMovieDatabase() {
    return Stream.value(
      moviesMockForTest()
      .where((element) => element.isNowPlaying ?? false)
      .toList(),
    );
  }

  @override
  void getNowPlayingMovies() {
    //NNo need to mock
  }

  @override
  void getPaymentMethod() {
    //No need to mock
  }

  @override
  Stream<List<PaymentVO>> getPaymentMethodFromDatabase() {
    return Stream.value(
        paymentMockForTest(),
    );
  }

  @override
  Future<UserVO?> getProfile() {
    return Future.value(profileMockForTest());
  }

  @override
  Future<List<UserVO>> getRegisterUserInfoDatabase() {
    return Future.value([profileMockForTest()]);
  }

  @override
  void getSnackList() {
    //No need to mock
  }

  @override
  Stream<List<SnackVO>?> getSnacksFromDatabase() {
    return Stream.value(snacksMockForTest());
  }

  @override
  Future<void> logoutUserInfoDatabase() {
    return Future.value(null);
  }

  @override
  Future<void> postLoginWithEmail(String email, String password) {
    return Future.value(null);
  }

  @override
  Future<void> postLoginWithFacebook(String token) {
    return Future.value(null);
  }

  @override
  Future<void> postLoginWithGoogle(String token) {
     return Future.value(null);
  }

  @override
  Future<void> postLogout() {
     return Future.value(null);
  }

  @override
  Future<void> postRegisterWithEmail(String name, String email, String phone, String password, String googlAccessToken, String facebookAccessToken) {
     return Future.value(null);
  }



}