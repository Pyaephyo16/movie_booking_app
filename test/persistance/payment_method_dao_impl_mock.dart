import 'package:hw3_movie_booking_app/data/data.vos/payment_vo.dart';
import 'package:hw3_movie_booking_app/persistance/abstraction_layer/payment_method_dao.dart';

import '../mock_data/mock_data.dart';

class PaymentMethodDaoImplMock extends PaymentMethodDao{

  Map<int,PaymentVO> paymentMethodDatabaseMock = {};

  @override
  List<PaymentVO> getAllPaymentMethod() {
    return paymentMockForTest();
  }

  @override
  Stream<void> getAllPaymentMethodEventStream() {
    return Stream<void>.value(null);
  }

  @override
  List<PaymentVO> getPaymentMethod() {
    if(paymentMockForTest() != null && paymentMockForTest().isNotEmpty){
      return paymentMockForTest();
    }else{
     return [];
   }
  }

  @override
  Stream<List<PaymentVO>> getPaymentMethodStream() {
   return Stream.value(
      paymentMockForTest(),
   );
  }

  @override
  void saveAllPaymentMethod(List<PaymentVO> paymentMethodList) {
    paymentMethodList.forEach((element) {
      paymentMethodDatabaseMock[element.id!] = element;
    });
  }



}