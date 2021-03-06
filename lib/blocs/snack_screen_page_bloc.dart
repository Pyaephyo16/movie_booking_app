import 'package:flutter/foundation.dart';
import 'package:hw3_movie_booking_app/data/data.vos/payment_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/snack_vo.dart';
import 'package:hw3_movie_booking_app/data/model/movie_model.dart';
import 'package:hw3_movie_booking_app/data/model/movie_model_impl.dart';
import 'package:collection/collection.dart';

class SnackScreenPageBloc extends ChangeNotifier{

  ///Movie Model
  MovieModel movieModel = MovieModelImpl();

  ///State Variable
  List<SnackVO>? snackList;
  List<PaymentVO>? cards;
  
  List<int> newCost = [];
  int donedone = 0;
  int totalamount = 0;
 List<SnackVO> snackListBought = [];


 SnackScreenPageBloc({MovieModel? mModel}){

   if(mModel != null){
     movieModel = mModel;
   }

   ///Get Snack List Database
    movieModel.getSnacksFromDatabase().listen((snacks){
        print("Get all snacks into data layer ==================> ${snacks}");
        snackList = snacks;
        notifyListeners();
    }).onError((error){
      debugPrint("Get Snack List Database Error =============> ${error.toString()}");
    });

    //Get Payment Method Database
    movieModel.getPaymentMethodFromDatabase().listen((cards) {
          print("All payment methods in view layer =================> ${cards}");
            this.cards = cards;
       notifyListeners();
    }).onError((error){
        debugPrint("Get Payment Method Database Error ============> ${error.toString()}");
    });

 }

    snackAdd(int index){
       totalamount = snackList![index].quantity ?? 0;
                   totalamount++;
                  //  isChooseCard = !isChooseCard;
                  //  notifyListeners();

                  List<SnackVO>? newActionAddSnack = snackList?.mapIndexed((i, element){
                      if(i == index){
                        element.quantity = totalamount;
                      }
                      return element;
                  }).toList();
                    snackList = newActionAddSnack;
                    notifyListeners();

              //snackList![index].quantity = totalamount;
        newCost.add(snackList![index].price ?? 0);
             donedone = newCost.reduce((f, s) => f+s);
        notifyListeners();
    }

    snackMinus(int index){
         totalamount = snackList![index].quantity ?? 0;
                  if(totalamount == 0){
                      return;
                  }
                 else if(totalamount != 0){
                   totalamount--;
                   //snackList![index].quantity = totalamount;
                  // isChooseCard = !isChooseCard;
                  //  notifyListeners();

                  List<SnackVO>? newActionRemoveSnack = snackList?.mapIndexed((i, element){
                      if(i == index){
                        element.quantity = totalamount;
                      }
                      return element;
                  }).toList();
                    snackList = newActionRemoveSnack;
                    notifyListeners();
                  }
               newCost.remove(snackList![index].price ?? 0);
               int tocut = snackList![index].price ?? 0;
              donedone= donedone-tocut;
              notifyListeners();
    }

    selectCard(int index,bool choosen){
    List<PaymentVO>? newActionPayment = cards?.mapIndexed((i, element){
          element.isSelected = false;
          if(i == index){
            element.isSelected = true;
          }
          return element;
    }).toList();
        cards = newActionPayment;
        notifyListeners();
    }

   Stream<List<SnackVO>> userTakenSnack(){
        var length = snackList?.length ?? 0;
                      print("Snack list lenght =======> ${length}");
                      for(int i=0;i<length;i++){
                        var amount = snackList?[i].quantity ?? 0;
                        print("Snack list quantity =======> ${snackList?[i].quantity}");
                        if(amount >0){
                                snackListBought.add(snackList![i]);
                                notifyListeners();
                                print("InserData Check ======> ${snackList![i]}");
                                print("USer Take length ===============> ${snackListBought.length}");
                                print("Data ===============> ${snackListBought[0].quantity}");
                        }
                      }
                      return Stream.value(snackListBought);
               }

}