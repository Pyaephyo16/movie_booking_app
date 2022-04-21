import 'package:flutter_test/flutter_test.dart';
import 'package:hw3_movie_booking_app/blocs/movie_choose_time_page_bloc.dart';

import '../data.models/movie_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main(){

  group("Movie Choose Time Page Bloc",(){

      MovieChooseTimePageBloc? chooseTimeBloc;

  setUp((){
    chooseTimeBloc = MovieChooseTimePageBloc("2022-04-12",mModel: MovieModelImplMock());
  });


  test("Fetch Cinema Data",(){
    expect(
      chooseTimeBloc?.cinemaInfo?.contains(cinemaDayTimeslotMockForTest().first),
       true,
       );
  });


  test("Cinema Choose Time By User",()async{
    chooseTimeBloc?.getNewTimeslots("2022-04-13");
    await Future.delayed(Duration(milliseconds: 600));
    expect(
      chooseTimeBloc?.cinemaInfo?.contains(cinemaDayTimeslotMockForTest().last),
       true,
       );
  });

  });

}