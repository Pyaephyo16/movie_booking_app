import 'package:flutter/material.dart';
import 'package:hw3_movie_booking_app/blocs/movie_list_page_bloc.dart';
import 'package:hw3_movie_booking_app/data/data.vos/movie_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/user_vo.dart';
import 'package:hw3_movie_booking_app/data/model/movie_model.dart';
import 'package:hw3_movie_booking_app/data/model/movie_model_impl.dart';
import 'package:hw3_movie_booking_app/network/app_constants.dart';
import 'package:hw3_movie_booking_app/pages/login_sigin_page.dart';
import 'package:hw3_movie_booking_app/pages/movie_detail_screen.dart';
import 'package:hw3_movie_booking_app/pages/splash_page.dart';
import 'package:hw3_movie_booking_app/resources/colors.dart';
import 'package:hw3_movie_booking_app/resources/dimens.dart';
import 'package:hw3_movie_booking_app/resources/strings.dart';
import 'package:hw3_movie_booking_app/widgets/intro_text.dart';
import 'package:provider/provider.dart';


class MovieListScreen extends StatelessWidget {


  List<String> menuItems = [
    "Promotion code",
    "Select Language",
    "Terms of Service",
    "Help",
    "Rate Us"
  ];
  late bool isNowPlaying;

   GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MovieListPageBloc(),
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          leading: DrawerButton(scaffoldKey: scaffoldKey),
          elevation: 0,
          backgroundColor: Colors.white,
          actions: [
            IconButton(onPressed: null, icon: Icon(Icons.search,size: 28,color: Colors.black,)),
          ],
        ),
        drawer: Container(
          padding: EdgeInsets.only(top: 66),
          width: MediaQuery.of(context).size.width*0.8,
          child: Drawer(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_3,),
              color: SPLASH_SCREEN_BACKGROUND_COLOR,
              child: Column(
                children: [
                  SizedBox(height: MARGIN_XXLARGE_3XX,),
                  Selector<MovieListPageBloc,List<UserVO>>(
                    selector: (context,bloc) => bloc.userData ?? [],
                    builder: (context,user,child) =>
                    (user.isEmpty) ? Container() : DrawerHeaderSectionView(
                       userName: user[0].name ?? "",
                       userEmail: user[0].email ?? "" ,
                    ),
                  ),
                  // SizedBox(height: MARGIN_XXLARGE,),
                  // OutlineButton(
                  //   onPressed: (){
                  //     movieModel.deleteMoviesData();
                  //   },
                  //   child: Text("Clear Database"),
                  //   ),
                  SizedBox(height: MARGIN_XXLARGE,),
                  Column(
                    children: menuItems.map((menu){
                      return Container(
                        margin: EdgeInsets.only(top: MARGIN_MEDIUM_3),
                        child: MenuData(
                          menu: menu,
                        ),
                      );
                    }).toList(),
                  ),
                  Spacer(),
                  Builder(
                    builder: (context) =>
                     ListTile(
                      leading: Icon(Icons.logout,color: Colors.white,size: MARGIN_XXLARGE,),
                      title: GestureDetector(
                        onTap: (){
                        //   MovieListPageBloc _logoutBloc = Provider.of(context,listen: false);
                        //  _logoutBloc.doLogout().then((value) => _logoutBloc.deleteUserData().then((value) => _navigateToLoginScreen(context)));
                        //   print("Delete data success");
                        //   Navigator.push(context,
                        //     MaterialPageRoute(builder: (context)=> LoginAndSiginPage()),
                        //   );
                          showDialog(
                              context: context,
                              barrierColor: Colors.black.withOpacity(0.6),
                              builder: (_){
                                return AlertDialog(
                                  title: Text("Logout"),
                                  content: Text("Are you sure want to logout?",),
                                  actions: [
                                    OutlineButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      borderSide: BorderSide(color: PRIMARY_COLOR),
                                      onPressed: (){
                                        Navigator.pop(context);
                                      },
                                      child: Text("Cancel"),
                                    ),        
                                    RaisedButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          color: PRIMARY_COLOR,
                                          textColor: Colors.white,
                                          onPressed: (){
                                            MovieListPageBloc _logoutBloc = Provider.of(context,listen: false);
                                            _logoutBloc.doLogout().then((value) => _logoutBloc.deleteUserData().then((value) => _navigateToLoginScreen(context)));
                                            ;
                                            print("Delete data success");                                           
                                          },
                                          child: Text("Logout"),
                                        ),                                  
                                  ],
                                );
                              }
                          );
                        },
                        child: Text("Logout",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: TEXT_REGULAR_4X,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MARGIN_XLARGE,),
                ],
              ),
            ),
          ),
        ),
        body: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                //AppBarSectionView(),
                SizedBox(
                  height: MARGIN_MEDIUM,
                ),
                Selector<MovieListPageBloc,List<UserVO>>(
                  selector: (context,bloc) => bloc.userData ?? [],
                  builder: (conetxt,user,child) =>
                  (user.isEmpty) ? Container() : UserProfileView(
                    PROFILE_IMAGE_STRING,
                      userName:user[0].name ?? "",
                  ),
                ),
                SizedBox(
                  height: MARGIN_MEDIUM_4,
                ),
                Selector<MovieListPageBloc,List<MovieVO>>(
                  selector: (context,bloc) => bloc.nowPlayingMovieList ?? [],
                  builder: (context,nowPlayingList,child) =>
                   MoviesSerialsView(
                    NOW_SHOWING_TEXT,
                    MOVIE_POSTER_STRING,
                    onTapMovie: (movieId){
                       isNowPlaying = true;
                        _navigateToMovieDetailScreen(context,movieId,isNowPlaying);
                    },
                    movieList: nowPlayingList,
                  ),
                ),
                SizedBox(
                  height: MARGIN_SMALL,
                ),
                Selector<MovieListPageBloc,List<MovieVO>>(
                  selector: (context,bloc) => bloc.comingSoonMovieList ?? [],
                  builder: (context,comingSoonList,child) =>
                   MoviesSerialsView(
                    COMING_SOON_TEXT,
                    MOVIE_POSTER_STRING,
                    onTapMovie: (movieId){
                      isNowPlaying = false;
                      _navigateToMovieDetailScreen(context,movieId,isNowPlaying);
                    },
                    movieList: comingSoonList,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToMovieDetailScreen(BuildContext context,int? movieId,bool isNowPlaying) {
    if(movieId != null){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (BuildContext context) => MovieDetailScreen(movieId: movieId,isNowPlaying: isNowPlaying,)),
      );
    }
  }

     Future<dynamic> _navigateToLoginScreen(BuildContext context) {
    return Navigator.push(context,
                MaterialPageRoute(builder: (context)=> LoginAndSiginPage()),
                        );
  }

  // ConfirmCheckBox(){
  //       showDialog(
  //           context: context,
  //           barrierColor: Colors.black.withOpacity(0.6),
  //           builder: (context){
  //             return AlertDialog(
  //               title: Text("Logout"),
  //               content: Text("Are you sure want to logout?",),
  //               actions: [
  //                 OutlineButton(
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(6),
  //                   ),
  //                   borderSide: BorderSide(color: PRIMARY_COLOR),
  //                   onPressed: (){
  //                     Navigator.pop(context);
  //                   },
  //                   child: Text("Cancel"),
  //                 ),
  //                 RaisedButton(
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(6),
  //                   ),
  //                   color: PRIMARY_COLOR,
  //                   textColor: Colors.white,
  //                   onPressed: (){
  //                     doLogout();
  //                     deleteUserData();
  //                     print("Delete data success");
  //                     Navigator.push(context,
  //                       MaterialPageRoute(builder: (context)=> LoginAndSiginPage()),
  //                     );
  //                   },
  //                   child: Text("Logout"),
  //                 ),
  //               ],
  //             );
  //           }
  //       );
  // }


}

class MenuData extends StatelessWidget {
  const MenuData({
    Key? key,
    required this.menu,
  }) : super(key: key);

  final String menu;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: Key("key$menu"),
      onTap: (){
        Navigator.of(context).pop();
      },
      leading: Icon(Icons.help,color: Colors.white,size: MARGIN_XXLARGE,),
      title: Text(menu,
        style: TextStyle(
          color: Colors.white,
          fontSize: TEXT_REGULAR_4X,
        ),
      ),
    );
  }
}

class DrawerButton extends StatelessWidget {
  const DrawerButton({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: (){
        scaffoldKey.currentState?.openDrawer();
    },
     icon: Icon(Icons.list),
     );
  }
}

class MoviesSerialsView extends StatelessWidget {
  final String title;
  final String img;
  final Function(int?) onTapMovie;
  final List<MovieVO>? movieList;

  MoviesSerialsView(this.title, this.img, {required this.onTapMovie,required this.movieList});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: MARGIN_MEDIUM_4),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: TEXT_REGULAR_3X,
            ),
          ),
        ),
        Container(
          height: MOVIE_CONTAINER_HEIGHT,
          child: (movieList != null) ?
          ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(
                //left: MARGIN_MEDIUM_4,
                right: MARGIN_MEDIUM_4,
                top: MARGIN_MEDIUM_2),
            itemCount: movieList?.length ?? 0,
            itemBuilder: (BuildContext context,int index){
              return GestureDetector(
                onTap: (){
                    onTapMovie(movieList?[index].id);
                },
                child: MoviesView(
                  movie: movieList?[index],
                ),
              );
            }
          ) :
              Center(
                child: CircularProgressIndicator(),
              ),
        ),
      ],
    );
  }
}

class MoviesView extends StatelessWidget {
   MoviesView({
    required this.movie
  });

  final MovieVO? movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: Column(
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            width: 150,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(MARGIN_MEDIUM_3),
              boxShadow: [
                BoxShadow(
                  color: Colors.indigo.shade200,
                  offset: Offset(0, 6),
                  blurRadius: 4.0,
                ),
              ],
            ),
            child: Image.network(
              "$IMAGE_BASE_URL${movie?.posterPath ?? ""}",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                left: MARGIN_MEDIUM_4,
                right: MARGIN_MEDIUM_4,
                top: MARGIN_MEDIUM_3),
            child: MovieInfoView(
              movie: movie
            ),
          ),
        ],
      ),
    );
  }
}

class MovieInfoView extends StatelessWidget {

  final MovieVO? movie;

  MovieInfoView({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          movie?.title ?? "",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        // Text(
        //   "Action/superhero 2h13min",
        //   style: TextStyle(
        //     fontWeight: FontWeight.bold,
        //     fontSize: 12,
        //     color: Colors.grey,
        //   ),
        // ),
      ],
    );
  }
}

class UserProfileView extends StatelessWidget {
  final String userName;
  final String img;

  UserProfileView(this.img,{required this.userName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: MARGIN_MEDIUM_4,
        right: MARGIN_MEDIUM_4,
      ),
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 0),
        leading: ClipOval(
          child: Image.asset(img),
        ),
        title: Text(
          "Hi ${userName}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}

class AppBarSectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MARGIN_MEDIUM_4),
      child: Row(
        children: [
          Container(
              width: IMAGE_CONTAINER_BORDER,
              height: IMAGE_CONTAINER_BORDER,
              child: Image.asset(
                "./image/list_logo.png",
                fit: BoxFit.cover,
              )),
          Spacer(),
          Container(
              width: IMAGE_CONTAINER_BORDER,
              height: IMAGE_CONTAINER_BORDER,
              child: Image.asset(
                "./image/search_logo.png",
                fit: BoxFit.cover,
              )),
        ],
      ),
    );
  }
}

class DrawerHeaderSectionView extends StatelessWidget {

 final String userName;
 final String userEmail;

 DrawerHeaderSectionView({required this.userName,required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: PROFILE_IMAGE_SIZE,
          height: PROFILE_IMAGE_SIZE,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage("./image/user_profile.jpg"),
                fit: BoxFit.cover,
              )
          ),
        ),
        SizedBox(width: MARGIN_MEDIUM_3,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(userName,
              style: TextStyle(
                color: Colors.white,
                fontSize: TEXT_REGULAR_3X,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: MARGIN_MEDIUM_2,),
            Row(
              children: [
                  Text(userEmail,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                SizedBox(width: MARGIN_MEDIUM_4,),
                Text("Edit",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}

