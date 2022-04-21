import 'package:flutter/material.dart';
import 'package:hw3_movie_booking_app/blocs/payment_info_screen_bloc.dart';
import 'package:hw3_movie_booking_app/data/data.vos/card_vo.dart';
import 'package:hw3_movie_booking_app/data/model/movie_model.dart';
import 'package:hw3_movie_booking_app/data/model/movie_model_impl.dart';
import 'package:hw3_movie_booking_app/pages/payment_screen.dart';
import 'package:hw3_movie_booking_app/resources/colors.dart';
import 'package:hw3_movie_booking_app/resources/dimens.dart';
import 'package:hw3_movie_booking_app/widgets/button_view.dart';
import 'package:provider/provider.dart';

class PaymentInfoScreen extends StatelessWidget {

  ///State Variables
  late String newCardNumber;
 late String newCardHolder;
 late String expirationDate;
 late String cvc;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PaymentInfoScreenBloc(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 36,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
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
                        isNumber: true,
                        key: Key("numberKey"),
                      ),
                    SizedBox(
                      height: MARGIN_MEDIUM_4,
                    ),
                    NewCardInfoView(
                        "Card holder",
                      userData: (data){
                            newCardHolder = data;
                      },
                      isNumber: false,
                      key: Key("holderKey"),
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
                            isNumber: false,
                            key: Key("expirationDateKey"),
                          ),
                        ),
                        Expanded(
                          child: NewCardInfoView(
                              "CVC",
                          userData: (data){
                                  cvc = data;
                          },
                          isNumber: true,
                          key: Key("cvcKey"),
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
    
                child: Builder(
                  builder: (context) => 
                GestureDetector(
      onTap: (){
         if(newCardNumber == null || newCardNumber.isEmpty || newCardNumber.length <10){
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
              PaymentInfoScreenBloc _bloc = Provider.of(context,listen: false);
          _bloc.newCardCreation(newCardNumber,newCardHolder,expirationDate,cvc).then((value) => Navigator.pop(context));
      
      },
      child: NewCardCreateButton(),
    )  
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NewCardCreateButton extends StatelessWidget {
  const NewCardCreateButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}



class NewCardInfoView extends StatelessWidget {
  final String title;
  final Function(String) userData;
  final bool isNumber;
  final Key key;

  NewCardInfoView(this.title,{required this.userData,required this.isNumber,required this.key});

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
              key: key,
              onChanged: (String text){
                userData(text);
              },
              keyboardType: isNumber==true ? TextInputType.number : TextInputType.text,
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











