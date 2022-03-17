import 'package:flutter/foundation.dart';
import 'package:hw3_movie_booking_app/data/data.vos/user_vo.dart';
import 'package:hw3_movie_booking_app/data/model/movie_model.dart';
import 'package:hw3_movie_booking_app/data/model/movie_model_impl.dart';

class PaymentInfoScreenBloc extends ChangeNotifier{

  ///Movie Model
  MovieModel movieModel = MovieModelImpl();


  Future<UserVO?> newCardCreation(String newCardNumber,String newCardHolder,String expirationDate,String cvc){
   
   return movieModel.createCard(newCardNumber,newCardHolder,expirationDate,cvc).then((value){
      movieModel.getProfile();
    }).catchError((error){
          debugPrint("Create Card Error =======> ${error.toString}");
    });
  }

}