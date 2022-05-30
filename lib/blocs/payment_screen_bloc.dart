import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:hw3_movie_booking_app/data/data.vos/card_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/checkout_request_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/snack_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/user_select_vo.dart';
import 'package:hw3_movie_booking_app/data/model/movie_model.dart';
import 'package:hw3_movie_booking_app/data/model/movie_model_impl.dart';

class PaymentScreenBloc extends ChangeNotifier{

  ///Movie Model
  MovieModel movieModel = MovieModelImpl();

  ///State Variables
  List<CardVO>? profile;
  UserSelectVO? boucherData;
  CardVO? userChoose;

  ///Test
  CheckoutRequestVO? userData;

  int? finalCost;
  int? cardId;

  PaymentScreenBloc({MovieModel? mModel}){


    if(mModel != null){
      movieModel = mModel;
    }

 ///Get All profile database
    movieModel.getCardsFromProfileDatabase().listen((value){
        print("All cards in view layer ===================> ${value?.cards}");
          profile = value?.cards;

        // for(int i=0;i< profile!.length;i++){
        //       temp.add(profile![profile!.length - (i+1)]);
        // } 

          notifyListeners();
      if(profile?.isNotEmpty ?? false){
        userChoose = profile?.last;
        notifyListeners();
      }
    }).onError((error){
      debugPrint("Get All Cards From Profile Database Error ============> ${error.toString()}");
    });

  }


  userSelectionCard(int index)async{
          userChoose = profile?[index];

          // List<CardVO>? tempForSelect = profile;

          // if(tempForSelect?.reversed.toList()[index].isSelected == true){
          //   tempForSelect?.reversed.toList()[index].isSelected = false;
          // }else{
          //   tempForSelect?.reversed.toList()[index].isSelected = true;
          // }
          // profile = tempForSelect;
          
          List<CardVO>? tempForSelect = profile?.reversed.toList().mapIndexed((num,element) {
                  if(index == num && element.isSelected == false){
                    element.isSelected = true;
                  }else if(index == num && element.isSelected == true){
                    element.isSelected = false;
                  }
                  return element;
          }).toList();
          profile = tempForSelect?.reversed.toList();
          notifyListeners();
  }

 Future<UserSelectVO?> userFinalSelection(int snackCost,int seatCost,
    int userChoosedayTimeslotId,String totalRow,String totalSeat,String dateData,
    int movieId,int cinemaId,List<SnackVO> snackListBought,
    ){
     finalCost = snackCost+seatCost;
           cardId = userChoose?.id;
        print("Cinema Id Check =======> ${cardId}");
        print("userChoosedayTimeslotId =======> ${userChoosedayTimeslotId}");
        print("totalRow =======> ${totalRow}");
        print("totalSeat =======> ${totalSeat}");
        print("dateData =======> ${dateData}");
        print("finalCost =======> ${finalCost}");
        print("movieId =======> ${movieId}");
        print("cinemaId =======> ${cinemaId}");
        print("snackListBought ============> ${snackListBought}");

  

       CheckoutRequestVO userData = CheckoutRequestVO(userChoosedayTimeslotId,totalRow,
        totalSeat,dateData.split(" ")[0],
        finalCost, movieId, cardId,cinemaId,
     snackListBought.length ==0 ? [] : snackListBought,
                    );

          print("UserData ====================> ${userData}");

                     ///Post Checkout
    return movieModel.checkout(userData).then((data){
      print("Api output data ===============> ${data}");
        boucherData = data;
        notifyListeners();
        return boucherData;
    }).catchError((error){
      debugPrint("Checkout Error =========> ${error.toString()}");
    });
  }

}