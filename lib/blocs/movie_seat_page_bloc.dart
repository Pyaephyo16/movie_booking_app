import 'package:flutter/foundation.dart';
import 'package:hw3_movie_booking_app/data/data.vos/seat_vo.dart';
import 'package:hw3_movie_booking_app/data/model/movie_model.dart';
import 'package:hw3_movie_booking_app/data/model/movie_model_impl.dart';

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

  MovieSeatPageBloc(int userChoosedayTimeslotId,String dateData){

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
                  // movieModel.getCinemaSeatingPlan(cinemaDayTimeslotId.toString(), bookingDate).then((value){
                  //       if(value?[index].isSelected == false && value?[index].type != "taken") {
                  //             value?[index].isSelected = true;
                  //             pickTicketsCount++;
                  //             String name = value?[index].seatName ?? "";
                  //             pickSeatNumber.add(name);
                  //             int price = value?[index].price??0;
                  //             totalAmount = totalAmount+price;
                  //             seatRow.add(value?[index].symbol ?? "");
                  //           }else if(
                  //           value?[index].isSelected == true && value?[index].type != "taken"){
                  //             value?[index].isSelected = false;
                  //             pickTicketsCount--;
                  //             String name = value?[index].seatName ?? "";
                  //             pickSeatNumber.remove(name);
                  //             int price = value?[index].price??0;
                  //             totalAmount = totalAmount-price;
                  //             seatRow.remove(value?[index].symbol ?? "");
                  //           }
                  //           totalRow = seatRowSeparatedString(seatRow);
                  //           totalSeat = seatNumbersSeparatedString(pickSeatNumber);
                  //           fixedSeat = value;
                  //    notifyListeners();
                  // });

                      if(seat[index].isSelected == false && seat[index].type != "taken") {
                                seat[index].isSelected = true;
                                pickTicketsCount++;
                                String name = seat[index].seatName ?? "";
                                pickSeatNumber.add(name);
                                int price = seat[index].price??0;
                                totalAmount = totalAmount+price;
                                notifyListeners();
                                seatRow.add(seat[index].symbol ?? "");
                                notifyListeners();
                              }
                              else if(
                              seat[index].isSelected == true && seat[index].type != "taken"){
                                seat[index].isSelected = false;
                                pickTicketsCount--;
                                String name = seat[index].seatName ?? "";
                                notifyListeners();
                                pickSeatNumber.remove(name);
                                int price = seat[index].price??0;
                                totalAmount = totalAmount-price;
                                notifyListeners();
                                seatRow.remove(seat[index].symbol ?? "");
                                notifyListeners();
                              }
                              totalRow = seatRowSeparatedString(seatRow);
                             totalSeat = seatNumbersSeparatedString(pickSeatNumber);
                              //fixedSeat = seat;
                              notifyListeners();
                             }

        String seatNumbersSeparatedString(List<String> seatNumber){
    return seatNumber.map((number) => number).toList().join(",");
  }

  String seatRowSeparatedString(List<String> seatRow){
    return seatRow.map((row) => row).toList().join(",");
  }

  String userSelectionView(List<SeatVO> seat,int index){
    return seat[index].type == "text" ? seat[index].symbol ?? "" : seat[index].isSelected == true ? "${seat[index].id}" : "";
  }

}