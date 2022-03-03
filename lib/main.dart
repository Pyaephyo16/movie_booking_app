import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hw3_movie_booking_app/data/data.vos/actor_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/actorlist_for_hive_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/card_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/cinema_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/cinemalist_for_hive_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/collection_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/genre_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/movie_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/payment_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/production_company_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/production_country_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/snack_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/spoken_language_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/timeslot_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/user_vo.dart';
import 'package:hw3_movie_booking_app/pages/boucher_screen.dart';
import 'package:hw3_movie_booking_app/pages/movie_choose_time_page.dart';
import 'package:hw3_movie_booking_app/pages/movie_seats_page.dart';
import 'package:hw3_movie_booking_app/pages/payment_info_screen.dart';
import 'package:hw3_movie_booking_app/pages/snack_screen.dart';
import 'package:hw3_movie_booking_app/pages/splash_page.dart';
import 'package:hw3_movie_booking_app/pages/payment_screen.dart';
import 'package:hw3_movie_booking_app/persistance/hive_constants.dart';



void main()async {

  await Hive.initFlutter();

Hive.registerAdapter(UserVOAdapter());
Hive.registerAdapter(CardVOAdapter());
Hive.registerAdapter(MovieVOAdapter());
Hive.registerAdapter(ActorVOAdapter());
Hive.registerAdapter(ActorListForHiveVOAdapter());
Hive.registerAdapter(CollectionVOAdapter());
Hive.registerAdapter(GenreVOAdapter());
Hive.registerAdapter(ProductionCompanyVOAdapter());
Hive.registerAdapter(ProductionCountryVOAdapter());
Hive.registerAdapter(SpokenLanguageVOAdpater());
Hive.registerAdapter(CinemaVOAdapter());
Hive.registerAdapter(CinemaListForHiveVOAdapter());
Hive.registerAdapter(TimeslotVOAdapter());
Hive.registerAdapter(SnackVOAdapter());
Hive.registerAdapter(PaymentMethodVOAdapter());


await Hive.openBox<UserVO>(BOX_NAME_USER_VO);
await Hive.openBox<CardVO>(BOX_NAME_CARD_VO);
await Hive.openBox<MovieVO>(BOX_NAME_MOVIE_VO);
await Hive.openBox<ActorListForHiveVO>(BOX_NAME_ACTOR_VO);
await Hive.openBox<CollectionVO>(BOX_NAME_COLLECTION_VO);
await Hive.openBox<GenreVO>(BOX_NAME_GENRE_VO);
await Hive.openBox<ProductionCompanyVO>(BOX_NAME_PRODUCTION_COMPANY_VO);
await Hive.openBox<ProductionCountryVO>(BOX_NAME_PRODUCTION_COUNTRY_VO);
await Hive.openBox<SpokenLanguageVO>(BOX_NAME_SPOKEN_LANGUAGE_VO);
await Hive.openBox<CinemaListForHiveVO>(BOX_NAME_CINEMA_VO);
await Hive.openBox<TimeslotVO>(BOX_NAME_TIMESLOT_VO);
await Hive.openBox<SnackVO>(BOX_NAME_SNACK_VO);
await Hive.openBox<PaymentVO>(BOX_NMAE_PAYMENT_METHOD_VO);

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.black,
          )
        )
      ),
      home: SplashPage(),
    ),
  );
}


