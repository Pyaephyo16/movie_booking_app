import 'package:flutter/foundation.dart';
import 'package:hw3_movie_booking_app/data/data.vos/user_vo.dart';
import 'package:hw3_movie_booking_app/data/model/movie_model.dart';
import 'package:hw3_movie_booking_app/data/model/movie_model_impl.dart';
import 'package:hw3_movie_booking_app/pages/movie_list_screen.dart';

class LoginSigninPageBloc extends ChangeNotifier{

   ///Model
  MovieModel movieModel = MovieModelImpl();

  ///State Variable
  bool isSignIn = false;
  bool isShowPassword = true;


  LoginSigninPageBloc({MovieModel? mModel}){
      if(mModel != null){
        movieModel = mModel;
      }
  }


  bool? userAccountAction(int index){
                 if (index == 0) {
                  isSignIn = false;
                  notifyListeners();
                  return isSignIn;
                  
            } else if (index == 1) {
              isSignIn = true;
                notifyListeners();
              return isSignIn;
            
           }
  }

  Future<void> doRegister(String name,String email,String phone,String password,String idInsteadOfToken,String idInsteadOfTokenForFacebook){

    return movieModel.postRegisterWithEmail(name, email, phone, password,idInsteadOfToken,idInsteadOfTokenForFacebook).then((data){
      print("Success register");

    }).catchError((error){
      debugPrint("Register Error ===============> ${error.toString()}");
    });
  }

  Future<void> doLogin(String email,String password){
    
   return movieModel.postLoginWithEmail(email,password)
    .then((data){
      print("Success login");
    }).catchError((error){
      debugPrint("Login Error ===============> ${error.toString()}");
    });
  }

  Future<void> LoginWithFacebook(String idInsteadOfTokenForFacebook){
    return movieModel.postLoginWithFacebook(idInsteadOfTokenForFacebook).then((data){
                            print("Login with facebook success");                          
                          });
  }

  Future<void> LoginWithGoogle(String id){
   return movieModel.postLoginWithGoogle(id).then((value){
                              print("Google login success");
                         });
                }


    showPassword(){
        isShowPassword = !isShowPassword;
      notifyListeners();
    }

}





