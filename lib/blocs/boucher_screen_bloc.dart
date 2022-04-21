import 'package:flutter/foundation.dart';
import 'package:hw3_movie_booking_app/data/data.vos/user_select_vo.dart';

class boucherScreenBloc extends ChangeNotifier{

   UserSelectVO? boucherData;

  boucherScreenBloc(UserSelectVO data){

      userData(data);

  }

  UserSelectVO? userData(UserSelectVO data){
      boucherData = data;
      notifyListeners();
      return boucherData;
  }

}