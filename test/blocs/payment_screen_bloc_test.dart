import 'package:flutter_test/flutter_test.dart';
import 'package:hw3_movie_booking_app/blocs/payment_screen_bloc.dart';
import 'package:hw3_movie_booking_app/data/data.vos/snack_vo.dart';

import '../data.models/movie_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main(){

  group("Payment Cards Screen Test",(){

      PaymentScreenBloc? paymentBloc;

      setUp((){
        paymentBloc = PaymentScreenBloc(mModel: MovieModelImplMock());
      });


      test("Profile Data Test",(){
          expect(
            paymentBloc?.profile?.contains(profileMockForTest().cards?.first),
             true,
             );
      });

      test("Cards Last Data Test",()async{
          await Future.delayed(Duration(milliseconds: 600));
        expect(
          paymentBloc?.userChoose,
           profileMockForTest().cards?.last,
        );
      });


      test("Checkout Data Test",()async{
        paymentBloc?.userFinalSelection(
          8,10,1,"A","A-7,A-8","2022-04-12",335787,3,[SnackVO(1, "PopCorn", "Good Taste", 2, null, 1),],
        );
        await Future.delayed(Duration(milliseconds: 600));
        expect(
          paymentBloc?.boucherData,
           getMockCheckoutForTest(),
           );
      });

  });

}