import 'package:flutter_test/flutter_test.dart';
import 'package:hw3_movie_booking_app/blocs/snack_screen_page_bloc.dart';
import 'package:hw3_movie_booking_app/data/data.vos/snack_vo.dart';

import '../data.models/movie_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main(){

  group("Snack Page Bloc",(){

      SnackScreenPageBloc? snackBloc;

      setUp((){
        snackBloc = SnackScreenPageBloc(mModel: MovieModelImplMock());
      });


      test("Snack Data Test",(){
        expect(
          snackBloc?.snackList?.contains(snacksMockForTest().first), 
          true,
          );
      });

      test("Payment Method Test",(){
        expect(
          snackBloc?.cards?.contains(paymentMockForTest().first),
           true,
           );
      }
      );


      test("Snack increase test",(){
        snackBloc?.snackAdd(0);
        expect(
          snackBloc?.snackList?.first.quantity,
          1);
        expect(
          snackBloc?.snackList?.first.price,
           2);
      });


      test("Snack decrease test",(){
        snackBloc?.snackMinus(0);
        expect(
          snackBloc?.snackList?.first.quantity,
           0);
        expect(snackBloc?.donedone,
         0);
      });


      test("Payment Card User Action Test",(){
        snackBloc?.selectCard(0, true);
        expect(
          snackBloc?.cards?.first.isSelected,
           true);
      });



        test("User Taken Snack Test",(){
          snackBloc?.snackAdd(0);
          snackBloc?.userTakenSnack();
          expect(
            snackBloc?.snackListBought,
             [
             SnackVO(1, "Popcorn", "Et dolores eaque officia aut.", 2, "https://tmba.padc.com.mm/img/snack.jpg", 1),
             ],
             );
        });
  });

}