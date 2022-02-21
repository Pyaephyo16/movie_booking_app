import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:hw3_movie_booking_app/data/data.vos/cinema_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/collection_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/timeslot_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/user_vo.dart';
import 'package:hw3_movie_booking_app/data/model/movie_model.dart';
import 'package:hw3_movie_booking_app/data/model/movie_model_impl.dart';
import 'package:hw3_movie_booking_app/pages/movie_seats_page.dart';
import 'package:hw3_movie_booking_app/resources/colors.dart';
import 'package:hw3_movie_booking_app/resources/dimens.dart';
import 'package:hw3_movie_booking_app/widgets/button_view.dart';

class MovieChooseTimePage extends StatefulWidget {

  final int movieId;
  final String movieName;
  final String imageView;

  MovieChooseTimePage({
   required this.movieId,
   required this.movieName,
   required this.imageView,
});

  @override
  State<MovieChooseTimePage> createState() => _MovieChooseTimePageState();
}

class _MovieChooseTimePageState extends State<MovieChooseTimePage> {

  ///Movie Model
  MovieModel movieModel = MovieModelImpl();

  ///State Variables
  List<CinemaVO>? cinemaInfo;
   List<UserVO>? userData;
   String? dateData;
   bool isChoose = false;
   String? userChooseTime;
   String? userChooseCinema;
   int? userChoosedayTimeslotId;
   int? cinemaId;

  @override
  void initState() {
    ///Get login userInfo From Database
    movieModel.getLoginUserInfoDatabase().then((userInfo){
      setState(() {
        userData = userInfo;
      });
      ///Cinema Day Timeslot
      //"Bearer ${userData?[0].token ?? "abc"}",
      movieModel.getCinemaDayTimeslot(widget.movieId.toString(),dateData?.split(" ")[0] ?? DateTime.now().toString().split(" ")[0]).then((value){
        setState(() {
          cinemaInfo = value;
        });
        ///Cinema Day Timeslot Database
        movieModel.getCinemaDayTimeslotDatabase(dateData?.split(" ")[0] ?? DateTime.now().toString().split(" ")[0]).then((value) {
          setState(() {
            print("Get data from hive in view layer ==============> ${value.cinemaList}");
            //cinemaInfo = value.cast<CinemaVO>();
            cinemaInfo = value.cinemaList;
          });
        });
      });

      // ///Cinema Day Timeslot Database
      // movieModel.getCinemaDayTimeslotDatabase(dateData?.split(" ")[0] ?? DateTime.now().toString().split(" ")[0]).then((value) {
      //   setState(() {
      //     print("Get data in view layer ==============> ${value.cinemaList}");
      //     //cinemaInfo = value.cast<CinemaVO>();
      //     cinemaInfo = value.cinemaList;
      //   });
      // });

    });

    super.initState();
  }

  getNewTimeslots(String date){
    //"Bearer ${userData?[0].token ?? "abc"}",
    movieModel.getCinemaDayTimeslot(widget.movieId.toString(),dateData?.split(" ")[0] ?? DateTime.now().toString().split(" ")[0]).then((value){
      setState(() {
        cinemaInfo = value;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: PRIMARY_COLOR,
          leading: IconButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.chevron_left,color: Colors.white,size: MARGIN_XLARGE,),
          )
        ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              MovieChooseDateView(
                selectedDate: (String? date){
                    setState(() {
                      print("date data check ==========> ${date}");
                      dateData = date;
                      getNewTimeslots(date.toString().split(" ")[0]);
                    });
                },
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                padding: EdgeInsets.only(top: MARGIN_MEDIUM_3,left: MARGIN_MEDIUM_3,right: MARGIN_MEDIUM_3),
                child: ListView.builder(
                  shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: cinemaInfo?.length ?? 0,
                    itemBuilder: (BuildContext context,int cindex){
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                               Text(cinemaInfo?[cindex].cinema ?? "",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: TEXT_REGULAR_3X,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(height: MARGIN_MEDIUM_3,),
                                    GridView.builder(
                                      itemCount: cinemaInfo?[cindex].timeslots?.length ?? 0,
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        childAspectRatio: 2.5,
                                      ),
                                      itemBuilder: (context,index){
                                        return GestureDetector(
                                          onTap: (){
                                            setState(() {
                                              cinemaInfo?.forEach((outer) {
                                                outer.timeslots?.forEach((inner) {
                                                      inner.isSelected = false;
                                                  });
                                              });
                                                cinemaInfo?[cindex].timeslots?[index].isSelected = true;
                                                userChooseTime = cinemaInfo?[cindex].timeslots?[index].startTime;
                                                userChooseCinema = cinemaInfo?[cindex].cinema;
                                                userChoosedayTimeslotId = cinemaInfo?[cindex].timeslots?[index].cinemaDayTimeslotId;
                                                cinemaId = cinemaInfo?[cindex].cinemaId;

                                              print("Image check choose time screen =======> ${widget.imageView}");
                                            });
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(left: MARGIN_MEDIUM_3,right: MARGIN_MEDIUM_3,top: MARGIN_MEDIUM),
                                            decoration: BoxDecoration(
                                              color:   cinemaInfo?[cindex].timeslots?[index].isSelected == true ? PRIMARY_COLOR : Colors.white,
                                              borderRadius: BorderRadius.circular(MARGIN_SMALL),
                                              border: Border.all(color: Colors.grey,width: 1),
                                            ),
                                            child: Center(child: Text(cinemaInfo?[cindex].timeslots?[index].startTime ?? "",
                                              style: TextStyle(
                                                color: cinemaInfo?[cindex].timeslots?[index].isSelected == true ? Colors.white : Colors.black,
                                              ),
                                            )),
                                          ),
                                        );
                                      }
                                  ),
                          ],
                        ),
                      );
                    }
                ),
              ),
              SizedBox(height: MARGIN_LARGE,),
             Padding(
               padding: const EdgeInsets.all(MARGIN_MEDIUM_3),
               child: ButtonView(
                 "Next",
                 buttonColor: PRIMARY_COLOR,
               onClick: ()=>
                   _navigateToNextScreen(
                 context,
                 userChooseTime ?? "",
                 dateData ?? DateTime.now().toString(),
                userChooseCinema ?? "",
                 userChoosedayTimeslotId ?? 0,
                 widget.movieName,
                 userData?[0].token ?? "",
                 widget.movieId,
                 cinemaId ?? 0,
                 widget.imageView,
               ),
               ),
             ),
            ],
          ),
        ),
      ),
    );
  }
   _navigateToNextScreen(BuildContext context,String userChooseTime,String dateData,
       String userChooseCinema,int userChoosedayTimeslotId,String movieName,String token,
       int movieId,int cinemaId,String imageView
       ) {
    if(userChooseTime != "" && userChoosedayTimeslotId != 0 && userChooseCinema != ""){
      return Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context)=>MovieSeatsPage(
         userChooseTime: userChooseTime,
           dateData: dateData,
          userChooseCinema: userChooseCinema,
          userChoosedayTimeslotId: userChoosedayTimeslotId,
          movieName: movieName,
          token: token,
          movieId: movieId,
          cinemaId: cinemaId,
          imageView: imageView,
        )),
      );
    }
  }
}


class MovieChooseDateView extends StatefulWidget {

  final Function(String?) selectedDate;

  MovieChooseDateView({required this.selectedDate});

  @override
  State<MovieChooseDateView> createState() => _MovieChooseDateViewState();
}

class _MovieChooseDateViewState extends State<MovieChooseDateView> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MOVIE_TIME_DATE_LIST_HEIGHT,
      color: PRIMARY_COLOR,
      child: Column(
        children: [
          DatePicker(
            DateTime.now(),
            daysCount: 14,
            initialSelectedDate: DateTime.now(),
            selectionColor: PRIMARY_COLOR,
            selectedTextColor: Colors.white,
            onDateChange: (date) {
              setState(() {
                 widget.selectedDate(date.toString());
              });
            },
          ),
        ],
      ),
    );
  }
}

//_________________________________________________________________________________________

// import 'package:date_picker_timeline/date_picker_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:hw3_movie_booking_app/data/data.vos/cinema_vo.dart';
// import 'package:hw3_movie_booking_app/data/data.vos/collection_vo.dart';
// import 'package:hw3_movie_booking_app/data/data.vos/timeslot_vo.dart';
// import 'package:hw3_movie_booking_app/data/data.vos/user_vo.dart';
// import 'package:hw3_movie_booking_app/data/model/movie_model.dart';
// import 'package:hw3_movie_booking_app/data/model/movie_model_impl.dart';
// import 'package:hw3_movie_booking_app/pages/movie_seats_page.dart';
// import 'package:hw3_movie_booking_app/resources/colors.dart';
// import 'package:hw3_movie_booking_app/resources/dimens.dart';
// import 'package:hw3_movie_booking_app/widgets/button_view.dart';
// import 'package:intl/intl.dart';
//
// class MovieChooseTimePage extends StatefulWidget {
//
//   final int movieId;
//   final String movieName;
//   final String imageView;
//
//   MovieChooseTimePage({
//     required this.movieId,
//     required this.movieName,
//     required this.imageView,
//   });
//
//   @override
//   State<MovieChooseTimePage> createState() => _MovieChooseTimePageState();
// }
//
// class _MovieChooseTimePageState extends State<MovieChooseTimePage> {
//
//   ///Movie Model
//   MovieModel movieModel = MovieModelImpl();
//
//   ///State Variables
//   List<CinemaVO>? cinemaInfo;
//   List<UserVO>? userData;
//   String? dateData;
//   bool isChoose = false;
//   String? userChooseTime;
//   String? userChooseCinema;
//   int? userChoosedayTimeslotId;
//   int? cinemaId;
//   List<DateVO>? dateList;
//
//   @override
//   void initState() {
//     ///Get login userInfo From Database
//     movieModel.getLoginUserInfoDatabase().then((userInfo){
//       setState(() {
//         userData = userInfo;
//       });
//       ///Cinema Day Timeslot
//       movieModel.getCinemaDayTimeslot("Bearer ${userData?[0].token ?? "abc"}",widget.movieId.toString(),dateList?.date ?? DateTime.now().toString().split(" ")[0]).then((value){
//         setState(() {
//           cinemaInfo = value;
//         });
//       });
//     });
//
//     dateList = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14].map((data){
//       return DateTime.now().add(Duration(days: data));
//     }).map((dateData){
//       return DateVO(
//         date: DateFormat("yyyy-MM-dd").format(dateData),
//         weekDay: dateData.weekday,
//         isSelected: false,
//       );
//     }).toList();
//
//     super.initState();
//   }
//
//   getNewTimeslots(String date){
//     movieModel.getCinemaDayTimeslot("Bearer ${userData?[0].token ?? "abc"}",widget.movieId.toString(),dateData?.split(" ")[0] ?? DateTime.now().toString().split(" ")[0]).then((value){
//       setState(() {
//         cinemaInfo = value;
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           elevation: 0,
//           backgroundColor: PRIMARY_COLOR,
//           leading: IconButton(
//             onPressed: (){
//               Navigator.of(context).pop();
//             },
//             icon: Icon(Icons.chevron_left,color: Colors.white,size: MARGIN_XLARGE,),
//           )
//       ),
//       body: Container(
//         color: Colors.white,
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               MovieChooseDateView(
//                 selectedDate: (String? date){
//                   setState(() {
//                     print("date data check ==========> ${date}");
//                     dateData = date;
//                     getNewTimeslots(date.toString().split(" ")[0] ?? "");
//                   });
//                 },
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(12),
//                     topRight: Radius.circular(12),
//                   ),
//                 ),
//                 padding: EdgeInsets.only(top: MARGIN_MEDIUM_3,left: MARGIN_MEDIUM_3,right: MARGIN_MEDIUM_3),
//                 child: ListView.builder(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     itemCount: cinemaInfo?.length ?? 0,
//                     itemBuilder: (BuildContext context,int cindex){
//                       return Container(
//                         margin: EdgeInsets.symmetric(vertical: 12),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(cinemaInfo?[cindex].cinema ?? "",
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: TEXT_REGULAR_3X,
//                                 fontWeight: FontWeight.w700,
//                               ),
//                             ),
//                             SizedBox(height: MARGIN_MEDIUM_3,),
//                             GridView.builder(
//                                 itemCount: cinemaInfo?[cindex].timeslots?.length ?? 0,
//                                 physics: NeverScrollableScrollPhysics(),
//                                 shrinkWrap: true,
//                                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                                   crossAxisCount: 3,
//                                   childAspectRatio: 2.5,
//                                 ),
//                                 itemBuilder: (context,index){
//                                   return GestureDetector(
//                                     onTap: (){
//                                       setState(() {
//                                         cinemaInfo?.forEach((outer) {
//                                           outer.timeslots?.forEach((inner) {
//                                             inner.isSelected = false;
//                                           });
//                                         });
//                                         cinemaInfo?[cindex].timeslots?[index].isSelected = true;
//                                         userChooseTime = cinemaInfo?[cindex].timeslots?[index].startTime;
//                                         userChooseCinema = cinemaInfo?[cindex].cinema;
//                                         userChoosedayTimeslotId = cinemaInfo?[cindex].timeslots?[index].cinemaDayTimeslotId;
//                                         cinemaId = cinemaInfo?[cindex].cinemaId;
//
//                                         print("Image check choose time screen =======> ${widget.imageView}");
//                                       });
//                                     },
//                                     child: Container(
//                                       margin: EdgeInsets.only(left: MARGIN_MEDIUM_3,right: MARGIN_MEDIUM_3,top: MARGIN_MEDIUM),
//                                       decoration: BoxDecoration(
//                                         color:   cinemaInfo?[cindex].timeslots?[index].isSelected == true ? PRIMARY_COLOR : Colors.white,
//                                         borderRadius: BorderRadius.circular(MARGIN_SMALL),
//                                         border: Border.all(color: Colors.grey,width: 1),
//                                       ),
//                                       child: Center(child: Text(cinemaInfo?[cindex].timeslots?[index].startTime ?? "",
//                                         style: TextStyle(
//                                           color: cinemaInfo?[cindex].timeslots?[index].isSelected == true ? Colors.white : Colors.black,
//                                         ),
//                                       )),
//                                     ),
//                                   );
//                                 }
//                             ),
//                           ],
//                         ),
//                       );
//                     }
//                 ),
//               ),
//               SizedBox(height: MARGIN_LARGE,),
//               Padding(
//                 padding: const EdgeInsets.all(MARGIN_MEDIUM_3),
//                 child: ButtonView(
//                   "Next",
//                   buttonColor: PRIMARY_COLOR,
//                   onClick: ()=>
//                       _navigateToNextScreen(
//                         context,
//                         userChooseTime ?? "",
//                         dateData ?? DateTime.now().toString(),
//                         userChooseCinema ?? "",
//                         userChoosedayTimeslotId ?? 0,
//                         widget.movieName,
//                         userData?[0].token ?? "",
//                         widget.movieId,
//                         cinemaId ?? 0,
//                         widget.imageView,
//                       ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//   _navigateToNextScreen(BuildContext context,String userChooseTime,String dateData,
//       String userChooseCinema,int userChoosedayTimeslotId,String movieName,String token,
//       int movieId,int cinemaId,String imageView
//       ) {
//     if(userChooseTime != "" && userChoosedayTimeslotId != 0 && userChooseCinema != ""){
//       return Navigator.push(context,
//         MaterialPageRoute(builder: (BuildContext context)=>MovieSeatsPage(
//           userChooseTime: userChooseTime,
//           dateData: dateData,
//           userChooseCinema: userChooseCinema,
//           userChoosedayTimeslotId: userChoosedayTimeslotId,
//           movieName: movieName,
//           token: token,
//           movieId: movieId,
//           cinemaId: cinemaId,
//           imageView: imageView,
//         )),
//       );
//     }
//   }
// }
//
//
// class MovieChooseDateView extends StatefulWidget {
//
//   final Function(String?) selectedDate;
//
//   MovieChooseDateView({required this.selectedDate});
//
//   @override
//   State<MovieChooseDateView> createState() => _MovieChooseDateViewState();
// }
//
// class _MovieChooseDateViewState extends State<MovieChooseDateView> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MOVIE_TIME_DATE_LIST_HEIGHT,
//       color: PRIMARY_COLOR,
//       child: Column(
//         children: [
//           DatePicker(
//             DateTime.now(),
//             daysCount: 14,
//             initialSelectedDate: DateTime.now(),
//             selectionColor: PRIMARY_COLOR,
//             selectedTextColor: Colors.white,
//             onDateChange: (date) {
//               setState(() {
//                 widget.selectedDate(date.toString());
//               });
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
// class DateVO{
//   String? date;
//   int? weekDay;
//   bool isSelected;
//
//   DateVO({this.date,this.weekDay,this.isSelected=false});
// }
