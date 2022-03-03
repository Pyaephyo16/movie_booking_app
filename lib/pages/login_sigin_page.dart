import 'package:flutter/material.dart';
import 'package:hw3_movie_booking_app/data/data.vos/user_vo.dart';
import 'package:hw3_movie_booking_app/data/model/movie_model.dart';
import 'package:hw3_movie_booking_app/data/model/movie_model_impl.dart';
import 'package:hw3_movie_booking_app/network/app_constants.dart';
import 'package:hw3_movie_booking_app/pages/movie_list_screen.dart';
import 'package:hw3_movie_booking_app/resources/colors.dart';
import 'package:hw3_movie_booking_app/resources/dimens.dart';
import 'package:hw3_movie_booking_app/resources/strings.dart';
import 'package:hw3_movie_booking_app/widgets/button_view.dart';
import 'package:hw3_movie_booking_app/widgets/intro_text.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';


class LoginAndSiginPage extends StatefulWidget {


  @override
  _LoginAndSiginPageState createState() => _LoginAndSiginPageState();
}

class _LoginAndSiginPageState extends State<LoginAndSiginPage> {
  List<String> tabBarText = ["Login", "Sign in"];



  ///Model
  MovieModel movieModel = MovieModelImpl();

  ///State Variables
  bool isSignIn = false;
   TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
   TextEditingController phone = TextEditingController();
   TextEditingController password = TextEditingController();

  String? tokenFromGoogle;
  String? tokenFromFacebook;
  String?  idInsteadOfToken;
  String? idInsteadOfTokenForFacebook;

  bool isShowPassword = true;
  // GoogleSignInAccount? _user;
  // GoogleSignInAccount get user => _user!;



  void doRegister(String name,String email,String phone,String password,String idInsteadOfToken,String idInsteadOfTokenForFacebook){
    if(name==null || name.isEmpty){
      return;
    }
    if(email==null || email.isEmpty){
      return;
    }

    if(phone==null || phone.isEmpty){
      return;
    }

    if(password==null || password.isEmpty){
      return;
    }
    movieModel.postRegisterWithEmail(name, email, phone, password,idInsteadOfToken,idInsteadOfTokenForFacebook).then((data){
      print("Success register");
      _navigateToMovieDetailScreen(context);
    }).catchError((error){
      debugPrint("Register Error ===============> ${error.toString()}");
    });
  }

  void doLogin(String email,String password){
    if(email==null || email.isEmpty){
      return;
    }
    if(password==null || password.isEmpty){
      return;
    }
    movieModel.postLoginWithEmail(email,password)
    .then((data){
      print("Success login");
      _navigateToMovieDetailScreen(context);
    }).catchError((error){
      debugPrint("Login Error ===============> ${error.toString()}");
    });
  }

    showPassword(){
      setState(() {
        isShowPassword = !isShowPassword;
      });
    }
 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.all(MARGIN_MEDIUM_3),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MARGIN_XXLARGE_2,
              ),
              IntroTextView(LOGIN_SCREEN_TITLE_TEXT, LOGIN_SCREEN_CONTENT_TEXT,
                  distanceBetween: MARGIN_MEDIUM,
                  titleTextColor: LOGIN_SCREEN_CONTENT_COLOR,
                  isStart: true),
              SizedBox(
                height: MARGIN_XXLARGE,
              ),

              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(MARGIN_SMALL),
                    child: DefaultTabController(
                      length: tabBarText.length,
                      child: TabBar(
                        onTap: (int index) {
                          if (index == 0) {
                            setState(() {
                              isSignIn = false;
                            });
                          } else if (index == 1) {
                            setState(() {
                              isSignIn = true;
                            });
                          }
                        },
                        labelColor: LOGIN_SCREEN_TAB_BAR_TEXT_COLOR,
                        unselectedLabelColor:
                        LOGIN_SCREEN_TAB_BAR_UNSELECT_TEXT_COLOR,
                        indicatorColor: LOGIN_SCREEN_TAB_BAR_INDICATOR_COLOR,
                        tabs: tabBarText
                            .map(
                              (tabpage) => Tab(
                            child: Text(tabpage),
                          ),
                        )
                            .toList(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MARGIN_XXLARGE,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(MARGIN_SMALL),
                    child: UserInfoInputSection(
                      isSignIn: isSignIn,
                      nameController: name,
                      emailController: email,
                      phoneController: phone,
                      passwordController: password,
                      isShowPassword: isShowPassword,
                      showPassword: ()=> showPassword(),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: MARGIN_XXLARGE,
              ),
              GestureDetector(
                onTap: ()async{
                  if(isSignIn==true){
                    final result = await FacebookAuth.instance.login();

                    if (result.status == LoginStatus.success) {
                      final userData = await FacebookAuth.instance.getUserData(
                        fields: 'email,name',
                      );
                       tokenFromFacebook = result.accessToken.toString();
                      idInsteadOfTokenForFacebook = userData["id"];
                       name.text = userData["name"];
                       email.text = userData["email"];

                      print("Request Data ======> ${userData}");
                    }else{
                      print("no login success");
                    }
                  }else{
                    final result = await FacebookAuth.instance.login();

                    if (result.status == LoginStatus.success) {
                      final userData = await FacebookAuth.instance.getUserData(
                        fields: 'email,name',
                      );
                      tokenFromFacebook = result.accessToken.toString();
                      idInsteadOfTokenForFacebook = userData["id"];
                      print("Facebook direct access token ==============> ${result.accessToken.toString()}");
                      print("Facebook direct access id ==============> ${idInsteadOfTokenForFacebook}");
                      print("Request Data ======> ${userData}");
                    }else{
                      print("no login success");
                    }
                        movieModel.postLoginWithFacebook(idInsteadOfTokenForFacebook ?? "").then((data){
                          print("Login with facebook success");
                          _navigateToMovieDetailScreen(context);
                        });

                  }
                },
                child: Container(
                  width: double.infinity,
                  height: BUTTON_HEIGHT,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(MARGIN_SMALL),
                    border: Border.all(color: LOGIN_SCREEN_TAB_BAR_UNSELECT_TEXT_COLOR),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("./image/fb_logo-removebg-preview.png"),
                      Text(isSignIn==true ? "Sign Up With Facebook" : "Login With Facebook"),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MARGIN_XXLARGE,
              ),
              GestureDetector(
                onTap: (){
                   if(isSignIn==true ) {
                       // GoogleSignIn _googleSignIn = GoogleSignIn(
                       //   scopes: [
                       //     'email',
                       //     'https://www.googleapis.com/auth/contacts.readonly',
                       //   ],
                       // );
                       // _googleSignIn.signIn().then((googleAccount) {
                       //   name.text = googleAccount?.displayName ?? "";
                       //   email.text = googleAccount?.email ?? "";
                       //   googleAccount?.authentication.then((authentication) {
                       //     print(authentication.accessToken);
                       //     tokenFromGoogle = authentication.accessToken;
                       //   });
                       // });
                     ///NEW
                     GoogleSignIn().signIn().then((value) {
                       setState(() {
                         name.text = value?.displayName ?? '';
                         email.text = value?.email ?? '';
                        idInsteadOfToken = value?.id ?? "";
                         print("Id for google signin =======================> ${value?.id}");
                         value?.authentication.then((data) {
                           print("Token direct access test ============> ${data.accessToken}");
                           tokenFromGoogle = data.accessToken;
                         }).catchError((error) => print(error));
                       });

                     }).catchError((error) => print(error));
                   }else{
                     GoogleSignIn().signIn().then((value) {
                       idInsteadOfToken = value?.id ?? "";
                       print("Id for google login =======================> ${value?.id}");
                        value?.authentication.then((data) {
                          setState(() {
                            tokenFromGoogle = data.accessToken;
                            print("Token for google login =======================> ${data.accessToken}");
                          });
                          movieModel.postLoginWithGoogle(value.id).then((value){
                            print("Google login success");
                            _navigateToMovieDetailScreen(context);
                          });
                        }).catchError((error) => print(error));

                     }).catchError((error) => print(error));
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: BUTTON_HEIGHT,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(MARGIN_SMALL),
                    border: Border.all(color: LOGIN_SCREEN_TAB_BAR_UNSELECT_TEXT_COLOR),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("./image/google_logo-removebg-preview.png"),
                      Text(isSignIn==true ? "Sign Up With Google" : "Login With Google"),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MARGIN_XXLARGE,
              ),
              GestureDetector(
                onTap: (){
                  print("Show result ======> ${isSignIn}");
                  if(isSignIn!=true){
                    doLogin(email.text, password.text);
                  }else{
                    doRegister(name.text,email.text,phone.text,password.text,idInsteadOfToken ?? "",idInsteadOfTokenForFacebook ?? "");
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: BUTTON_HEIGHT,
                  decoration: BoxDecoration(
                    color: SPLASH_SCREEN_BACKGROUND_COLOR,
                    borderRadius: BorderRadius.circular(MARGIN_SMALL),
                    //border: isGhostButton ? Border.all(color: Colors.white) : null,
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
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _navigateToMovieDetailScreen(BuildContext context) {
    return Navigator.push(context,
      MaterialPageRoute(builder: (BuildContext context)=> MovieListScreen()),
    );
  }
}

class ForgotButtonView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FlatButton(
          padding: EdgeInsets.only(right: 0),
          onPressed: null,
          child: Text(
            FORGOT_PASSWORD_BUTTON_TEXT,
            style: TextStyle(
              color: LOGIN_SCREEN_TAB_BAR_UNSELECT_TEXT_COLOR,
            ),
          ),
        ),
      ],
    );
  }
}



class UserInfoInputSection extends StatelessWidget {
  final bool isSignIn;
 TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
   TextEditingController phoneController = TextEditingController();
 TextEditingController passwordController = TextEditingController();
 final bool isShowPassword;
 final Function showPassword;

  UserInfoInputSection({
    required this.isSignIn,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
    required this.isShowPassword,
    required this.showPassword
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Visibility(
            visible: isSignIn,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Name",
                  style: TextStyle(
                    color: LOGIN_SCREEN_TAB_BAR_UNSELECT_TEXT_COLOR,
                  ),
                ),
                TextFormField(
                  controller: nameController,
                ),
              ],
            ),
          ),
          SizedBox(
            height: MARGIN_MEDIUM_2,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Email",
                style: TextStyle(
                  color: LOGIN_SCREEN_TAB_BAR_UNSELECT_TEXT_COLOR,
                ),
              ),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,

              ),
            ],
          ),
          SizedBox(
            height: MARGIN_MEDIUM_2,
          ),
          Visibility(
              visible: isSignIn,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Phone",
                    style: TextStyle(
                      color: LOGIN_SCREEN_TAB_BAR_UNSELECT_TEXT_COLOR,
                    ),
                  ),
                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.number,

                  ),
                ],
              )
          ),
          SizedBox(
            height: MARGIN_MEDIUM_2,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Password",
                style: TextStyle(
                  color: LOGIN_SCREEN_TAB_BAR_UNSELECT_TEXT_COLOR,
                ),
              ),
              TextFormField(
                controller: passwordController,
                obscureText: isShowPassword,
                decoration: InputDecoration(
                 suffixIcon: IconButton(
                   icon: isShowPassword==true ? Icon(Icons.remove_red_eye_outlined) : Icon(Icons.remove_red_eye_rounded),
                 onPressed: (){
                   showPassword();
                 },
                 ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: MARGIN_MEDIUM_2,
          ),
          Visibility(
            visible: !isSignIn,
            child: ForgotButtonView(),
          ),
        ],
      ),
    );
  }
}

class TextFieldSection extends StatelessWidget {
  final String title;
  final bool isPassword;
  final bool isPhone;
  final Function(String?) userData;

  var _infoController = TextEditingController();

  var _formKey = GlobalKey<FormState>();

  TextFieldSection(this.title,{required this.userData,this.isPassword = false, this.isPhone = false});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: LOGIN_SCREEN_TAB_BAR_UNSELECT_TEXT_COLOR,
            ),
          ),
          TextFormField(
            onChanged: (String text){
              userData(text);
            },
            controller: _infoController,
            obscureText: isPassword ? true : false,
            keyboardType: isPhone ? TextInputType.number : TextInputType.text,

          ),
        ],
      ),
    );
  }
}
