import 'package:hive/hive.dart';
import 'package:hw3_movie_booking_app/data/data.vos/payment_vo.dart';
import 'package:hw3_movie_booking_app/persistance/hive_constants.dart';

class PaymentMethodDao{

  static final PaymentMethodDao _singleton = PaymentMethodDao._internal();

  factory PaymentMethodDao(){
    return _singleton;
  }

  PaymentMethodDao._internal();

  void saveAllPaymentMethod(List<PaymentVO> paymentMethodList)async{
      Map<int,PaymentVO> getPaymentMethodMap = Map.fromIterable(
        paymentMethodList,
        key: (payment) => payment.id,
        value: (payment) => payment,
      );
     return getPaymentMethodBox().putAll(getPaymentMethodMap);
  }

  List<PaymentVO> getAllPaymentMethod(){
    return getPaymentMethodBox().values.toList();
  }


  ///Reactive Programming

  Stream<void> getAllPaymentMethodEventStream(){
    return getPaymentMethodBox().watch();
  }

  List<PaymentVO> getPaymentMethodStream(){
      if(getAllPaymentMethod() !=null && getAllPaymentMethod().isNotEmpty){
        print("All Payment Method in database =========> ${getAllPaymentMethod()}");
        return getAllPaymentMethod();
      }else{
        return [];
      }
  }

  Box<PaymentVO> getPaymentMethodBox(){
    return Hive.box<PaymentVO>(BOX_NMAE_PAYMENT_METHOD_VO);
  }

}