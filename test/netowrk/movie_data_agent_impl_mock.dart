import 'package:hw3_movie_booking_app/data/data.vos/user_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/user_select_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/snack_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/seat_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/payment_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/movie_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/cinema_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/checkout_request_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/card_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/actor_vo.dart';
import 'package:hw3_movie_booking_app/network/data_agent/movie_data_agent.dart';

import '../mock_data/mock_data.dart';

class MovieDataAgentImplMock extends MovieDataAgent{

  @override
  Future<UserSelectVO?> checkout(String userToken, CheckoutRequestVO checkoutRequest) {
   return Future.value(getMockCheckoutForTest());
  }

  @override
  Future<List<CardVO>?> createCard(String userToken, String cardNumber, String cardHolder, String expirationDate, String cvc) {
   return Future.value(createCardMockForTest());
  }

  @override
  Future<List<CinemaVO>?> getCinemaDayTimeslot(String userToken, String movieId, String date) {
    return Future.value(cinemaDayTimeslotMockForTest());
  }

  @override
  Future<List<List<SeatVO>>?> getCinemaSeatingPlan(String userToken, String cinemaDayTimeslotId, String bookingDate) {
    return Future.value(seatingPlanMockForTest());
  }

  @override
  Future<List<MovieVO>?> getComingSoonMovies(int page) {
    return Future.value(moviesMockForTest());
  }

  @override
  Future<List<ActorVO>?> getCreditsByMovie(int movieId) {
   return Future.value(actorsMockForTest());
  }

  @override
  Future<MovieVO?> getMovieDetails(int movieId) {
    return Future.value(moviesMockForTest().first);
  }

  @override
  Future<List<MovieVO>?> getNowPlayingMovies(int page) {
    return Future.value(moviesMockForTest());
  }

  @override
  Future<List<PaymentVO>?> getPaymentMethod(String userToken) {
    return Future.value(paymentMockForTest());
  }

  @override
  Future<UserVO?> getProfile(String userToken) {
    return Future.value(profileMockForTest());
  }

  @override
  Future<List<SnackVO>?> getSnackList(String userToken) {
    return Future.value(snacksMockForTest());
  }

  @override
  Future<List?> postLoginWithEmail(String email, String password) {
    // TODO: implement postLoginWithEmail
    throw UnimplementedError();
  }

      @override
  Future<List?> postRegisterWithEmail(String name, String email, String phone, String password, String googleAccessToken, String facebookAccessToken) {
    return Future.value(registerAndLoginMockForTest());
  }


  @override
  Future<List?> postLoginWithFacebook(String token) {
    return Future.value(registerAndLoginMockForTest());
  }

  @override
  Future<List?> postLoginWithGoogle(String token) {
    return Future.value(registerAndLoginMockForTest());
  }


  @override
  Future<void> postLogout(String logoutToken) {
   ///No need mock 
   return Future.value(null);
  }





}