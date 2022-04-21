import 'package:hw3_movie_booking_app/data/data.vos/payment_vo.dart';

abstract class PaymentMethodDao{

  void saveAllPaymentMethod(List<PaymentVO> paymentMethodList);
  List<PaymentVO> getAllPaymentMethod();
  
  Stream<void> getAllPaymentMethodEventStream();
  List<PaymentVO> getPaymentMethod();
  Stream<List<PaymentVO>> getPaymentMethodStream();

}