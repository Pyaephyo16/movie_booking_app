import 'package:hive/hive.dart';
import 'package:hw3_movie_booking_app/data/data.vos/payment_vo.dart';
import 'package:hw3_movie_booking_app/persistance/abstraction_layer/payment_method_dao.dart';
import 'package:hw3_movie_booking_app/persistance/hive_constants.dart';

class PaymentMethodDaoImpl extends PaymentMethodDao{

  static final PaymentMethodDaoImpl _singleton = PaymentMethodDaoImpl._internal();

  factory PaymentMethodDaoImpl(){
    return _singleton;
  }

  PaymentMethodDaoImpl._internal();

  @override
  void saveAllPaymentMethod(List<PaymentVO> paymentMethodList)async{
      Map<int,PaymentVO> getPaymentMethodMap = Map.fromIterable(
        paymentMethodList,
        key: (payment) => payment.id,
        value: (payment) => payment,
      );
     return getPaymentMethodBox().putAll(getPaymentMethodMap);
  }

  @override
  List<PaymentVO> getAllPaymentMethod(){
    return getPaymentMethodBox().values.toList();
  }


  ///Reactive Programming

  @override
  Stream<void> getAllPaymentMethodEventStream(){
    return getPaymentMethodBox().watch();
  }

  @override
  List<PaymentVO> getPaymentMethod(){
      if(getAllPaymentMethod() !=null && getAllPaymentMethod().isNotEmpty){
        print("All Payment Method in database =========> ${getAllPaymentMethod()}");
        return getAllPaymentMethod();
      }else{
        return [];
      }
  }

  @override
  Stream<List<PaymentVO>> getPaymentMethodStream(){
        return Stream.value(getAllPaymentMethod());
  }

  Box<PaymentVO> getPaymentMethodBox(){
    return Hive.box<PaymentVO>(BOX_NMAE_PAYMENT_METHOD_VO);
  }

}