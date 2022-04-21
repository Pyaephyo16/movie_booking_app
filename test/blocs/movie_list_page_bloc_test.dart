import 'package:flutter_test/flutter_test.dart';
import 'package:hw3_movie_booking_app/blocs/movie_list_page_bloc.dart';

import '../data.models/movie_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main(){

group("Movie List Page BLoc",(){


    MovieListPageBloc? movieListBloc;

  setUp((){
    movieListBloc = MovieListPageBloc(mModel: MovieModelImplMock());
  });


  test("Fetch Login User Info",(){
    expect(
      movieListBloc?.userData?.contains(profileMockForTest()),
       true,
       );
  });


  test("Fetch Now Playing Movies",(){
      expect(
        movieListBloc?.nowPlayingMovieList?.contains(moviesMockForTest().first),
         true,
         );
  });


  test("Fetch Coming Soon Movies",(){
    expect(
      movieListBloc?.comingSoonMovieList?.contains(moviesMockForTest().last),
       true,
       );
  });

});

}