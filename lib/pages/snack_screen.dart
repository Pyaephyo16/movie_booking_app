import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hw3_movie_booking_app/blocs/snack_screen_page_bloc.dart';
import 'package:hw3_movie_booking_app/data/data.vos/payment_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/snack_vo.dart';
import 'package:hw3_movie_booking_app/data/model/movie_model.dart';
import 'package:hw3_movie_booking_app/data/model/movie_model_impl.dart';
import 'package:hw3_movie_booking_app/pages/payment_screen.dart';
import 'package:hw3_movie_booking_app/resources/colors.dart';
import 'package:hw3_movie_booking_app/resources/dimens.dart';
import 'package:hw3_movie_booking_app/resources/strings.dart';
import 'package:hw3_movie_booking_app/widgets/button_view.dart';
import 'package:provider/provider.dart';

class SnapScreen extends StatelessWidget {

  final int cost;
  final String dateData;
  final int userChoosedayTimeslotId;
  final int movieId;
  final int cinemaId;
  final String totalSeat;
  final String totalRow;
  final String movieName;
  final String userChooseCinema;
  final String imageView;

  SnapScreen({
    required this.cost,
    required this.dateData,
    required this.userChoosedayTimeslotId,
    required this.movieId,
    required this.cinemaId,
    required this.totalSeat,
    required this.totalRow,
    required this.movieName,
    required this.userChooseCinema,
    required this.imageView,
  });

//   @override
//   _SnapScreenState createState() => _SnapScreenState();
// }

// class _SnapScreenState extends State<SnapScreen> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SnackScreenPageBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 36,
          elevation: 0,
          leading: IconButton(
            onPressed: (){
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
          child: Stack(
            children: [
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.all(MARGIN_MEDIUM_4),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Selector<SnackScreenPageBloc,List<SnackVO>>(
                          selector: (context,bloc) => bloc.snackList ?? [],
                           shouldRebuild: (previous,next) => previous != next,
                          builder: (context,snackList,child) =>
                          //  Selector<SnackScreenPageBloc,bool>(
                          //      selector: (context,bloc) => bloc.isChooseCard,
                          //      builder: (context,totalamount,child) =>
                              BookingSetView(
                                snacks: snackList,
                              increase: (userplus,index){
                                  if(userplus){
                                    SnackScreenPageBloc _increaseBloc = Provider.of(context,listen: false);
                                  _increaseBloc.snackAdd(index);
                                  }
                              },
                              decrease: (userminus,index){
                                  if(userminus){
                                    SnackScreenPageBloc _decreaseBloc = Provider.of(context,listen: false);
                                    _decreaseBloc.snackMinus(index);
                                  }
                              },
                             ),
                           //),
                        ),
                        PromoCodeView(),
                        SizedBox(
                          height: MARGIN_MEDIUM_4,
                        ),
                        Selector<SnackScreenPageBloc,int>(
                          selector: (context,bloc) => bloc.donedone,
                          builder: (context,donedone,child) =>
                           SubTotalView(
                            cost: cost,
                            addCost: donedone,
                          ),
                        ),
                        SizedBox(
                          height: MARGIN_XXLARGE,
                        ),
                        Selector<SnackScreenPageBloc,List<PaymentVO>>(
                          selector: (context,bloc) => bloc.cards ?? [],
                          shouldRebuild: (previous,next) => previous != next,
                          builder: (context,cards,child) =>
                          //  Selector<SnackScreenPageBloc,bool>(
                          //    selector: (context,bloc) => bloc.isChooseCard,
                          //    builder: (context,isChoose,child) =>
                              PaidMethodView(
                              cards: cards,
                              chooseCard: (choosen,index){
                                  SnackScreenPageBloc _choosePaymentBloc = Provider.of(context,listen: false);
                                  _choosePaymentBloc.selectCard(index,choosen);
                              },
                            ),
                           ),
                        //),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 80,
                left: 20,
                right: 20,
    
               child: Selector<SnackScreenPageBloc,List<SnackVO>>(
                 selector: (context,bloc) => bloc.snackListBought,
                 builder: (context,snackListBought,child) =>
                  Selector<SnackScreenPageBloc,int>(
                    selector: (context,bloc) => bloc.donedone,
                    builder: (context,donedone,child) =>
                    //  GestureDetector(
                    //     onTap: (){
                    //         SnackScreenPageBloc _userTakeAction = Provider.of(context,listen: false);
                    //         _userTakeAction.userTakenSnack().listen((event) =>
                    //       _navigateToPaymentScreen(context,
                    //           widget.cost,
                    //           donedone,
                    //           widget.dateData,
                    //         widget.userChoosedayTimeslotId,
                    //         widget.movieId,
                    //         widget.cinemaId,
                    //         widget.totalSeat,
                    //         widget.totalRow,
                    //           snackListBought,
                    //         widget.movieName,
                    //         widget.userChooseCinema,
                    //         widget.imageView,
                    //       ),
                    //         );
                    //     },
                    //     child: Container(
                    //       width: double.infinity,
                    //       height: BUTTON_HEIGHT,
                    //       decoration: BoxDecoration(
                    //         color: PRIMARY_COLOR,
                    //         borderRadius: BorderRadius.circular(MARGIN_SMALL),
                    //       ),
                    //       child: Center(
                    //         child: Text(
                    //           "Pay \$${widget.cost+donedone}",
                    //           style: TextStyle(
                    //             color: Colors.white,
                    //             fontWeight: FontWeight.w600,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    ButtonActionViewForClick(
                     title: "Pay \$ ${cost+donedone}",
                     donedone: donedone,
                     snackListBought: snackListBought,
                     onClick: onTapAction,
                     ),
                  ),
               )
              ),
            ],
          ),
        ),
      ),
    );
  }

  onTapAction(BuildContext context,int donedone,List<SnackVO> snackListBought){
      SnackScreenPageBloc _userTakeAction = Provider.of(context,listen: false);
                            _userTakeAction.userTakenSnack().listen((event) =>
                          _navigateToPaymentScreen(context,
                              cost,
                              donedone,
                              dateData,
                            userChoosedayTimeslotId,
                           movieId,
                            cinemaId,
                            totalSeat,
                            totalRow,
                              snackListBought,
                            movieName,
                            userChooseCinema,
                            imageView,
                          ),
                            );
  }


  Future<dynamic> _navigateToPaymentScreen(BuildContext context,int seatCost,int snackCost,
      String dateData,int userChoosedayTimeslotId,int movieId,int cinemaId,String totalSeat,String totalRow,
      List<SnackVO> snackListBought,String movieName,String userChooseCinema,String imageView,
      ) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (BuildContext context) => PaymentScreen(
        seatCost: seatCost,
        snackCost: snackCost,
        dateData: dateData,
        userChoosedayTimeslotId: userChoosedayTimeslotId,
        movieId: movieId,
        cinemaId: cinemaId,
        totalSeat: totalSeat,
        totalRow: totalRow,
        snackListBought: snackListBought,
        movieName: movieName,
        userChooseCinema: userChooseCinema,
        imageView: imageView,
      )),
    );
  }
}

class ButtonActionViewForClick extends StatelessWidget {

final String title;
final int donedone;
final List<SnackVO> snackListBought;
final Function(BuildContext context,int donedone,List<SnackVO> snackListBought) onClick;

ButtonActionViewForClick({required this.title,required this.donedone,required this.snackListBought,required this.onClick});

  @override
  Widget build(BuildContext context) {
    return    GestureDetector(
                        onTap: (){
                            onClick(context,donedone,snackListBought);
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
                              title,
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

class PaidMethodView extends StatelessWidget {

  final List<PaymentVO> cards;
  final Function(bool,int) chooseCard;

  PaidMethodView({required this.cards,required this.chooseCard});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          PAYMENT_METHOD_TEXT,
          style: TextStyle(
            color: Colors.black,
            fontSize: TEXT_REGULAR_5X,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: MARGIN_MEDIUM_3,
        ),
        Container(
          child: ListView.builder(
            shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: cards.length,
              itemBuilder: (BuildContext context,int index){
              return PaymentMethodView(
                   index,
                  Icon(Icons.credit_card_rounded),
                  // cards[index].name ?? "",
                  // cards[index].description ?? "",
                  // isSelect: cards[index].isSelected ?? false,
                   cards,
                chooseCard: (choosen){
                     return this.chooseCard(choosen,index);
                },
              );
              }
          ),
        ),
      ],
    );
  }
}

class PaymentMethodView extends StatelessWidget {
  final int index;
  final Icon icon;
  final List<PaymentVO> cards;
  // final String title;
  // final String subtitle;
  // final bool isSelect;
  final Function(bool) chooseCard;

  PaymentMethodView(
    this.index,
    this.icon,
    this.cards,
     //this.title,
      //this.subtitle,
      {
      required this.chooseCard,
      //required this.isSelect,
      }
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        chooseCard(true);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            icon,
            SizedBox(
              width: MARGIN_MEDIUM_4,
            ),
            Column(
              key: Key("payment$index"),
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${cards[index].name}",
                  style: TextStyle(
                    color: cards[index].isSelected == true ? PRIMARY_COLOR : SNAP_SCREEN_HELPER_TEXT_COLOR,
                    fontSize: TEXT_REGULAR_3X,
                  ),
                ),
                Text(
                  "${cards[index].description}",
                  style: TextStyle(
                    color: cards[index].isSelected == true ? PRIMARY_COLOR : SNAP_SCREEN_HELPER_TEXT_COLOR,
                    fontSize: TEXT_REGULAR,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SubTotalView extends StatelessWidget {

  final int cost;
  final int addCost;

  SubTotalView({required this.cost,required this.addCost});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        "Sub total :  ${cost+addCost}\$",
        style: TextStyle(
          color: SUB_TOTAL_TEXT_COLOR,
          fontWeight: FontWeight.w800,
          fontSize: TEXT_REGULAR_2X,
        ),
      ),
    );
  }
}

class PromoCodeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: "Enter promo code",
            hintStyle: TextStyle(
              fontSize: TEXT_REGULAR_3X,
              color: SNAP_SCREEN_CONTENT_COLOR,
            ),
          ),
        ),
        SizedBox(
          height: MARGIN_SMALL,
        ),
        RichText(
            text: TextSpan(
          text: "Don\'t you have any promo code ? ",
          style: TextStyle(
            color: SNAP_SCREEN_CONTENT_COLOR,
            fontSize: TEXT_REGULAR,
            height: 1.3,
            wordSpacing: 1.6,
          ),
          children: <TextSpan>[
            TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  return print("Get it now");
                },
              text: "Get it now",
              style: TextStyle(
                color: SNAP_SCREEN_HELPER_TEXT_COLOR,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        )),
      ],
    );
  }
}

class BookingSetView extends StatelessWidget {

  final List<SnackVO> snacks;
  final Function(bool,int) increase;
  final Function(bool,int) decrease;

  BookingSetView({required this.snacks,required this.increase,required this.decrease});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: snacks.length,
        itemBuilder: (BuildContext context, int index) {
          return BookingView(
              snacks[index],
              index,
          increase: (userplus)=> this.increase(userplus,index),
            decrease: (userminus) => this.decrease(userminus,index),
          );
        });
  }
}

class BookingView extends StatelessWidget {

  final SnackVO snack;
  final int index;
  final Function(bool) increase;
  final Function(bool) decrease;

  BookingView(this.snack,this.index,{required this.increase,required this.decrease});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: MARGIN_MEDIUM_3),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  snack.name ?? "",
                  style: TextStyle(
                    color: SNAP_SCREEN_HELPER_TEXT_COLOR,
                    fontSize: TEXT_REGULAR_3X,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: MARGIN_MEDIUM,
                ),
                Text(
                  snack.description ?? "",
                  style: TextStyle(
                    color: SNAP_SCREEN_CONTENT_COLOR,
                    fontSize: TEXT_REGULAR,
                    height: 1.3,
                    wordSpacing: 1.6,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "\$${snack.price ?? 0}",
                style: TextStyle(
                  color: SNAP_SCREEN_HELPER_TEXT_COLOR,
                  fontSize: TEXT_REGULAR_3X,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: MARGIN_MEDIUM,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(MARGIN_SMALL),
                  border: Border.all(color: Colors.grey),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap:(){
                      decrease(true);
                    },
                        child: Text(
                          "-",
                          key: Key("minus$index"),
                          style: TextStyle(
                            fontSize: 38,
                          ),
                        ),
                    ),
                    Container(
                      width: 1,
                      height: PLAY_BUTTON_SIZE,
                      color: Colors.grey,
                    ),
                    Text(
                      "${snack.quantity}",
                      style: TextStyle(
                        color: snack.quantity==0 ? Colors.grey : Colors.black,
                      ),
                    ),
                    Container(
                      width: 1,
                      height: PLAY_BUTTON_SIZE,
                      color: Colors.grey,
                    ),
                    GestureDetector(
                      onTap: (){
                        increase(true);
                      },
                        child: Text(
                          "+",
                          key: Key("plus$index"),
                        style: TextStyle(
                          fontSize: 28,
                        ),
                        )),
                  ],
                ),
              )
            ],
          )),
        ],
      ),
    );
  }
}
