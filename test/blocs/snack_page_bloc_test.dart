import 'package:flutter_test/flutter_test.dart';
import 'package:hw3_movie_booking_app/blocs/snack_screen_page_bloc.dart';

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


  });

}