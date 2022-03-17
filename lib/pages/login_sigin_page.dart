import 'package:flutter/material.dart';
import 'package:hw3_movie_booking_app/blocs/login_signin_page_bloc.dart';
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
import 'package:provider/provider.dart';


class LoginAndSiginPage extends StatefulWidget {
  @override
  _LoginAndSiginPageState createState() => _LoginAndSiginPageState();
}

class _LoginAndSiginPageState extends State<LoginAndSiginPage> {
  
  List<String> tabBarText = ["Login", "Sign in"];
 

  ///State Variables
   TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
   TextEditingController phone = TextEditingController();
   TextEditingController password = TextEditingController();

  String? tokenFromGoogle;
  String? tokenFromFacebook;
  String?  idInsteadOfToken;
  String? idInsteadOfTokenForFacebook;

 
  // GoogleSignInAccount? _user;
  // GoogleSignInAccount get user => _user!;

  Future<dynamic> _navigateToMovieDetailScreen(BuildContext context) {
    return Navigator.push(context,
      MaterialPageRoute(builder: (BuildContext context)=> MovieListScreen()),
    );
  }

    showPassword(BuildContext context){
      LoginSigninPageBloc _bloc = Provider.of(context,listen: false);
      _bloc.showPassword();
    }

 
    @override
  void dispose() {
    name.dispose();
    email.dispose();
    phone.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => LoginSigninPageBloc(),
      child: Scaffold(
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
                      child: Selector<LoginSigninPageBloc,bool>(
                        selector: (_,bloc) => bloc.isSignIn,
                        builder: (_,isLogOrSign,child) =>
                         DefaultTabController(
                          length: tabBarText.length,
                          child: TabBar(
                            onTap: (int index) {
                              LoginSigninPageBloc _actionBloc = Provider.of(_,listen: false);
                              _actionBloc.UserAccountAction(index);
                      
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
                    ),
                    SizedBox(
                      height: MARGIN_XXLARGE,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(MARGIN_SMALL),
                      child: 
                      Selector<LoginSigninPageBloc,bool>(
                        selector: (_,bloc) => bloc.isSignIn,
                        builder: (_,isLogOrSign,child) =>
                         Selector<LoginSigninPageBloc,bool>(
                        selector: (_,bloc) => bloc.isShowPassword,
                        builder: (_,isShowPassword,child) =>
                            UserInfoInputSection(
                            isSignIn: isLogOrSign,
                            nameController: name,
                            emailController: email,
                            phoneController: phone,
                            passwordController: password,
                            isShowPassword: isShowPassword,
                            showPassword: showPassword,
                                                 ),
                         ),
                      ),
                    ),
                  ],
                ),
    
                SizedBox(
                  height: MARGIN_XXLARGE,
                ),
                   Selector<LoginSigninPageBloc,bool>(
                        selector: (context,bloc) => bloc.isSignIn,
                        builder: (context,isLogOrSign,child) =>
                    //   GestureDetector(
                    //   onTap: ()async{
                    //     if(isLogOrSign==true){
                    //       final result = await FacebookAuth.instance.login();
                    //       if (result.status == LoginStatus.success) {
                    //         final userData = await FacebookAuth.instance.getUserData(
                    //           fields: 'email,name',
                    //         );
                    //          tokenFromFacebook = result.accessToken.toString();
                    //         idInsteadOfTokenForFacebook = userData["id"];
                    //          name.text = userData["name"];
                    //          email.text = userData["email"];
                    //         print("Request Data ======> ${userData}");
                    //       }else{
                    //         print("no login success");
                    //       }
                    //     }else{
                    //       final result = await FacebookAuth.instance.login();
                    //       if (result.status == LoginStatus.success) {
                    //         final userData = await FacebookAuth.instance.getUserData(
                    //           fields: 'email,name',
                    //         );
                    //         tokenFromFacebook = result.accessToken.toString();
                    //         idInsteadOfTokenForFacebook = userData["id"];
                    //         print("Facebook direct access token ==============> ${result.accessToken.toString()}");
                    //         print("Facebook direct access id ==============> ${idInsteadOfTokenForFacebook}");
                    //         print("Request Data ======> ${userData}");
                    //       }else{
                    //         print("no login success");
                    //       }
                    //           LoginSigninPageBloc _fbLoginBloc = Provider.of(context,listen: false);
                    //           _fbLoginBloc.LoginWithFacebook(idInsteadOfTokenForFacebook ?? "").then((value) => _navigateToMovieDetailScreen(context));    
                    //     }
                    //   },
                    //   child: Selector<LoginSigninPageBloc,bool>(
                    //     selector: (_,bloc) => bloc.isSignIn,
                    //     builder: (_,isLogOrSign,child) =>
                    //      Container(
                    //       width: double.infinity,
                    //       height: BUTTON_HEIGHT,
                    //       decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(MARGIN_SMALL),
                    //         border: Border.all(color: LOGIN_SCREEN_TAB_BAR_UNSELECT_TEXT_COLOR),
                    //       ),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           Image.asset("./image/fb_logo-removebg-preview.png"),
                    //           Text(isLogOrSign==true ? "Sign Up With Facebook" : "Login With Facebook"),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    FacebookActionView(
                      isLogOrSign: isLogOrSign,
                      signinFacebook: signinFacebook,
                      loginFacebook: loginFacebook,
                    ),
                   ),
                SizedBox(
                  height: MARGIN_XXLARGE,
                ),
                   Selector<LoginSigninPageBloc,bool>(
                        selector: (context,bloc) => bloc.isSignIn,
                        builder: (context,isLogOrSign,child) =>
                      // GestureDetector(
                      // onTap: (){
                      //    if(isLogOrSign==true ) {
                      //        // GoogleSignIn _googleSignIn = GoogleSignIn(
                      //        //   scopes: [
                      //        //     'email',
                      //        //     'https://www.googleapis.com/auth/contacts.readonly',
                      //        //   ],
                      //        // );
                      //        // _googleSignIn.signIn().then((googleAccount) {
                      //        //   name.text = googleAccount?.displayName ?? "";
                      //        //   email.text = googleAccount?.email ?? "";
                      //        //   googleAccount?.authentication.then((authentication) {
                      //        //     print(authentication.accessToken);
                      //        //     tokenFromGoogle = authentication.accessToken;
                      //        //   });
                      //        // });
                      //       siginGoogle();
                      //    }else{
                      //      loginGoogle(context);
                      //   }
                      // },
                      // child: Selector<LoginSigninPageBloc,bool>(
                      //   selector: (_,bloc) => bloc.isSignIn,
                      //   builder: (_,isLogOrSign,child) =>
                      //    Container(
                      //     width: double.infinity,
                      //     height: BUTTON_HEIGHT,
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(MARGIN_SMALL),
                      //       border: Border.all(color: LOGIN_SCREEN_TAB_BAR_UNSELECT_TEXT_COLOR),
                      //     ),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         Image.asset("./image/google_logo-removebg-preview.png"),
                      //         Text(isLogOrSign==true ? "Sign Up With Google" : "Login With Google"),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      //  ),
                        GoogleActionView(
                          isLogOrSign: isLogOrSign,
                          siginGoogle: siginGoogle,
                          loginGoogle: loginGoogle,
                        ),
                ),
                SizedBox(
                  height: MARGIN_XXLARGE,
                ),
                Selector<LoginSigninPageBloc,bool>(
                  selector: (context,bloc) => bloc.isSignIn,
                  builder: (context,isLogOrSign,child) =>
                   ButtonActionView(
                    isLogOrSign: isLogOrSign,
                    LoginAction: loginAction,
                    signinAction: signinAction,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  signinFacebook()async{
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
             }

  loginFacebook(BuildContext context)async{
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
                              LoginSigninPageBloc _fbLoginBloc = Provider.of(context,listen: false);
                              _fbLoginBloc.LoginWithFacebook(idInsteadOfTokenForFacebook ?? "").then((value) => _navigateToMovieDetailScreen(context)); 
                    }

  loginGoogle(BuildContext context){
    GoogleSignIn().signIn().then((value) {
                             idInsteadOfToken = value?.id ?? "";
                             print("Id for google login =======================> ${value?.id}");
                              value?.authentication.then((data) {
                                  tokenFromGoogle = data.accessToken;
                                  print("Token for google login =======================> ${data.accessToken}");
                                
                                LoginSigninPageBloc _googleLoginBloc = Provider.of(context,listen: false);
                              _googleLoginBloc.LoginWithGoogle(value.id).then((value) => _navigateToMovieDetailScreen(context));
                              }).catchError((error) => print(error));
                      
                           }).catchError((error) => print(error));
  }

    siginGoogle(){
   ///NEW
         GoogleSignIn().signIn().then((value) {
            name.text = value?.displayName ?? '';
             email.text = value?.email ?? '';
             idInsteadOfToken = value?.id ?? "";
             print("Id for google signin =======================> ${value?.id}");
             value?.authentication.then((data) {
             print("Token direct access test ============> ${data.accessToken}");
             tokenFromGoogle = data.accessToken;
             }).catchError((error) => print(error));
             }).catchError((error) => print(error));
       }


  loginAction(BuildContext context){
        //doLogin(email.text, password.text);
                          LoginSigninPageBloc _loginBloc = Provider.of(context,listen: false);
                          if(email==null || email.text.isEmpty){
                               return;
                                  }
                        if(password==null || password.text.isEmpty){
                               return;
                                 }
                            _loginBloc.doLogin(email.text, password.text).then((value) => _navigateToMovieDetailScreen(context));
    
  }

  signinAction(BuildContext context){
      //doRegister(name.text,email.text,phone.text,password.text,idInsteadOfToken ?? "",idInsteadOfTokenForFacebook ?? "");
                          LoginSigninPageBloc _signinBloc = Provider.of(context,listen: false);
                          if(name==null || name.text.isEmpty){
                            return;
                          }
                            if(email==null || email.text.isEmpty){
                               return;
                          }
                            if(phone==null || phone.text.isEmpty){
                                 return;
                             }
                          if(password==null || password.text.isEmpty){
                               return;
                             }
                          _signinBloc.doRegister(name.text, email.text, phone.text, password.text, idInsteadOfToken ?? "", idInsteadOfTokenForFacebook ?? "")
                          .then((value) => _navigateToMovieDetailScreen(context));
  }

  
}

class FacebookActionView extends StatelessWidget {

  final bool isLogOrSign;
  final Function signinFacebook;
  final Function(BuildContext context) loginFacebook;

  FacebookActionView({
    required this.isLogOrSign,
    required this.signinFacebook,
    required this.loginFacebook,
    });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
                      onTap: ()async{
                        if(isLogOrSign==true){
                          signinFacebook();
                        }else{
                          loginFacebook(context);
                        }
                      },
                      child: 
                         Container(
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
                              Text(isLogOrSign==true ? "Sign Up With Facebook" : "Login With Facebook"),
                            ],
                          ),
                        ),
                    );
  }
}

class GoogleActionView extends StatelessWidget {

  final bool isLogOrSign;
  final Function siginGoogle;
  final Function(BuildContext context) loginGoogle;

  GoogleActionView({
    required this.isLogOrSign,
    required this.siginGoogle,
    required this.loginGoogle,
    });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
                      onTap: (){
                         if(isLogOrSign==true ) {
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
                            siginGoogle();
                         }else{
                           loginGoogle(context);
                        }
                      },
                      child: Selector<LoginSigninPageBloc,bool>(
                        selector: (_,bloc) => bloc.isSignIn,
                        builder: (_,isLogOrSign,child) =>
                         Container(
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
                              Text(isLogOrSign==true ? "Sign Up With Google" : "Login With Google"),
                            ],
                          ),
                        ),
                      ),
                       );
  }
}

class ButtonActionView extends StatelessWidget {

  final bool isLogOrSign;
  final Function(BuildContext context) LoginAction;
  final Function(BuildContext context) signinAction;

  ButtonActionView({
    required this.isLogOrSign,
    required this.LoginAction,
    required this.signinAction,
  });

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
                      onTap: (){
                        print("Show result ======> ${isLogOrSign}");
                        if(isLogOrSign!=true){
                          LoginAction(context);
                        }else{
                          signinAction(context);
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
 final TextEditingController nameController;
 final TextEditingController emailController;
  final TextEditingController phoneController;
 final TextEditingController passwordController;
 final bool isShowPassword;
 final Function(BuildContext context) showPassword;

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
                   showPassword(context);
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


