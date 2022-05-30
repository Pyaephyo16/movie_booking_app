import 'package:flutter_test/flutter_test.dart';
import 'package:hw3_movie_booking_app/data/data.vos/actor_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/card_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/cinema_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/cinemalist_for_hive_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/movie_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/payment_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/snack_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/timeslot_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/user_vo.dart';
import 'package:hw3_movie_booking_app/data/model/movie_model_impl.dart';

import '../mock_data/mock_data.dart';
import '../netowrk/movie_data_agent_impl_mock.dart';
import '../persistance/actor_dao_impl_mock.dart';
import '../persistance/cards_from_profile_dao_impl_mock.dart';
import '../persistance/cinema_day_timeslot_dao_mock.dart';
import '../persistance/movie_dao_impl_mock.dart';
import '../persistance/payment_method_dao_impl_mock.dart';
import '../persistance/snack_dao_impl_mock.dart';
import '../persistance/user_dao_impl_mock.dart';

void main(){

  group("Movie Model Impl Test",(){

    var movieModel = MovieModelImpl();

    setUp((){
      movieModel.setDaoAndDataAgent(
        ActorDaoImplMock(),
        UserDaoImplMock(),
        CardsFromProfileDaoImplMock(),
        CinemaDayTimeslotDaoMock(),
        MovieDaoImplMock(),
        PaymentMethodDaoImplMock(),
        SnackDaoImplMock(),
        MovieDataAgentImplMock(),
      );
    });

    test("Credits By Movie",(){
      expect(
        movieModel.getCreditsByMovieDatabase(675353),
        emits(
         actorToDatabaseMock(),
        ),
         );
    });


    test("Cards From Profile", (){
        expect(
          movieModel.getCardsFromProfileDatabase(),
           emits(
     UserVO(
    568, 
    "toetoe", 
    "toetoe22@gmail.com",
     "959770222230",
     0,
      "/img/avatar2.png",
      [
        CardVO(
          12,
           "MgMg", 
           "4455664455", 
           "01/12", 
           "JCB",
           ),
           CardVO(
          13,
           "MaMA", 
           "3355664455", 
           "01/11", 
           "JCB",
           ),
      ], 
      "4139|FPLMcjIhZIaupj47CpN6IiyMX7HHJ6ifRBbFIX3Y",
       ),
           ),
           );
    });


    test("Cinema Day Timeslot ",(){
      expect(
        movieModel.getCinemaDayTimeslotDatabase("2022-04-12"),
         emits(
           CinemaListForHiveVO(
             [
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
  ]
           ),
         ),
         );
    });


    test("Cinema Seat Page",(){
      expect(
        movieModel.getCinemaSeatingPlan("1","2022-04-12"),
         completion(
           equals(
            seatingForIntegrationForTest(),
           ),
         )
         );
    });


    test("Now Playing Movies",(){
      expect(
        movieModel.getNowPlayingMovieDatabase(),
         emits(
           [
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
           ]
         )
         );
    });


    test("Coming Soon Movies",(){
      expect(
        movieModel.getComingSoonMovieDatabase(),
         emits(
           [
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
           ]
         ),
         );
    });


    test("Movie Details Test",(){
      expect(
        movieModel.getMovieDetailsDatabase(508947, true),
         emits(
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
        
        ),
         );
    });

    test("Payment Method",(){
      expect(
        movieModel.getPaymentMethodFromDatabase(),
         emits(
           [
      PaymentVO(1, "Credit card", "Visa, Master Card, JCB", false),
      PaymentVO(2, "Internet Banking (ATM card)", "Visa, Master Card, JCB", false),
      PaymentVO(3, "E-Wallet", "AyaPay, KbzPay, WavePay", false),
  ],
         )
         );
    });


    test("Snack Test",(){
      expect(
        movieModel.getSnacksFromDatabase(),
         emits(
            [
    SnackVO(1, "Popcorn", "Et dolores eaque officia aut.", 2, "https://tmba.padc.com.mm/img/snack.jpg", 0),
    SnackVO(2, "Smoothies", "Voluptatum consequatur aut molestiae soluta nulla.", 3, "https://tmba.padc.com.mm/img/snack.jpg", 0),
    SnackVO(3, "Carrots", "At vero et doloribus sint porro ipsum consequatur.", 4, "https://tmba.padc.com.mm/img/snack.jpg", 0),
  ],
         ),
         );
    });


    test("Login With Email",(){
      expect(
        movieModel.getLoginUserInfoDatabase(),
         emits(
           [
UserVO(
    568, 
    "toetoe", 
    "toetoe22@gmail.com",
     "959770222230",
     0,
      "/img/avatar2.png",
      [
        CardVO(
          12,
           "MgMg", 
           "4455664455", 
           "01/12", 
           "JCB",
           ),
           CardVO(
          13,
           "MaMA", 
           "3355664455", 
           "01/11", 
           "JCB",
           ),
      ],
       "4139|FPLMcjIhZIaupj47CpN6IiyMX7HHJ6ifRBbFIX3Y",
       )
  ],
         ),
         );
    });


    test("Register With Email",(){
        expect(
         movieModel.getRegisterUserInfoDatabase(),
          completion(
            equals(
       [
    UserVO(
    568, 
    "toetoe", 
    "toetoe22@gmail.com",
     "959770222230",
     0,
      "/img/avatar2.png",
      [
        CardVO(
          12,
           "MgMg", 
           "4455664455", 
           "01/12", 
           "JCB",
           ),
           CardVO(
          13,
           "MaMA", 
           "3355664455", 
           "01/11", 
           "JCB",
           ),
      ], 
       "4139|FPLMcjIhZIaupj47CpN6IiyMX7HHJ6ifRBbFIX3Y",
       ),
       ]
       ),
          )
           );
    });


  });

}