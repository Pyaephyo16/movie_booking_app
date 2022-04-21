import 'package:flutter_test/flutter_test.dart';
import 'package:hw3_movie_booking_app/blocs/movie_seat_page_bloc.dart';
import 'package:hw3_movie_booking_app/pages/movie_seats_page.dart';

import '../data.models/movie_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main(){

  group("Movie Seat Page Bloc",(){

    MovieSeatPageBloc? seatBloc;

      setUp((){
          seatBloc = MovieSeatPageBloc(1,"2022-04-12",mModel: MovieModelImplMock());
      });


      test("Fetch Seat Data",(){
        expect(
          seatBloc?.fixedSeat?.contains(seatingForIntegrationForTest().first), 
          true,
          );
      });

     

  });

}