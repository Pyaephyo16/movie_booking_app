import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hw3_movie_booking_app/data/data.vos/card_vo.dart';
import 'package:hw3_movie_booking_app/data/model/movie_model.dart';
import 'package:hw3_movie_booking_app/data/model/movie_model_impl.dart';
import 'package:hw3_movie_booking_app/pages/payment_screen.dart';
import 'package:hw3_movie_booking_app/resources/colors.dart';
import 'package:hw3_movie_booking_app/resources/dimens.dart';
import 'package:hw3_movie_booking_app/widgets/button_view.dart';

class PaymentInfoScreen extends StatefulWidget {

  final String token;

  PaymentInfoScreen({required this.token});

  @override
  _PaymentInfoScreenState createState() => _PaymentInfoScreenState();
}

class _PaymentInfoScreenState extends State<PaymentInfoScreen> {

  ///Movie Model
  MovieModel movieModel = MovieModelImpl();

  ///State Variables
  late String newCardNumber;
 late String newCardHolder;
 late String expirationDate;
 late String cvc;


  newCardCreation(String newCardNumber,String newCardHolder,String expirationDate,String cvc){
    if(newCardNumber == null || newCardNumber.isEmpty){
      return;
    }
    if(newCardHolder == null || newCardHolder.isEmpty){
      return;
    }
    if(expirationDate == null || expirationDate.isEmpty){
      return;
    }
    if(cvc == null || cvc.isEmpty){
      return;
    }
    //"Bearer ${widget.token}",
    movieModel.createCard(newCardNumber,newCardHolder,expirationDate,cvc)
        .catchError((error){
          debugPrint("Create Card Error =======> ${error.toString}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 36,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          icon: Icon(
            Icons.chevron_left,
            size: 34,
            color: SNAP_SCREEN_POP_ICON_BUTTON_COLOR,
          ),
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
                  NewCardInfoView(
                      "Card number",
                    userData: (data){
                          newCardNumber = data;
                    },
                  ),
                  SizedBox(
                    height: MARGIN_MEDIUM_4,
                  ),
                  NewCardInfoView(
                      "Card holder",
                    userData: (data){
                          newCardHolder = data;
                    },
                  ),
                  SizedBox(
                    height: MARGIN_MEDIUM_4,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: NewCardInfoView(
                            "Expiration date",
                          userData: (data){
                                expirationDate = data;
                          },
                        ),
                      ),
                      Expanded(
                        child: NewCardInfoView(
                            "CVC",
                        userData: (data){
                                cvc = data;
                        },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,

              child: GestureDetector(
                onTap: (){
                    newCardCreation(newCardNumber,newCardHolder,expirationDate,cvc);
                    Navigator.pop(context,true);
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
}

class NewCardInfoView extends StatelessWidget {
  final String title;
  final Function(String) userData;

  NewCardInfoView(this.title,{required this.userData});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Container(
        padding: EdgeInsets.only(left: MARGIN_MEDIUM_3, right: MARGIN_MEDIUM_3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: MARGIN_SMALL,
            ),
            TextFormField(
              onChanged: (String text){
                userData(text);
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(
                  left: TEXT_REGULAR_4X,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}











