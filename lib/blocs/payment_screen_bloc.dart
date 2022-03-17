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
  CardVO? userChoose;
  //CardVO? forFirst;

  ///Test
  CheckoutRequestVO? userData;
  UserSelectVO? boucherData;

  int? finalCost;
  int? cardId;

  //int forRefresh = 0;

  PaymentScreenBloc(){

 ///Get All profile database
    movieModel.getCardsFromProfileDatabase().listen((value){
        print("All cards in view layer ===================> ${value?.cards}");
          profile = value?.cards;
          notifyListeners();
      if(profile?.isNotEmpty ?? false){
        userChoose = profile?[0];
        notifyListeners();
      }
    }).onError((error){
      debugPrint("Get All Cards From Profile Database Error ============> ${error.toString()}");
    });

  }

  //  Stream<UserSelectVO?> doCheckout(CheckoutRequestVO userData,String imageView,String movieName,String userChooseCinema){
  //   ///Post Checkout
  //   movieModel.checkout(userData).then((data){
  //       boucherData = data;
  //       notifyListeners();
  //   }).catchError((error){
  //     debugPrint("Checkout Error =========> ${error.toString()}");
  //   });
  //   return Stream.value(boucherData);
  // }

  userSelectionCard(int index)async{
          userChoose = profile?[index];
          notifyListeners();
  }

 Future<UserSelectVO?> userFinalSelection(int snackCost,int seatCost,
    int userChoosedayTimeslotId,String totalRow,String totalSeat,String dateData,
    int movieId,int cinemaId,List<SnackVO> snackListBought,
    ){
     finalCost = snackCost+seatCost;
     //notifyListeners();
           cardId = userChoose?.id;
           //notifyListeners();
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
                    //notifyListeners();

          print("UserData ====================> ${userData}");

                     ///Post Checkout
    return movieModel.checkout(userData).then((data){
      print("Api output data ===============> ${data}");
        boucherData = data;
        notifyListeners();
    }).catchError((error){
      debugPrint("Checkout Error =========> ${error.toString()}");
    });
  }

}