import 'package:hw3_movie_booking_app/data/data.vos/actor_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/actorlist_for_hive_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/card_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/cinema_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/cinemalist_for_hive_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/movie_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/payment_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/seat_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/snack_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/timeslot_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/user_select_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/user_vo.dart';

UserSelectVO getMockCheckoutForTest(){
  return UserSelectVO(
    629,
    "Cinema III-6672-6182", 
    "2022-04-12",
    "A",
    "A-7,A-8", 
    2,
    "\$18",
    335787,
    3,
    "pp11",
    TimeslotVO(
      1,
      "9:30 PM",
      false,
    ),
    [
      SnackVO(1, "PopCorn", "Good Taste", 2, null, 1),
    ],
   );
}

List<CardVO> createCardMockForTest(){
  return [
    CardVO(
     id: 764,
     cardHolder: "toeAung",
     cardNumber: "4345565454",
     expirationDate: "03/11",
     cardType: "JCB",
     isSelected: false,
      ),
  ];
}

List<CinemaVO> cinemaDayTimeslotMockForTest(){
  return [
    CinemaVO(
      1,
      "Cinema I",
      [
        TimeslotVO(3, "9:30 AM", false),
        TimeslotVO(4, "12:00 PM", false),
      ],
        ),
     CinemaVO(
      2,
      "Cinema II",
      [
        TimeslotVO(17, "10:00 AM", false),
        TimeslotVO(18, "1:30 PM", false),
      ],
        ),
      CinemaVO(
      3,
      "Cinema III",
      [
        TimeslotVO(32, "9:30 AM", false),
        TimeslotVO(33, "12:00 PM", false),
        TimeslotVO(34, "4:30 PM", false),
      ],
        ),     
  ];
}

CinemaListForHiveVO cinemaToDatabaseMock(){
  return CinemaListForHiveVO(cinemaDayTimeslotMockForTest());
}

List<List<SeatVO>> seatingPlanMockForTest(){
  return [
    [
      SeatVO(
      1,
      "text",
      "",
      "A",
      0,
      false,
    ),
    SeatVO(
      2,
      "space",
      "",
      "A",
      0,
      false,
    ),
    SeatVO(
      3,
      "taken",
      "A-2",
      "A",
      2,
      false,
    ),
    ],
    [
      SeatVO(
        1,
        "text",
        "", 
        "B",
        0,
        false,
       ),
       SeatVO(
        2,
        "available",
        "B-1", 
        "B",
        2,
        false,
       ),
       SeatVO(
        3,
        "available",
        "B-2", 
        "B",
        2,
        false,
       ),
    ],
  ];
}

List<SeatVO> seatingForIntegrationForTest(){
  return [
     SeatVO(
      1,
      "text",
      "",
      "A",
      0,
      false,
    ),
    SeatVO(
      2,
      "space",
      "",
      "A",
      0,
      false,
    ),
    SeatVO(
      3,
      "taken",
      "A-2",
      "A",
      2,
      false,
    ),
     SeatVO(
        1,
        "text",
        "", 
        "B",
        0,
        false,
       ),
       SeatVO(
        2,
        "available",
        "B-1", 
        "B",
        2,
        false,
       ),
       SeatVO(
        3,
        "available",
        "B-2", 
        "B",
        2,
        false,
       ),
  ];
}

List<MovieVO> moviesMockForTest(){
  return [
    MovieVO(
      false,
      "/fOy2Jurz9k6RnJnMUMRDAgBwru2.jpg",
       [
        16,
        10751,
        35,
        14
       ],
        508947, 
        "en",
        "Turning Red", 
        "Thirteen-year-old Mei is experiencing the awkwardness of being a teenager with a twist when she gets too excited, she transforms into a giant red panda.",
        5475.263,
        "/qsdjk9oAKSQMWs0Vt5Pyfh6O4GZ.jpg",
        "2022-03-10",
        "Turning Red",
        false,
        7.5,
        1582,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        true, 
        false,
    ),
    MovieVO(
      false,
      "/egoyMDLqCxzjnSrWOz50uLlJWmD.jpg",
       [
        28,
        878,
        35,
        10751
       ],
        675353, 
        "en",
        "Sonic the Hedgehog 2", 
        "After settling in Green Hills, Sonic is eager to prove he has what it takes to be a true hero. His test comes when Dr. Robotnik returns, this time with a new partner, Knuckles, in search for an emerald that has the power to destroy civilizations. Sonic teams up with his own sidekick, Tails, and together they embark on a globe-trotting journey to find the emerald before it falls into the wrong hands.",
        6401.627,
        "/6DrHO1jr3qVrViUO6s6kFiAGM7.jpg",
        "2022-03-30",
        "Sonic the Hedgehog 2",
        false,
        7.7,
        376,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        false, 
        true,
    ),
 
  ];
}

List<ActorVO> actorsMockForTest(){
  return [
    ActorVO(
      false,
      2,
      222121,
      "Acting",
      "Ben Schwartz",
      "Ben Schwartz",
       15.476,
       "/lJVYjPj0P6uvVxNrTy4xO2645D0.jpg", 
       1,
       "Sonic the Hedgehog (voice)",
       "5e4fc66735811d001952f273",
       0, 
       null, 
        null,
    ),
    ActorVO(
      false,
      2,
      17605,
      "Acting",
      "Idris Elba",
      "Idris Elba",
       27.445,
      "/be1bVF7qGX91a6c5WeRPs5pKXln.jpg", 
       27,
      "Knuckles the Echidna (voice)",
      "6112d21db046050045900a8f",
       1, 
       null, 
      null,
    ),
    ActorVO(
      false,
      1,
      1212864,
      "Acting",
      "Colleen O'Shaughnessey",
      "Colleen O'Shaughnessey",
       10.547,
      "/y3Kl5tCX1XD6uyL9wefTRbEXTwj.jpg", 
       21,
      "Miles \"Tails\" Prower (voice)",
      "6081aa84a1d3320057776d31",
       2, 
       null, 
      null,
    ),
  ];
}

ActorListForHiveVO actorToDatabaseMock(){
  return ActorListForHiveVO(actorsMockForTest());
}

List<PaymentVO> paymentMockForTest(){
  return [
      PaymentVO(1, "Credit card", "Visa, Master Card, JCB", false),
      PaymentVO(2, "Internet Banking (ATM card)", "Visa, Master Card, JCB", false),
      PaymentVO(3, "E-Wallet", "AyaPay, KbzPay, WavePay", false),
  ];
}

UserVO profileMockForTest(){
  return UserVO(
    568, 
    "toetoe", 
    "toetoe22@gmail.com",
     "959770222230",
     0,
      "/img/avatar2.png",
      [
        CardVO(
         id: 12,
          cardHolder: "MgMg", 
         cardNumber: "4455664455", 
          expirationDate: "01/12", 
          cardType: "JCB",
           isSelected: false,
           ),
           CardVO(
         id: 13,
          cardHolder: "MaMA", 
          cardNumber: "3355664455", 
          expirationDate: "01/11", 
          cardType: "JCB",
          isSelected: false,
           ),
      ], 
       "4139|FPLMcjIhZIaupj47CpN6IiyMX7HHJ6ifRBbFIX3Y",
       );
}

List<SnackVO> snacksMockForTest(){
  return [
    SnackVO(1, "Popcorn", "Et dolores eaque officia aut.", 2, "https://tmba.padc.com.mm/img/snack.jpg", 0),
    SnackVO(2, "Smoothies", "Voluptatum consequatur aut molestiae soluta nulla.", 3, "https://tmba.padc.com.mm/img/snack.jpg", 0),
    SnackVO(3, "Carrots", "At vero et doloribus sint porro ipsum consequatur.", 4, "https://tmba.padc.com.mm/img/snack.jpg", 0),
  ];
}



List<dynamic> registerAndLoginMockForTest(){
  return [
      UserVO(568, "toetoe", "toetoe22@gmail.com", "959770222230", 0, "/img/avatar2.png", null, null),
      "4139|FPLMcjIhZIaupj47CpN6IiyMX7HHJ6ifRBbFIX3Y",
  ];
}



