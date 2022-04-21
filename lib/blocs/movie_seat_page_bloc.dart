import 'package:flutter/foundation.dart';
import 'package:hw3_movie_booking_app/data/data.vos/seat_vo.dart';
import 'package:hw3_movie_booking_app/data/model/movie_model.dart';
import 'package:hw3_movie_booking_app/data/model/movie_model_impl.dart';
import 'package:collection/collection.dart';

class MovieSeatPageBloc extends ChangeNotifier{

 ///Movie Model
  MovieModel movieModel = MovieModelImpl();

  ///State Variables
  List<SeatVO>? fixedSeat;

  int pickTicketsCount = 0;
  List<String> pickSeatNumber = [];
  int totalAmount = 0;
  List<String> seatRow = [];

  String? totalSeat;
  String? totalRow;

  MovieSeatPageBloc(int userChoosedayTimeslotId,String dateData,{MovieModel? mModel}){

    if(mModel != null){
      movieModel = mModel;
    }

       ///Get Cinema Seating Plan
    movieModel.getCinemaSeatingPlan(userChoosedayTimeslotId.toString(),dateData.split(" ")[0])
        .then((value){
        fixedSeat = value;
        notifyListeners();
    }).catchError((error){
      debugPrint("Get Cinema Seating Plan Error ======> ${error.toString()}");
    });

  }

 void userActionTakeAndRemoveSeat(List<SeatVO> seat,int index,int cinemaDayTimeslotId,String bookingDate){
                      if(seat[index].isSelected == false && seat[index].type != "taken") {
                               //seat[index].isSelected = true;

                            List<SeatVO>? newActionAddSeatList = fixedSeat?.mapIndexed((i, element){
                                if(i == index){
                                  element.isSelected = true;
                                }
                                return element;
                            }).toList();
                            fixedSeat = newActionAddSeatList;
                            notifyListeners();

                                pickTicketsCount++;
                                String name = fixedSeat?[index].seatName ?? "";
                                pickSeatNumber.add(name);
                                int price = fixedSeat?[index].price??0;
                                totalAmount = totalAmount+price;
                                notifyListeners();
                                seatRow.add(fixedSeat?[index].symbol ?? "");
                                notifyListeners();
                              }
                              else if(
                              fixedSeat?[index].isSelected == true && fixedSeat?[index].type != "taken"){
                                //seat[index].isSelected = false;

                                 List<SeatVO>? newActionRemoveSeatList = fixedSeat?.mapIndexed((i, element){
                                if(i == index){
                                  element.isSelected = false;
                                }
                                return element;
                            }).toList();
                            fixedSeat = newActionRemoveSeatList;
                            notifyListeners();


                                pickTicketsCount--;
                                String name = fixedSeat?[index].seatName ?? "";
                                notifyListeners();
                                pickSeatNumber.remove(name);
                                int price = fixedSeat?[index].price??0;
                                totalAmount = totalAmount-price;
                                notifyListeners();
                                seatRow.remove(fixedSeat?[index].symbol ?? "");
                                notifyListeners();
                              }
                              totalRow = seatRowSeparatedString(seatRow);
                             totalSeat = seatNumbersSeparatedString(pickSeatNumber);
                              notifyListeners();
                             }

        String seatNumbersSeparatedString(List<String> seatNumber){
    return seatNumber.map((number) => number).toList().join(",");
  }

  String seatRowSeparatedString(List<String> seatRow){
    return seatRow.map((row) => row).toList().join(",");
  }

  String userSelectionView(List<SeatVO> seat,int index){
    return fixedSeat?[index].type == "text" ? seat[index].symbol ?? "" : fixedSeat?[index].isSelected == true ? "${fixedSeat?[index].id}" : "";
  }

}