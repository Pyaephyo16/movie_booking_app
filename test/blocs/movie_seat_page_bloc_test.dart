import 'package:flutter_test/flutter_test.dart';
import 'package:hw3_movie_booking_app/blocs/movie_seat_page_bloc.dart';
import 'package:hw3_movie_booking_app/data/data.vos/seat_vo.dart';
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


      test("User Take Seat Test",(){
        seatBloc?.userActionTakeAndRemoveSeat(
          [
           SeatVO(  2, "available",  "B-1", "B", 2,false, ),
          ],
           0,
            1,
           "2022-04-12",
             );
           expect(
             seatBloc?.fixedSeat?.first.isSelected,
             true);
           expect(
             seatBloc?.pickTicketsCount,
              1);
            expect(
              seatBloc?.pickSeatNumber,
              ["B-1"]);
            expect(
              seatBloc?.totalAmount,
               2);
      });


      test("User Remove Seat Test",(){
        seatBloc?.userActionTakeAndRemoveSeat(
          [
           SeatVO(  2, "available",  "B-1", "B", 2,false, ),
          ],
           0,
            1,
           "2022-04-12",
             );
        seatBloc?.userActionTakeAndRemoveSeat(
            [
              SeatVO(  2, "available",  "B-1", "B", 2,true, ),
            ],
            0,
            1,
            "2022-04-12",
        );
        expect(
           seatBloc?.fixedSeat?.first.isSelected,
           false);
        expect(
          seatBloc?.pickTicketsCount,
           0);
           expect(
              seatBloc?.pickSeatNumber,
              []);
              expect(
              seatBloc?.totalAmount,
               0);
      });

     

  });

}