import 'package:dio/dio.dart';
import 'package:hw3_movie_booking_app/data/data.vos/movie_vo.dart';
import 'package:hw3_movie_booking_app/network/app_constants.dart';
import 'package:hw3_movie_booking_app/network/response/get_credit_movie_response.dart';
import 'package:hw3_movie_booking_app/network/response/movie_list_response.dart';
import 'package:retrofit/http.dart';

part 'movie_list_api.g.dart';

@RestApi(baseUrl: BASE_MOVIE_URL_DIO)
abstract class MovieListApi{
    factory MovieListApi(Dio dio) = _MovieListApi;

    @GET(END_POINT_GET_NOW_PLAYING)
    Future<MovieListResponse> getNowPlayingMovies(
        @Query(PARAM_API_KEY) String apiKey,
        @Query(PARAM_LANGUAGE) String language,
        @Query(PARAM_PAGE) String page,
        );

    @GET(END_POINT_COMING_SOON)
    Future<MovieListResponse> getComingSoonMovies(
        @Query(PARAM_API_KEY) String apiKey,
        @Query(PARAM_LANGUAGE) String language,
        @Query(PARAM_PAGE) String page,
        );
    
    @GET("$END_POINT_MOVIE_DETAIL/{movie_id}")
    Future<MovieVO?> getMovieDetails(
        @Path("movie_id") String movieId,
        @Query(PARAM_API_KEY) String apiKey,
        @Query(PARAM_LANGUAGE) String language,
        );
    
    @GET("$END_POINT_CREDIT_MOVIE/{movie_id}/credits")
    Future<GetCreditMovieResponse> getCreditsByMovie(
        @Path("movie_id") String movieId,
        @Query(PARAM_API_KEY) String apiKey,
        @Query(PARAM_LANGUAGE) String language,
        );
}