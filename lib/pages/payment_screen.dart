import 'package:flutter/material.dart';
import 'package:hw3_movie_booking_app/blocs/payment_screen_bloc.dart';
import 'package:hw3_movie_booking_app/config/config_value.dart';
import 'package:hw3_movie_booking_app/config/environment_config.dart';
import 'package:hw3_movie_booking_app/data/data.vos/card_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/checkout_request_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/snack_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/user_select_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/user_vo.dart';
import 'package:hw3_movie_booking_app/data/model/movie_model.dart';
import 'package:hw3_movie_booking_app/data/model/movie_model_impl.dart';
import 'package:hw3_movie_booking_app/pages/boucher_screen.dart';
import 'package:hw3_movie_booking_app/pages/payment_info_screen.dart';
import 'package:hw3_movie_booking_app/pages/snack_screen.dart';
import 'package:hw3_movie_booking_app/resources/colors.dart';
import 'package:hw3_movie_booking_app/resources/dimens.dart';
import 'package:hw3_movie_booking_app/resources/strings.dart';
import 'package:hw3_movie_booking_app/widgets/button_view.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatelessWidget {

  final int seatCost;
  final int snackCost;
  final String dateData;
  final int userChoosedayTimeslotId;
  final int movieId;
  final int cinemaId;
  final String totalSeat;
  final String totalRow;
  final List<SnackVO> snackListBought;
  final String movieName;
  final String userChooseCinema;
  final String imageView;


  PaymentScreen({
    required this.seatCost,
    required this.snackCost,
    required this.dateData,
    required this.userChoosedayTimeslotId,
    required this.movieId,
    required this.cinemaId,
    required this.totalSeat,
    required this.totalRow,
    required this.snackListBought,
    required this.movieName,
    required this.userChooseCinema,
    required this.imageView,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PaymentScreenBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: MARGIN_XXLARGE_0,
          elevation: 0,
          leading: IconButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.chevron_left,size: MARGIN_XXLARGE_0X,color: SNAP_SCREEN_POP_ICON_BUTTON_COLOR,),
          ),
        ),
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.only(top: MARGIN_MEDIUM_3),
          child: Stack(
            children: [
              Positioned.fill(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PayAmountView(
                        seatCost,
                        snackCost,
                      ),
                      SizedBox(height: MARGIN_MEDIUM_2,),
                      Selector<PaymentScreenBloc,List<CardVO>>(
                        selector: (context,bloc) => bloc.profile ?? [],
                         shouldRebuild: (previous,next) => previous != next,
                        builder: (context,profile,child) =>
                            CardSectionView(
                            profile: profile.reversed.toList(),
                            takeData: (index){
                            PaymentScreenBloc _cardBloc = Provider.of(context,listen: false);
                            _cardBloc.userSelectionCard(index);
                            },
                            ),
                      ),
                      SizedBox(height: MARGIN_MEDIUM_3X),
                      // OutlineButton(onPressed: (){
                      //     movieModel.deleteAllCards();
                      // },
                      // child: Text("Clear"),
                      // ),
                      Padding(
                        padding: EdgeInsets.only(left: MARGIN_MEDIUM_3,right: MARGIN_MEDIUM_3),
                        child: AddNewCardView(
                          onClick: ()=> _navigateToNextScreen(context,PaymentInfoScreen()),
                        ),
                      ),
                    ],
                  ),
              ),
    
              Positioned(
                bottom: MARGIN_XXLARGE_2X,
                left: MARGIN_MEDIUM_4,
                right: MARGIN_MEDIUM_4,
    
                child:
                 Selector<PaymentScreenBloc,UserSelectVO>(
                  selector: (context,bloc) => bloc.boucherData ?? UserSelectVO.emptySituation(),
                    builder: (context,boucherData,child) =>
                //       GestureDetector(
                //       onTap: (){
                //         PaymentScreenBloc _finalDataBloc = Provider.of<PaymentScreenBloc>(context,listen: false);
                //         _finalDataBloc.userFinalSelection(widget.snackCost, widget.seatCost,
                //         widget.userChoosedayTimeslotId,widget.totalRow,widget.totalSeat,widget.dateData,
                //      widget.movieId,widget.cinemaId,widget.snackListBought,
                //         ).then((event) {
                //         print("Listen for output 1 ============> ${event}");
                //         print("Listen for output  2============> ${_finalDataBloc.boucherData}");
                //         print("Listen for output 3 ============> ${boucherData}");
                //           _navigateToNextScreen(context,BoucherScreen(
                //          movieName: widget.movieName,
                //         userChooseCinema: widget.userChooseCinema,
                //           imageView: widget.imageView,
                //     boucherData: _finalDataBloc.boucherData ?? UserSelectVO.emptySituation(),
                //  ));
                //         });      
                //       },
                //       child: Container(
                //         width: double.infinity,
                //         height: BUTTON_HEIGHT,
                //         decoration: BoxDecoration(
                //           color: PRIMARY_COLOR,
                //           borderRadius: BorderRadius.circular(MARGIN_SMALL),
                //         ),
                //         child: Center(
                //           child: Text(
                //             "Confirm",
                //             style: TextStyle(
                //               color: Colors.white,
                //               fontWeight: FontWeight.w600,
                //             ),
                //           ),
                //         ),
                //       ),
                //      ),
                ButtonAction(
                  onClick: onTapAction,
                  
                ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _navigateToNextScreen(BuildContext context,Widget pageWidget) {
    return Navigator.push(
                        context,
                        MaterialPageRoute(builder: (BuildContext context)=>pageWidget),
                      );
    //                   .then((value){
    //                     if(value == true){
    //                       movieModel.getProfile().then((data){
    //                         setState(() {
    //                           print("New card crete success ====================> ${data?.cards}");
    //                           profile = data?.cards;
    //                         });
    //                       }).catchError((error){
    //                         debugPrint("GET Profile Error Rrfresh ============> ${error.toString()}");
    //                       });
    //                     }
    //                 });
  }

  onTapAction(BuildContext context){
     PaymentScreenBloc _finalDataBloc = Provider.of<PaymentScreenBloc>(context,listen: false);
                        _finalDataBloc.userFinalSelection(snackCost, seatCost,
                        userChoosedayTimeslotId,totalRow,totalSeat,dateData,
                     movieId,cinemaId,snackListBought,
                        ).then((event) {
                        print("Listen for output 1 ============> ${event}");
                        print("Listen for output  2============> ${_finalDataBloc.boucherData}");
                        //print("Listen for output 3 ============> ${boucherData}");

                          _navigateToNextScreen(context,BoucherScreen(
                         movieName: movieName,
                        userChooseCinema: userChooseCinema,
                          imageView: imageView,
                    boucherData: _finalDataBloc.boucherData ?? UserSelectVO.emptySituation(),
                 ));
                        });
  }
}

class ButtonAction extends StatelessWidget {

  final Function(BuildContext context) onClick;

  ButtonAction({required this.onClick});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
                      onTap: (){
                        onClick(context);
                      },
                      child: Container(
                        width: double.infinity,
                        height: BUTTON_HEIGHT,
                        decoration: BoxDecoration(
                          //color: PRIMARY_COLOR,
                          color: THEME_COLOR[EnvironmentConfig.CONFIG_THEME_COLOR],
                          borderRadius: BorderRadius.circular(MARGIN_SMALL),
                      
                        ),
                        child: Center(
                          child: Text(
                            "Confirm",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                     );
  }
}

class AddNewCardView extends StatelessWidget {
final Function onClick;

AddNewCardView({required this.onClick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onClick();
      },
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add_circle,color: SUB_TOTAL_TEXT_COLOR,),
            SizedBox(width: MARGIN_MEDIUM_2,),
            Text("Add new card",
              style: TextStyle(
                color: SUB_TOTAL_TEXT_COLOR,
                fontWeight: FontWeight.w600,
                wordSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardSectionView extends StatelessWidget {

  final List<CardVO> profile;
  final Function(int) takeData;

  CardSectionView({required this.profile,required this.takeData});

  @override
  Widget build(BuildContext context) {
    return (WIDGET_DESIGN_CARDS[EnvironmentConfig.CONFIG_WIDGET_DESIGN_CARDS] == true) ? CarouselSlider.builder(
        itemCount: profile.length,
        itemBuilder: (BuildContext context,int index,int pageViewIndex){
          return PaymentCardView(
            takeData: (index){
              takeData(index);
            },
            index: index,
           data: profile,
          );
        },
        options: CarouselOptions(
          onPageChanged: (index,_){
            takeData(index);
            print("Card List Length =================> ${profile.length}");
            print("Key =======================> card$index");
          },
          //height: CAROUSEL_SLIDER_HEIGHT,
          height: 240,
          aspectRatio: 16/9,
          viewportFraction: 0.8,
          enableInfiniteScroll: false,
          reverse: false,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ),
    ) :
    Container(
      width: double.infinity,
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
          itemCount: profile.length,
          itemBuilder: (BuildContext context,int index){
            return PaymentCardView(
              takeData: (index){
                takeData(index);
              },
              index: index,
             data: profile,
            );
          },
      ),
    );
  }
}

class PaymentCardView extends StatelessWidget {

  final int index;
  final List<CardVO> data;
  final Function(int) takeData;

  PaymentCardView({required this.index,required this.data,required this.takeData});

  @override
  Widget build(BuildContext context) {
    print("select test need ===========> ${data[index].isSelected}");
    return GestureDetector(
      onTap: (){
        print("tapped $index");
        takeData(index);
        print("select test ===========> ${data[index].isSelected}");
      },
      child: Container(
        key: Key("card$index"),
        height: 200,
        //width: double.infinity,
        width: 360,
        margin: EdgeInsets.only(top: MARGIN_MEDIUM_3,bottom: MARGIN_SMALL,left: MARGIN_MEDIUM,right: MARGIN_MEDIUM),
        padding: EdgeInsets.all(MARGIN_MEDIUM_4),
        decoration: BoxDecoration(
          //color: PRIMARY_COLOR,
          color: THEME_COLOR[EnvironmentConfig.CONFIG_THEME_COLOR],
          borderRadius: BorderRadius.circular(MARGIN_MEDIUM_2),
          border: (WIDGET_DESIGN_CARDS[EnvironmentConfig.CONFIG_WIDGET_DESIGN_CARDS] == true) ? null : (data[index].isSelected == true) ? Border.all(width: 6,color: Color.fromRGBO(233,189,68,1.0)) : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: MARGIN_XXLARGE_1XX,
                  height: MARGIN_XLARGE_1,
                child: Text("${data[index].cardType}",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
                ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: (){
                    print("tap");
                  },
                  child: TextView("..."),
                ),
              ],
            ),
            SizedBox(height: MARGIN_MEDIUM_4,),
            // Row(
            //   mainAxisSize: MainAxisSize.min,
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   children: [
            //   //   TextView("* * * *"),
            //   //   Spacer(),
            //   //   TextView("* * * *"),
            //   //   Spacer(),
            //   //  TextView("* * * *"),
            //   //  Spacer(),
            //   //   Text("${data.cardNumber?.substring(6)}",
            //   //     style: TextStyle(
            //   //       fontSize: TEXT_REGULAR_5X,
            //   //       color: Colors.white,
            //   //     ),
            //   //   ),
            //   ],
            // ),
            Center(
              child: Text("${data[index].cardNumber}",
                  style: TextStyle(
                    fontSize: TEXT_REGULAR_5X,
                    color: Colors.white,
                  ),
                ),
            ),
            SizedBox(height: MARGIN_MEDIUM_4,),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 4,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Card Holder",
                          style: TextStyle(
                            color: VISA_CARD_TEXT_COLOR,
                            fontSize: TEXT_REGULAR,
                          ),
                        ),
                        SizedBox(height: MARGIN_MEDIUM,),
                        Text("${data[index].cardHolder}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: TEXT_REGULAR_3X,
                          ),
                        ),
                      ],
                    ),
                ),
                Expanded(
                     child: Column(
                       mainAxisSize: MainAxisSize.min,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text("Expires",
                           style: TextStyle(
                             color: VISA_CARD_TEXT_COLOR,
                             fontSize: TEXT_REGULAR,
                           ),
                         ),
                         SizedBox(height: MARGIN_MEDIUM,),
                         Text("${data[index].expirationDate}",
                           style: TextStyle(
                             color: Colors.white,
                             fontSize: TEXT_REGULAR_3X,
                           ),
                         ),
                       ],
                     ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CardOwnerView extends StatelessWidget {
final String title;
final String content;

CardOwnerView(this.title,this.content);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
        style: TextStyle(
          color: VISA_CARD_TEXT_COLOR,
          fontSize: TEXT_REGULAR,
        ),
        ),
        SizedBox(height: MARGIN_MEDIUM,),
        Text(content,
          style: TextStyle(
            color: Colors.white,
            fontSize: TEXT_REGULAR_3X,
          ),
        ),
      ],
    );
  }
}

class TextView extends StatelessWidget {
final String title;

TextView(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(title,
      style: TextStyle(
        fontSize: TEXT_REGULAR_5X,
        color: Colors.white,
      ),
    );
  }
}

class PayAmountView extends StatelessWidget {

  final int seatCost;
  final int snackCost;

  PayAmountView(this.seatCost,this.snackCost);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: MARGIN_MEDIUM_3,right: MARGIN_MEDIUM_3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(PAY_AMOUNT_TEXT,
          style: TextStyle(
            fontSize: TEXT_REGULAR,
            color: SNAP_SCREEN_CONTENT_COLOR,
          ),
          ),
          SizedBox(height: MARGIN_MEDIUM,),
          Text("\$${seatCost+snackCost}",
            style: TextStyle(
              fontSize: TEXT_LARGE,
              color: SNAP_SCREEN_POP_ICON_BUTTON_COLOR,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
