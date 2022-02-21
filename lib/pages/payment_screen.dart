import 'package:flutter/material.dart';
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

class PaymentScreen extends StatefulWidget {

  final int seatCost;
  final int snackCost;
  final String token;
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
    required this.token,
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
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {



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

  @override
  void initState() {


    ///Get Profile
    //"Bearer ${widget.token}"
    movieModel.getProfile().then((data){
      setState(() {
        profile = data?.cards;
      });
      if(profile?.isNotEmpty ?? false){
        //userChoose = profile?[0] ?? CardVO.empytSituation();
        userChoose = profile?[0];
      }
    }).catchError((error){
      debugPrint("GET Profile Error ============> ${error.toString()}");
    });


    ///Get All Cards From profile database
    movieModel.getCardsFromProfileDatabase().then((value){
      setState(() {
          profile = value;
      });
      if(profile?.isNotEmpty ?? false){
        //userChoose = profile?[0] ?? CardVO.empytSituation();
        userChoose = profile?[0];
      }
    }).catchError((error){
      debugPrint("Get All Cards From Profile Database Error ============> ${error.toString()}");
    });

    super.initState();
  }


  doCheckout(CheckoutRequestVO userData,String imageView,String movieName,String userChooseCinema){
    ///Post Checkout
    movieModel.checkout(userData).then((data){
      setState(() {
        boucherData = data;
      });
      _navigateToNextScreen(context,BoucherScreen(
        movieName: movieName,
        userChooseCinema: userChooseCinema,
        imageView: imageView,
        boucherData: boucherData ?? UserSelectVO.start(),
      ));
    }).catchError((error){
      debugPrint("Checkout Error =========> ${error.toString()}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      widget.seatCost,
                      widget.snackCost,
                    ),
                    SizedBox(height: MARGIN_MEDIUM_2,),
                    CardSectionView(
                        //items: items,
                      profile: profile ?? [],
                      takeData: (index){
                       setState(() {
                         userChoose = profile?[index];
                         //cardId = profile?[index].id ?? 0;
                       });
                      },
                    ),
                    SizedBox(height: MARGIN_MEDIUM_3),
                    Padding(
                      padding: EdgeInsets.only(left: MARGIN_MEDIUM_3,right: MARGIN_MEDIUM_3),
                      child: AddNewCardView(
                        onClick: ()=> _navigateToNextScreen(context,PaymentInfoScreen(token: widget.token)),
                      ),
                    ),
                  ],
                ),
            ),

            Positioned(
              bottom: MARGIN_XXLARGE_2X,
              left: MARGIN_MEDIUM_4,
              right: MARGIN_MEDIUM_4,

              child: GestureDetector(
                onTap: (){
                   finalCost = widget.snackCost+widget.seatCost;
                   cardId = userChoose?.id;
                  print("Cinema Id Check =======> ${cardId}");


                  CheckoutRequestVO userData = CheckoutRequestVO(widget.userChoosedayTimeslotId, widget.totalRow, widget.totalSeat, widget.dateData.split(" ")[0],
                      finalCost, widget.movieId, cardId, widget.cinemaId,
                      widget.snackListBought.length ==0 ? [] : widget.snackListBought,
                  );


                  print("Data For checkout =======> ${userData.cinemaDayTimeslotId}");
                  print("Data For checkout =======> ${userData.row}");
                  print("Data For checkout =======> ${userData.seatNumber}");
                  print("Data For checkout =======> ${userData.bookingDate}");
                  print("Data For checkout =======> ${userData.totalPrice}");
                  print("Data For checkout =======> ${userData.movieId}");
                  print("Data For checkout =======> ${userData.cardId}");
                  print("Data For checkout =======> ${userData.cinemaId}");
                  print("Data For checkout =======> ${userData.snacks}");
                  print("ImageTest ===========> ${widget.imageView}");

                   doCheckout(
                       userData,
                     widget.imageView,
                     widget.movieName,
                     widget.userChooseCinema,
                   );



                  // _navigateToNextScreen(context,BoucherScreen(
                  //   // token: widget.token,
                  //   // dateData: widget.dateData,
                  //   // userChoosedayTimeslotId: widget.userChoosedayTimeslotId,
                  //   // movieId: widget.movieId,
                  //   // cinemaId: widget.cinemaId,
                  //   // totalSeat: widget.totalSeat,
                  //   // totalRow: widget.totalRow,
                  //   // snackListBought: widget.snackListBought,
                  //   // finalCost: finalCost ?? 0,
                  //   // cardId: cardId ?? 0,
                  //   movieName: widget.movieName,
                  //   userChooseCinema: widget.userChooseCinema,
                  //   imageView: widget.imageView,
                  //   boucherData: boucherData ?? UserSelectVO.start(),
                  // ));

                },
                child: Container(
                  width: double.infinity,
                  height: BUTTON_HEIGHT,
                  decoration: BoxDecoration(
                    color: PRIMARY_COLOR,
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> _navigateToNextScreen(BuildContext context,Widget pageWidget) {
    return Navigator.push(
                        context,
                        MaterialPageRoute(builder: (BuildContext context)=>pageWidget),
                      ).then((value){
                        if(value == true){
                          //"Bearer ${widget.token}"
                          movieModel.getProfile().then((data){
                            setState(() {
                              profile = data?.cards;
                            });
                          }).catchError((error){
                            debugPrint("GET Profile Error Rrfresh ============> ${error.toString()}");
                          });

                        }
    });
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
  //  CardSectionView({
  //   required this.items,
  // });
  //
  // final List<Widget> items;

  final List<CardVO> profile;
  final Function(int) takeData;

  CardSectionView({required this.profile,required this.takeData});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        itemCount: profile.length,
        itemBuilder: (BuildContext context,int index,int pageViewIndex){
          return PaymentCardView(
           data: profile[index],
          );
        },
        options: CarouselOptions(
          onPageChanged: (index,_){
            takeData(index);
          },
          height: CAROUSEL_SLIDER_HEIGHT,
          aspectRatio: 16/9,
          viewportFraction: 0.8,
          initialPage: 0,
          enableInfiniteScroll: false,
          reverse: false,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ),
    );
  }
}

class PaymentCardView extends StatelessWidget {

  // final String logo;
  // final String owner;
  // final String expire;
  // final Color color;
  //
  // PaymentCardView({required this.logo,required this.owner,required this.expire,required this.color});

  final CardVO data;

  PaymentCardView({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MARGIN_VLARGE_1,
      width: double.infinity,
      margin: EdgeInsets.only(top: MARGIN_MEDIUM_3,bottom: MARGIN_SMALL,left: MARGIN_MEDIUM,right: MARGIN_MEDIUM),
      padding: EdgeInsets.all(MARGIN_MEDIUM_4),
      decoration: BoxDecoration(
        color: PRIMARY_COLOR,
        borderRadius: BorderRadius.circular(MARGIN_MEDIUM_2),
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
              child: Text("${data.cardType}",
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
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextView("* * * *"),
              Spacer(),
              TextView("* * * *"),
              Spacer(),
             TextView("* * * *"),
             Spacer(),
              Text("${data.cardNumber?.substring(6)}",
                style: TextStyle(
                  fontSize: TEXT_REGULAR_5X,
                  color: Colors.white,
                ),
              )
            ],
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
                      Text("${data.cardHolder}",
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
                       Text("${data.expirationDate}",
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
