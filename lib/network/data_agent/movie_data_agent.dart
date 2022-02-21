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
import 'package:hw3_movie_booking_app/network/response/get_credit_movie_response.dart';

abstract class MovieDataAgent{
    Future<List<dynamic>?> postRegisterWithEmail(String name,String email,String phone,String password,String googleAccessToken,String facebookAccessToken);
    Future<List<dynamic>?> postLoginWithEmail(String email,String password);
    Future<List<dynamic>?> postLoginWithGoogle(String token);
    Future<List<dynamic>?> postLoginWithFacebook(String token);
    Future<void> postLogout(String logoutToken);
    Future<List<MovieVO>?> getNowPlayingMovies(int page);
    Future<List<MovieVO>?> getComingSoonMovies(int page);
    Future<MovieVO?> getMovieDetails(int movieId);
    Future<List<ActorVO>?> getCreditsByMovie(int movieId);
    Future<List<CinemaVO>?> getCinemaDayTimeslot(String userToken,String movieId,String date);
    Future<List<List<SeatVO>>?> getCinemaSeatingPlan(String userToken,String cinemaDayTimeslotId,String bookingDate);
    Future<List<SnackVO>?> getSnackList(String userToken);
    Future<List<PaymentVO>?> getPaymentMethod(String userToken);
    Future<UserVO?> getProfile(String userToken);
    Future<List<CardVO>?> createCard(String userToken,String cardNumber,String cardHolder,String expirationDate,String cvc);
    Future<UserSelectVO?> checkout(String userToken,CheckoutRequestVO checkoutRequest);

}