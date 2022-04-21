import 'package:flutter_test/flutter_test.dart';
import 'package:hw3_movie_booking_app/blocs/boucher_screen_bloc.dart';

import '../mock_data/mock_data.dart';

void main(){

  group("Boucher Screen Test",(){

      boucherScreenBloc? boucherBloc;

      boucherBloc = boucherScreenBloc(getMockCheckoutForTest());

      test("Boucher Data Test",()async{
          boucherBloc?.userData(getMockCheckoutForTest());
          await Future.delayed(Duration(milliseconds: 600));
          expect(
            boucherBloc?.boucherData,
             getMockCheckoutForTest(),
             );
      });

  });

}
