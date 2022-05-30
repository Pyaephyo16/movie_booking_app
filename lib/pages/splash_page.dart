import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hw3_movie_booking_app/config/config_value.dart';
import 'package:hw3_movie_booking_app/config/environment_config.dart';
import 'package:hw3_movie_booking_app/data/data.vos/user_vo.dart';
import 'package:hw3_movie_booking_app/data/model/movie_model.dart';
import 'package:hw3_movie_booking_app/data/model/movie_model_impl.dart';
import 'package:hw3_movie_booking_app/pages/login_sigin_page.dart';
import 'package:hw3_movie_booking_app/pages/movie_list_screen.dart';
import 'package:hw3_movie_booking_app/persistance/hive_constants.dart';
import 'package:hw3_movie_booking_app/resources/colors.dart';
import 'package:hw3_movie_booking_app/resources/dimens.dart';
import 'package:hw3_movie_booking_app/resources/strings.dart';
import 'package:hw3_movie_booking_app/widgets/button_view.dart';
import 'package:hw3_movie_booking_app/widgets/intro_text.dart';

class SplashPage extends StatefulWidget {

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  ///Movie model
  MovieModel movieModel =MovieModelImpl();

  @override
  void initState() {
    movieModel.getLoginUserInfoDatabase().listen((value){
     
      if(value.isNotEmpty){
        if(value[0].token!=null){
        print("Splah Page token check ${value[0].token}");
        Navigator.push(context,
                  MaterialPageRoute(builder: (context)=> MovieListScreen(),
                ));
      }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: SPLASH_SCREEN_BACKGROUND_COLOR,
      backgroundColor: THEME_COLOR[EnvironmentConfig.CONFIG_THEME_COLOR],
      body: Container(
        padding: EdgeInsets.only(left: MARGIN_MEDIUM_3,right: MARGIN_MEDIUM_3,top: MARGIN_MEDIUM_3),
        child: Column(
          children: [
            SizedBox(
              height: MARGIN_MEDIUM_3,
            ),
            SplashScreenLogoView(),
            SizedBox(
              height: MARGIN_MEDIUM_2,
            ),
            IntroTextView(
              SPLASH_SCREEN_TITLE_TEXT,
              TITLE[EnvironmentConfig.CONFIG_TITLE] ?? "",
               //SPLASH_SCREEN_CONTENT_TEXT
               ),
            SizedBox(
              height: MARGIN_VLARGE,
            ),
            ButtonView(
              SPLASH_SCREEN_BUTTON_TEXT,
              isGhostButton: true,
              onClick: () => _navigateToLoginAndSiginPage(context),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic>? _navigateToLoginAndSiginPage(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => LoginAndSiginPage()));
  }
}

class SplashScreenLogoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 2,
      child: Image.asset("./image/splash_screen_logo.png"),
    );
  }
}
