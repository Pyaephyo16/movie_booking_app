import 'package:flutter/material.dart';
import 'package:hw3_movie_booking_app/blocs/boucher_screen_bloc.dart';
import 'package:hw3_movie_booking_app/data/data.vos/checkout_request_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/snack_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/user_select_vo.dart';
import 'package:hw3_movie_booking_app/data/model/movie_model.dart';
import 'package:hw3_movie_booking_app/data/model/movie_model_impl.dart';
import 'package:hw3_movie_booking_app/network/app_constants.dart';
import 'package:hw3_movie_booking_app/pages/movie_list_screen.dart';
import 'package:hw3_movie_booking_app/resources/colors.dart';
import 'package:hw3_movie_booking_app/resources/dimens.dart';
import 'package:hw3_movie_booking_app/resources/strings.dart';
import 'package:hw3_movie_booking_app/viewitems/DottedLineSectionView.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:intl/intl.dart';

class BoucherScreen extends StatelessWidget {

  final String movieName;
  final String userChooseCinema;
  final String imageView;
  final UserSelectVO boucherData;

  BoucherScreen({
    required this.movieName,
    required this.userChooseCinema,
    required this.imageView,
    required this.boucherData,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => boucherScreenBloc(boucherData),
      child: Scaffold(
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.all(MARGIN_MEDIUM_2),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MARGIN_XLARGE,),
                PopView(),
                SizedBox(height: MARGIN_MEDIUM_3,),
                Align(
                  alignment: Alignment.center,
                  child: TitleView(),
                ),
                SizedBox(height: MARGIN_MEDIUM_3,),
                Align(
                  alignment: Alignment.center,
                 child: Selector<boucherScreenBloc,UserSelectVO>(
                   selector: (context,bloc) => bloc.boucherData ?? UserSelectVO.emptySituation(),
                   builder: (context,boucherData,child) =>
                    TicketView(
                     image: imageView,
                     date: boucherData.bookingDate ?? "",
                     movieName: movieName,
                     cinemaName: userChooseCinema,
                     boucherData:boucherData,
                   ),
                 ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TicketView extends StatelessWidget {

  final String image;
  final String movieName;
  final String cinemaName;
  final String date;
  final UserSelectVO boucherData;

  TicketView({required this.image,required this.date,required this.boucherData,required this.movieName,required this.cinemaName});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      height: BOUCHER_HEIGHT,
      width: BOUCHER_WIDTH,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(MARGIN_MEDIUM_3),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: BOUCHER_WIDTH,
                  height: 170,
                  child: Image.network("$IMAGE_BASE_URL$image",fit: BoxFit.cover,)),
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top:MARGIN_MEDIUM_2,left: MARGIN_MEDIUM_2,right: MARGIN_MEDIUM_2,bottom: MARGIN_SMALL_1),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MovieInfoView(
                          movieName: movieName,
                        ),
                        DividerView(),
                        Container(
                          height: BOUCHER_INFO_HEIGHT,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(child: BookingInfoView("Booking no.",boucherData.bookingNo ?? "",flexNo: 2,)),
                              SizedBox(height: MARGIN_MEDIUM_3X,),
                                                                                              //DateFormat("dd MMMM").format(DateTime.parse(date))
                              Expanded(child: BookingInfoView("Show time - Date","${boucherData.timeslot?.startTime} - ${date}",flexNo: 2,),),
                              SizedBox(height: MARGIN_MEDIUM_3X,),
                              Expanded(child:  BookingInfoView("Therater","${cinemaName}",flexNo: 3,),),
                              SizedBox(height: MARGIN_MEDIUM_3X,),
                              Expanded(child: BookingInfoView("Screen","2"),),
                              SizedBox(height: MARGIN_MEDIUM_3X,),
                              Expanded(child: BookingInfoView("Row","${boucherData.row}",flexNo: 2,),),
                              SizedBox(height: MARGIN_MEDIUM_3X,),
                              Expanded(child: BookingInfoView("Seat\n\t\t\ts","${boucherData.seat}",flexNo: 2,),),
                              SizedBox(height: MARGIN_MEDIUM_3X,),
                              Expanded(child:  BookingInfoView("Price","${boucherData.total}",flexNo: 2,),),
                            ],
                          ),
                        ),
                        DividerView(),
                        BarCodeView(),
                      ],
                    ),
                  ),
              ),
            ],
          ),

          Positioned(
            top: 226,
              left: -25,
              child: DecorationView(),
          ),

          Positioned(
              top: 226,
              right: -25,
              child: DecorationView(),
          ),

          Positioned(
              top: 522,
              left: -25,
              child: DecorationView(),
          ),

          Positioned(
              top: 522,
              right: -25,
              child:  DecorationView(),
          ),
        ],
      )
    );
  }
}

class DecorationView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      width: IMAGE_CONTAINER_BORDER,
      height: IMAGE_CONTAINER_BORDER,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(TEXT_REGULAR_2X),
        border: Border.all(color: Colors.grey),
        color: Colors.white,
      ),
      //  child: Image.asset("./image/black_widow.jpg",fit: BoxFit.cover,),
    );
  }
}

class BarCodeView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      height: QR_HEIGHT,
      child: QrImage(
       padding: EdgeInsets.only(left: MARGIN_MEDIUM_5,right: MARGIN_MEDIUM_5),
        data: 'This QR code has an embedded image as well',
        version: QrVersions.max,
        size: QR_IMAGE_WIDGET_HEIGHT,
        gapless: false,
        embeddedImage: AssetImage('./image/bar_code_logo_2.png'),
        embeddedImageStyle: QrEmbeddedImageStyle(
          size: Size(QR_IMAGE_WIDTH,QR_IMAGE_HEIGHT),
        ),
      ),
    );
  }
}

class BookingInfoView extends StatelessWidget {

  final String title;
  final String content;
  final int flexNo;

  BookingInfoView(this.title,this.content,{this.flexNo=1});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Text(title,style: TextStyle(
              color: Colors.grey,
              fontSize: TEXT_REGULAR_2X,
            ),),
        ),
        Expanded(
          flex: flexNo,
          child: Text(content,style: TextStyle(
            fontSize: TEXT_REGULAR_2X,
          ),
          textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}

class DividerView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      child: DottedLineSectionView(),
    );
  }
}

class MovieInfoView extends StatelessWidget {

  final String movieName;

  MovieInfoView({required this.movieName});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${movieName}",
          style: TextStyle(
            fontSize: TEXT_REGULAR_3X,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: MARGIN_SMALL_1,),
        Text("105m - lMAX",
          style: TextStyle(
            fontSize: TEXT_REGULAR,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

class TitleView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Awesome!",
           style: TextStyle(
            color: Colors.black,
           fontWeight: FontWeight.bold,
            fontSize: TEXT_REGULAR_4X,
           ),
         ),
        SizedBox(height: MARGIN_SMALL_1,),
        Text("This is your ticket",
          style: TextStyle(
            color: Colors.grey,
            fontSize: TEXT_REGULAR_2X,
            wordSpacing: 1.4,
          ),
        ),
      ],
    );
  }
}

class PopView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => MovieListScreen()),
        );
      },
      child: Container(
        padding: EdgeInsets.all(MARGIN_SMALL_1),
        width: MARGIN_XLARGE_1,
        height: MARGIN_XLARGE_1,
        child: Image.asset("./image/cancel_logo.png"),
      ),
    );
  }
}


