import 'package:dio/dio.dart';
import 'package:hw3_movie_booking_app/data/data.vos/card_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/checkout_request_vo.dart';
import 'package:hw3_movie_booking_app/network/response/create_card_response.dart';
import 'package:hw3_movie_booking_app/network/response/get_cinema_day_timeslot_response.dart';
import 'package:hw3_movie_booking_app/network/response/get_cinema_seating_plan_response.dart';
import 'package:hw3_movie_booking_app/network/response/get_payment_method_response.dart';
import 'package:hw3_movie_booking_app/network/response/get_snack_list_response.dart';
import 'package:hw3_movie_booking_app/network/response/login_and_register_response.dart';
import 'package:hw3_movie_booking_app/network/response/movie_list_response.dart';
import 'package:hw3_movie_booking_app/network/response/post_checkout_response.dart';
import 'package:hw3_movie_booking_app/network/response/profile_response.dart';
import 'package:retrofit/http.dart';
import 'app_constants.dart';

part 'the_movie_api.g.dart';

@RestApi(baseUrl: BASE_URL_DIO)
abstract class TheMovieApi{
    factory TheMovieApi(Dio dio) = _TheMovieApi;

      @FormUrlEncoded()
      @POST(END_POINT_REGISTER_WITH_EMAIL)
    Future<LoginAndRegisterResponse> postRegisterWithEmail(
      @Field(REGISTER_USER_NAME) String name,
      @Field(REGISTER_USER_EMAIL) String email,
      @Field(REGISTER_USER_PHONE) String phone,
      @Field(REGISTER_USER_PASSWORD) String password,
      @Field(REGISTER_USER_GOOGLE_ACCESS_TOKEN) String googleAccessToken,
      @Field(REGISTER_USER_FACEBOOK_ACCESS_TOKEN) String facebookAccessToken,
    );

      @POST(END_POINT_LOGIN_WITH_EMAIL)
      @FormUrlEncoded()
     Future<LoginAndRegisterResponse> postLoginWithEmail(
         @Field() String email,
         @Field() String password,
         );

      @POST(END_POINT_LOGIN_WITH_GOOGLE)
      @FormUrlEncoded()
      Future<LoginAndRegisterResponse> postLoginWithGoogle(
          @Field(GOOGLE_LOGIN_ACCESS_TOKEN) String token,
          );

      @POST(END_POINT_LOGIN_WITH_FACEBOOK)
      @FormUrlEncoded()
      Future<LoginAndRegisterResponse> postLoginWithFacebook(
          @Field(FACEBOOK_LOGIN_ACCESS_TOKEN) String token,
          );

      @POST(END_POINT_LOGOUT)
    Future<void> postLogout(
    @Header(HEADER_AUTHORIZATION) String logoutToken,
          );
      
      @GET(END_POINT_CINEMA_DAY_TIMESLOT)
      Future<GetCinemaDayTimeslotResponse> getCinemaDayTimeslot(
          @Header(HEADER_AUTHORIZATION) String userToken,
          @Query(PARAM_MOVIE_ID) String movieId,
          @Query(PAPAM_DATE) String date,
          );

      @GET(END_POINT_SEAT_PLAN)
      Future<GetCinemaSeatingPlanResponse> getCinemaSeatingPlan(
          @Header(HEADER_AUTHORIZATION) String userToken,
          @Query(PARAM_CINEMA_DAY_TIMESLOT_ID) String cinemaDayTimeslotId,
          @Query(PARAM_BOOKING_DATE) String bookingDate,
          );

      @GET(END_POINT_SNACK_LIST)
      Future<GetSnackListResponse> getSnackListResponse(
          @Header(HEADER_AUTHORIZATION) String userToken,
          );

      @GET(END_POINT_PAYMENT_METHOD)
      Future<GetPaymentMethodResponse> getPaymentMethodResponse(
          @Header(HEADER_AUTHORIZATION) String userToken,
          );


      @GET(END_POINT_PROFILE)
      Future<ProfileResponse> getProfile(
          @Header(HEADER_AUTHORIZATION) String userToken,
          );

      @POST(END_POINT_CREATE_CARD)
      @FormUrlEncoded()
      Future<CreateCardResponse> postCreateCard(
          @Header(HEADER_AUTHORIZATION) String userToken,
          @Field(FIELD_CARD_NUMBER) String cardNumber,
          @Field(FIELD_CARD_HOLDER) String cardHolder,
          @Field(FIELD_EXPIRATION_DATE) String expirationDate,
          @Field(FIELD_CVC) String cvc,
          );
      
      @POST(END_POINT_CHECKOUT)
      Future<PostCheckoutResponse> postCheckout(
          @Header(HEADER_AUTHORIZATION) String userToken,
          @Body() CheckoutRequestVO checkoutRequest,
          );

}