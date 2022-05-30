import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
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
import 'package:hw3_movie_booking_app/main.dart';
import 'package:hw3_movie_booking_app/pages/boucher_screen.dart';
import 'package:hw3_movie_booking_app/pages/login_sigin_page.dart';
import 'package:hw3_movie_booking_app/pages/movie_choose_time_page.dart';
import 'package:hw3_movie_booking_app/pages/movie_detail_screen.dart';
import 'package:hw3_movie_booking_app/pages/movie_list_screen.dart';
import 'package:hw3_movie_booking_app/pages/movie_seats_page.dart';
import 'package:hw3_movie_booking_app/pages/payment_info_screen.dart';
import 'package:hw3_movie_booking_app/pages/payment_screen.dart';
import 'package:hw3_movie_booking_app/pages/snack_screen.dart';
import 'package:hw3_movie_booking_app/pages/splash_page.dart';
import 'package:hw3_movie_booking_app/persistance/hive_constants.dart';
import 'package:hw3_movie_booking_app/viewitems/DottedLineSectionView.dart';
import 'package:hw3_movie_booking_app/widgets/button_view.dart';
import 'package:hw3_movie_booking_app/widgets/intro_text.dart';
import 'package:integration_test/integration_test.dart';

import 'test_data/test_data.dart';

void main()async{

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

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
await Hive.openBox<UserVO>(BOX_NAME_CARD_VO);
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


testWidgets("Movie Booking App Testing",(WidgetTester tester)async{


 await tester.pumpWidget(MyApp());
 await Future.delayed(Duration(seconds: 2));

 await tester.pumpAndSettle(Duration(seconds: 5));

 expect(find.byType(SplashPage), findsOneWidget);
 expect(find.byType(SplashScreenLogoView),findsOneWidget);
 expect(find.byType(IntroTextView), findsOneWidget);
 expect(find.byType(ButtonView), findsOneWidget);

 await tester.tap(find.byType(ButtonView));
 await tester.pumpAndSettle(Duration(seconds: 5));

 expect(find.byType(LoginAndSiginPage),findsOneWidget);
 expect(find.byType(IntroTextView), findsOneWidget);
 expect(find.byType(UserInfoInputSection), findsOneWidget);
 expect(find.byType(FacebookActionView), findsOneWidget);
 expect(find.byType(GoogleActionView), findsOneWidget);
 expect(find.byType(ButtonActionView), findsOneWidget);

  await tester.enterText(find.byKey(Key("emailKey")),USER_EMAIL);
  await tester.enterText(find.byKey(Key("passwordKey")),USER_PASSWORD);

  await tester.tap(find.byType(ButtonActionView));
  await tester.pumpAndSettle(Duration(seconds: 10));

  expect(find.byType(MovieListScreen), findsOneWidget);

  await tester.tap(find.byType(DrawerButton));
  await tester.pumpAndSettle(Duration(seconds: 5));

  expect(find.byType(DrawerHeaderSectionView), findsOneWidget);
  expect(find.text(USER_NAME), findsOneWidget);
  expect(find.text(USER_EMAIL), findsOneWidget);

  await tester.tap(find.byKey(Key("keyHelp")));
  await tester.pumpAndSettle(Duration(seconds: 5));


   expect(find.text(USER_NAME_PROFILE),findsOneWidget);
  expect(find.byType(UserProfileView), findsOneWidget);
  expect(find.byType(MoviesSerialsView), findsWidgets);
  expect(find.text(NOW_SHOWING_MOVIE_NAME), findsOneWidget);
  expect(find.text(COMING_SOON_MOVIE_NAME), findsOneWidget);

  await tester.tap(find.text(NOW_SHOWING_MOVIE_NAME));
  await tester.pumpAndSettle(Duration(seconds: 7));

  expect(find.byType(MovieDetailScreen), findsOneWidget);
  expect(find.byType(AppBarScreenView),findsOneWidget);

 await tester.pumpAndSettle(Duration(seconds: 5));

  expect(find.byType(InfoView), findsOneWidget);
  expect(find.text(NOW_SHOWING_MOVIE_NAME), findsOneWidget);

 await tester.pumpAndSettle(Duration(seconds: 10));
 await Future.delayed(Duration(seconds: 3));

  expect(find.text(MOVIE_RUN_TIME), findsOneWidget);
  expect(find.text(MOVIE_RATING), findsOneWidget);
  expect(find.byType(MoviePlotView), findsOneWidget);
  expect(find.byType(CastView), findsOneWidget);
  expect(find.byType(GetTicketButtonView), findsOneWidget);

  await tester.tap(find.byType(GetTicketButtonView));
  await tester.pumpAndSettle(Duration(seconds: 5));

  expect(find.byType(MovieChooseTimePage), findsOneWidget);
  expect(find.byType(MovieChooseDateView), findsOneWidget);
  expect(find.byType(TimeslotSectionView), findsWidgets);

  await tester.tap(find.byKey(Key("dateslot11")));
  await tester.pumpAndSettle(Duration(seconds: 3));

    await tester.tap(find.byKey(Key("dateslot22")));
  await tester.pumpAndSettle(Duration(seconds: 5));

  expect(find.byType(ButtonView), findsOneWidget);

  await tester.tap(find.byType(ButtonView));
  await tester.pumpAndSettle(Duration(seconds: 8));

  expect(find.byType(MovieSeatsPage), findsOneWidget);
  expect(find.byType(MovieNameTimeAndCinemaSectionView), findsOneWidget);
  expect(find.text(NOW_SHOWING_MOVIE_NAME), findsOneWidget);
  expect(find.text(CINEMA_NAME), findsOneWidget);
  expect(find.text(DATE_VIEW), findsOneWidget);
  expect(find.byType(SeatView), findsWidgets);

  // await tester.tap(find.byKey(Key("seat6")));
  // await tester.pumpAndSettle(Duration(seconds: 5));

  // await tester.tap(find.byKey((Key("seat7"))));
  // await tester.pumpAndSettle(Duration(seconds: 5));

  // await tester.tap(find.byKey(Key("seat6")));
  // await tester.pumpAndSettle(Duration(seconds: 5));

  //   await tester.tap(find.byKey((Key("seat8"))));
  // await tester.pumpAndSettle(Duration(seconds: 5));

    await tester.tap(find.byKey(Key("seat2")));
  await tester.pumpAndSettle(Duration(seconds: 5));

  await tester.tap(find.byKey((Key("seat3"))));
  await tester.pumpAndSettle(Duration(seconds: 5));

  await tester.tap(find.byKey(Key("seat2")));
  await tester.pumpAndSettle(Duration(seconds: 5));

    await tester.tap(find.byKey((Key("seat4"))));
  await tester.pumpAndSettle(Duration(seconds: 5));

  expect(find.byType(MovieSeatsGlossarySectionView), findsOneWidget);
  expect(find.byType(DottedLineSectionView), findsOneWidget);
  expect(find.byType(UserTicketsAndSeatsView), findsOneWidget);
  expect(find.text(SEAT_NUM_2),findsOneWidget);
  expect(find.text(SEAT_COUNT),findsOneWidget);
  expect(find.text(SEAT_PRICE), findsOneWidget);
  expect(find.byType(ButtonActionWidgetView), findsOneWidget);

  await tester.tap(find.byType(ButtonActionWidgetView));
  await tester.pumpAndSettle(Duration(seconds: 5));

  expect(find.byType(SnapScreen), findsOneWidget);
  expect(find.byType(BookingSetView), findsOneWidget);

  await tester.tap(find.byKey(Key("plus0")));
  await tester.pumpAndSettle(Duration(seconds: 5));

  await tester.tap(find.byKey(Key("plus2")));
  await tester.pumpAndSettle(Duration(seconds: 5));

    await tester.tap(find.byKey(Key("plus2")));
  await tester.pumpAndSettle(Duration(seconds: 5));

    await tester.tap(find.byKey(Key("minus0")));
  await tester.pumpAndSettle(Duration(seconds: 5));

  expect(find.byType(PromoCodeView), findsOneWidget);
  expect(find.byType(SubTotalView), findsOneWidget);

    expect(find.text(SUB_TOTAL), findsOneWidget);

  expect(find.byType(PaidMethodView), findsOneWidget);

  await tester.tap(find.byKey(Key("payment0")));
  await tester.pumpAndSettle(Duration(seconds: 5));

  await tester.tap(find.byKey(Key("payment1")));
  await tester.pumpAndSettle(Duration(seconds: 5));

  expect(find.byType(ButtonActionViewForClick), findsOneWidget);
  expect(find.text(TOTAL_PRICE_IN_BUTTON), findsOneWidget);

  await tester.tap(find.byType(ButtonActionViewForClick));
  await tester.pumpAndSettle(Duration(seconds: 5));

  expect(find.byType(PaymentScreen), findsOneWidget);
  expect(find.byType(CardSectionView), findsOneWidget);
  expect(find.byType(AddNewCardView), findsOneWidget);
  expect(find.byType(ButtonAction), findsOneWidget);

  await tester.tap(find.byType(AddNewCardView));
  await tester.pumpAndSettle(Duration(seconds: 5));

  expect(find.byType(PaymentInfoScreen), findsOneWidget);
  expect(find.byType(NewCardInfoView), findsWidgets);
  expect(find.byType(NewCardCreateButton), findsOneWidget);

  await tester.enterText(find.byKey(Key("numberKey")), NEW_CARD_NUMBER);
  await tester.enterText(find.byKey(Key("holderKey")), NEW_CARD_HOLDER);
  await tester.enterText(find.byKey(Key("expirationDateKey")), NEW_CARD_EXPIRATION_DATE);
  await tester.enterText(find.byKey(Key("cvcKey")), NEW_CARD_CVC);

  await tester.tap(find.byType(NewCardCreateButton));
  await tester.pumpAndSettle(Duration(seconds: 5));

  expect(find.text(NEW_CARD_NUMBER),findsOneWidget);

  await tester.tap(find.byType(ButtonAction));
  await tester.pumpAndSettle(Duration(seconds: 5));

  expect(find.byType(BoucherScreen), findsOneWidget);
  expect(find.byType(PopView), findsOneWidget);
  expect(find.byType(TitleView), findsOneWidget);
  expect(find.byType(TicketView), findsOneWidget);

  expect(find.text(NOW_SHOWING_MOVIE_NAME), findsOneWidget);
  expect(find.text(THERATER), findsOneWidget);
  expect(find.text(ROW), findsOneWidget);
  expect(find.text(SEAT_NUM_2), findsOneWidget);
  expect(find.text(PRICE), findsOneWidget);

});

}