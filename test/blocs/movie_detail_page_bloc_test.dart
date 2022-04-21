import 'package:flutter_test/flutter_test.dart';
import 'package:hw3_movie_booking_app/blocs/movie_detail_page_bloc.dart';

import '../data.models/movie_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main(){

group("Movie Detail Page Bloc",(){

    MovieDetailPageBloc? movieDetailBloc;


  setUp((){
    movieDetailBloc = MovieDetailPageBloc(508947, true,mModel: MovieModelImplMock());
  });



  test("Fetch Movie Details",(){
    expect(
      movieDetailBloc?.movieDetails,
       moviesMockForTest().first,
      );
  });


  test("Fetch Actors",(){
    expect(
      movieDetailBloc?.cast?.contains(actorToDatabaseMock().actorList?.first),
       true,
       );
  });

});

}