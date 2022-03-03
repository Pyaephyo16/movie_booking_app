import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hw3_movie_booking_app/data/data.vos/payment_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/snack_vo.dart';
import 'package:hw3_movie_booking_app/data/model/movie_model.dart';
import 'package:hw3_movie_booking_app/data/model/movie_model_impl.dart';
import 'package:hw3_movie_booking_app/pages/payment_screen.dart';
import 'package:hw3_movie_booking_app/resources/colors.dart';
import 'package:hw3_movie_booking_app/resources/dimens.dart';
import 'package:hw3_movie_booking_app/resources/strings.dart';
import 'package:hw3_movie_booking_app/widgets/button_view.dart';

class SnapScreen extends StatefulWidget {

  final int cost;
  final String token;
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
    required this.token,
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

  @override
  _SnapScreenState createState() => _SnapScreenState();
}

class _SnapScreenState extends State<SnapScreen> {


  ///Movie Model
  MovieModel movieModel = MovieModelImpl();

  ///State Variable
  List<SnackVO>? snackList;
  List<PaymentVO>? cards;
  List<int> newCost = [];
  int donedone = 0;
  int totalamount = 0;

 List<SnackVO> snackListBought = [];

  @override
  void initState() {
    // ///Get Snack List
    // movieModel.getSnackList("Bearer ${widget.token}").then((snacks){
    //   setState(() {
    //     snackList = snacks;
    //   });
    // }).catchError((error){
    //   debugPrint("Get Snack List Error =============> ${error.toString()}");
    // });

    ///Get Snack List Database
    movieModel.getSnacksFromDatabase().listen((snacks){
      setState(() {
        print("Get all snacks into data layer ==================> ${snacks}");
        snackList = snacks;
      });
    }).onError((error){
      debugPrint("Get Snack List Database Error =============> ${error.toString()}");
    });

    ///Get Payment Method
    // movieModel.getPaymentMethod().then((cards){
    //   setState(() {
    //     this.cards = cards;
    //   });
    // }).catchError((error){
    //   debugPrint("Get Payment Method Error ==========> ${error.toString()}");
    // });


    //Get Payment Method Database
    movieModel.getPaymentMethodFromDatabase().listen((cards) {
        setState(() {
          print("All payment methods in view layer =================> ${cards}");
            this.cards = cards;
        });
    }).onError((error){
        debugPrint("Get Payment Method Database Error ============> ${error.toString()}");
    });


    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      //BookingSetView(bookingList: bookingList),
                      BookingSetView(
                          snacks: snackList ?? [],
                        increase: (userplus,index){
                             totalamount = snackList![index].quantity ?? 0;
                            setState(() {
                              if(userplus){
                                totalamount++;
                                snackList![index].quantity = totalamount;
                                newCost.add(snackList![index].price ?? 0);
                               donedone = newCost.reduce((f, s) => f+s);

                                print("Test ======> ${newCost}");
                                print("Test ======> ${donedone}");
                              }
                            });
                        },
                        decrease: (userminus,index){
                             totalamount = snackList![index].quantity ?? 0;
                            setState(() {
                              if(userminus){
                                if(totalamount != 0){
                                  totalamount--;
                                }else{
                                  totalamount;
                                }
                                snackList![index].quantity = totalamount;
                                newCost.remove(snackList![index].price ?? 0);
                                int tocut = snackList![index].price ?? 0;
                                donedone= donedone-tocut;

                                print("Test ======> ${newCost}");
                                print("Test ======> ${donedone}");
                              }
                            });
                        },
                      ),
                      PromoCodeView(),

                      SizedBox(
                        height: MARGIN_MEDIUM_4,
                      ),
                      SubTotalView(
                        cost: widget.cost,
                        addCost: donedone,
                      ),
                      SizedBox(
                        height: MARGIN_XXLARGE,
                      ),
                      PaidMethodView(
                        cards: cards ?? [],
                        chooseCard: (choosen,index){
                            setState(() {
                                cards?.forEach((element) {
                                  element.isSelected = false;
                                });
                                cards?[index].isSelected = true;
                            });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 80,
              left: 20,
              right: 20,

             child: GestureDetector(
                  onTap: (){

                    var length = snackList?.length ?? 0;
                    print("Snack list lenght =======> ${length}");
                    for(int i=0;i<length;i++){
                      var amount = snackList?[i].quantity ?? 0;
                      print("Snack list quantity =======> ${snackList?[i].quantity}");
                      if(amount >0){
                            setState(() {
                              snackListBought.add(snackList![i]);
                              print("InserData Check ======> ${snackList![i]}");
                              print("USer Take length ===============> ${snackListBought.length}");
                              print("Data ===============> ${snackListBought[0].quantity}");
                            });
                      }
                    }
                        print("Image Check snack screen ========> ${widget.imageView}");
                    _navigateToPaymentScreen(context,
                        widget.cost,
                        donedone,
                        widget.token,
                        widget.dateData,
                      widget.userChoosedayTimeslotId,
                      widget.movieId,
                      widget.cinemaId,
                      widget.totalSeat,
                      widget.totalRow,
                        snackListBought,
                      widget.movieName,
                      widget.userChooseCinema,
                      widget.imageView,
                    );
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
                        "Pay \$${widget.cost+donedone}",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }


  Future<dynamic> _navigateToPaymentScreen(BuildContext context,int seatCost,int snackCost,String token,
      String dateData,int userChoosedayTimeslotId,int movieId,int cinemaId,String totalSeat,String totalRow,
      List<SnackVO> snackListBought,String movieName,String userChooseCinema,String imageView,
      ) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (BuildContext context) => PaymentScreen(
        seatCost: seatCost,
        snackCost: snackCost,
        token: token,
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
        // PaymentMethodView(
        //   Icon(Icons.credit_card_rounded),
        //   cards[0].name ?? "",
        //   cards[0].description ?? "",
        // ),
        // SizedBox(
        //   height: MARGIN_MEDIUM_2,
        // ),
        // PaymentMethodView(
        //   Icon(Icons.credit_card_sharp),
        //   cards[1].name ?? "",
        //   cards[1].description ?? "",
        // ),
        // SizedBox(
        //   height: MARGIN_MEDIUM_2,
        // ),
        // PaymentMethodView(
        //   Icon(Icons.account_balance_wallet_outlined),
        //   cards[2].name ?? "",
        //   cards[2].description ?? "",
        // ),
        Container(
          child: ListView.builder(
            shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: cards.length,
              itemBuilder: (BuildContext context,int index){
              return PaymentMethodView(
                  Icon(Icons.credit_card_rounded),
                  cards[index].name ?? "",
                  cards[index].description ?? "",
                  isSelect: cards[index].isSelected ?? false,
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
  final Icon icon;
  final String title;
  final String subtitle;
  final bool isSelect;
  final Function(bool) chooseCard;

  PaymentMethodView(this.icon, this.title, this.subtitle,{required this.chooseCard,required this.isSelect});

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: isSelect == true ? PRIMARY_COLOR : SNAP_SCREEN_HELPER_TEXT_COLOR,
                    fontSize: TEXT_REGULAR_3X,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: isSelect == true ? PRIMARY_COLOR : SNAP_SCREEN_HELPER_TEXT_COLOR,
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
  // BookingSetView({
  //   required this.bookingList,
  // });
  //
  // final List<BookingView> bookingList;

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
          increase: (userplus)=> this.increase(userplus,index),
            decrease: (userminus) => this.decrease(userminus,index),
          );
        });
  }
}

class BookingView extends StatelessWidget {
  // final String title;
  // final String content;
  // final String price;
  // final int count;
  // final Color countColor;
  //
  // BookingView(this.title, this.content, this.price, this.count,
  //     {this.countColor = Colors.grey});

  final SnackVO snack;
  final Function(bool) increase;
  final Function(bool) decrease;

  BookingView(this.snack,{required this.increase,required this.decrease});

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
                        child: Text("-",
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
                        child: Text("+",
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
