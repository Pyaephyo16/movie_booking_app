import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hw3_movie_booking_app/data/data.vos/actor_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/movie_vo.dart';
import 'package:hw3_movie_booking_app/data/model/movie_model.dart';
import 'package:hw3_movie_booking_app/data/model/movie_model_impl.dart';
import 'package:hw3_movie_booking_app/network/app_constants.dart';
import 'package:hw3_movie_booking_app/pages/movie_choose_time_page.dart';
import 'package:hw3_movie_booking_app/resources/colors.dart';
import 'package:hw3_movie_booking_app/resources/dimens.dart';
import 'package:hw3_movie_booking_app/resources/strings.dart';
import 'package:hw3_movie_booking_app/widgets/button_view.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MovieDetailScreen extends StatefulWidget {

  final int movieId;

  MovieDetailScreen({required this.movieId});

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {

  ///Movie Model
  MovieModel movieModel = MovieModelImpl();

  ///State Variable
  MovieVO? movieDetails;
  List<ActorVO>? cast;
  String? imageView;

  @override
  void initState() {
    ///Movie Details
    // movieModel.getMovieDetails(widget.movieId).then((movieDetailsInfo){
    //   setState(() {
    //     movieDetails = movieDetailsInfo;
    //     imageView = movieDetailsInfo?.posterPath;
    //   });
    // }).catchError((error){
    //   debugPrint("Movie Detail Error ==========> ${error.toString()}");
    // });


    ///Movie Details Database
    movieModel.getMovieDetailsDatabase(widget.movieId).listen((movie){
      setState(() {
        print("Movie Detail insertion into view layer ===============> ${movie}");
        movieDetails = movie;
        imageView = movie?.posterPath;
      });
    }).onError((error){
      debugPrint("Movie Details Database Error ${error.toString()}");
    });

    ///Credits By Movie
    // movieModel.getCreditsByMovie(widget.movieId).then((castInfo){
    //   setState(() {
    //     cast = castInfo;
    //   });
    //   ///Credits By Movie Database
    //   movieModel.getCreditsByMovieDatabase(widget.movieId).then((castData){
    //     setState(() {
    //       //cast = castData.cast<ActorVO>();
    //       print("Get data from hive in view layer ${castData.actorList}");
    //       cast = castData.actorList;
    //     });
    //   }).catchError((error){
    //     debugPrint("Credits By Movie Database Error ==========> ${error.toString()}");
    //   });
    // }).catchError((error){
    //   debugPrint("Credits By Movie Error ==========> ${error.toString()}");
    // });


    // ///Credits By Movie Database
    movieModel.getCreditsByMovieDatabase(widget.movieId).listen((castData){
      setState(() {
       //cast = castData.cast<ActorVO>();
        print("Get data from hive in view layer ${castData?.actorList}");
          cast = castData?.actorList;
      });
    }).onError((error){
      debugPrint("Credits By Movie Database Error ==========> ${error.toString()}");
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomScrollView(
                slivers: [
                  AppBarScreenView(
                    //image: movieDetails?.posterPath ?? "",
                    image: imageView ?? "",
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.only(
                            bottom: MARGIN_MEDIUM_3,
                            left: MARGIN_MEDIUM_3,
                            right: MARGIN_MEDIUM_3),
                        child: MovieInfoView(
                            name: movieDetails?.title ?? "",
                          totalTime: movieDetails?.runTimeShowDetail(movieDetails?.runtime ?? 0) ?? "",
                          rating: movieDetails?.voteAverage ?? 0.0,
                          genreList: movieDetails?.genreSeparatedList() ?? [],
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.only(
                            left: MARGIN_MEDIUM_3,
                            top: MARGIN_MEDIUM,
                            bottom: MARGIN_MEDIUM,
                            right: MARGIN_MEDIUM_3),
                        child: MoviePlotView(
                          summaryData: movieDetails?.overView ?? "",
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.only(
                            //left: MARGIN_MEDIUM_3,
                            top: MARGIN_MEDIUM_3,
                            //right: MARGIN_MEDIUM_3,
                            bottom: MARGIN_XXLARGE_3X,
                        ),
                        child: CastView(
                          actorList: cast ?? [],
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 50,
              left: 20,
              right: 20,
              child: GetTicketButtonView(
                  onClick: ()=> _navigateToNextScreen(context,widget.movieId,movieDetails?.title ?? "",imageView ?? ""),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> _navigateToNextScreen(BuildContext context,int movieId,String moviename,String imageView) {
    return Navigator.push(
                  context,
                  MaterialPageRoute(builder: (BuildContext context)=> MovieChooseTimePage(movieId: movieId,movieName: moviename,imageView: imageView)),
                );
  }
}

class CastView extends StatelessWidget {

  final List<ActorVO> actorList;

  CastView({required this.actorList});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_3),
          child: Text(
            CAST_TEXT,
            style: TextStyle(
              fontSize: MARGIN_MEDIUM_3X,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        Container(
          height: MARGIN_XXLARGE_3X,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: actorList.map((actor){
              return Container(
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.symmetric(horizontal: 8),
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                 // borderRadius: BorderRadius.circular(30),
                ),
                child: CachedNetworkImage(
                  imageUrl: "$IMAGE_BASE_URL${actor.profilePath}",
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                     Center(child:  CircularProgressIndicator(value: downloadProgress.progress),),
                  errorWidget: (context, url, error) => Image.network("https://st.depositphotos.com/2101611/3925/v/600/depositphotos_39258143-stock-illustration-businessman-avatar-profile-picture.jpg",
                  fit: BoxFit.cover,),
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}

class MoviePlotView extends StatelessWidget {

  final String summaryData;

  MoviePlotView({required this.summaryData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          PLOT_SUMMARY_TEXT,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        Text(
          summaryData,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
            height: 1.4,
            wordSpacing: 1.4,
          ),
        ),
      ],
    );
  }
}

class MovieInfoView extends StatelessWidget {

  final String name;
  final String totalTime;
  final double rating;
  final List<String> genreList;

  MovieInfoView({required this.name,required this.totalTime,required this.rating,required this.genreList});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: MARGIN_MEDIUM,
          ),
          Row(
            children: [
              Text(
                totalTime,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                width: MARGIN_MEDIUM_3,
              ),
              RatingBar.builder(
                allowHalfRating: true,
                ignoreGestures: true,
                initialRating: rating/2,
                direction: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Icon(
                    Icons.star,
                    color: Colors.yellow,
                  );
                },
                itemSize: MARGIN_MEDIUM_4,
                onRatingUpdate: (rating) {
                  rating;
                },
              ),
              SizedBox(
                width: MARGIN_MEDIUM_3,
              ),
              Text(
                "IMDb ${rating}",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          SizedBox(
            height: MARGIN_MEDIUM,
          ),
          Wrap(
            children: genreList.map((genreType){
              return Container(
                width: MARGIN_XXLARGE_3,
                height: MARGIN_XXLARGE_1,
                margin: EdgeInsets.only(left: 0,right: 6,top: 2,bottom: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(MARGIN_MEDIUM_3X),
                  border: Border.all(color: SPLASH_SCREEN_CONTENT_COLOR),
                ),
                child: Center(
                  child: Text("${genreType}",
                    style: TextStyle(
                      color: SPLASH_SCREEN_CONTENT_COLOR,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class MovieInfoButton extends StatelessWidget {
  final String title;

  MovieInfoButton(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MARGIN_XXLARGE_1,
      width: MARGIN_XXLARGE_3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(MARGIN_MEDIUM_3X),
        border: Border.all(color: SPLASH_SCREEN_CONTENT_COLOR),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: SPLASH_SCREEN_CONTENT_COLOR,
          ),
        ),
      ),
    );
  }
}

class GetTicketButtonView extends StatelessWidget {

  final Function onClick;

  GetTicketButtonView({required this.onClick});

  @override
  Widget build(BuildContext context) {
    return ButtonView(
      GET_TICKET_BUTTON_TEXT,
      buttonColor: LOGIN_SCREEN_TAB_BAR_TEXT_COLOR,
      onClick: ()=>onClick(),
    );
  }
}

class AppBarScreenView extends StatelessWidget {

  final String image;

  AppBarScreenView({required this.image});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: SPLASH_SCREEN_BACKGROUND_COLOR,
      automaticallyImplyLeading: false,
      expandedHeight: MOVIE_DETAIL_SLIVER_APPBAR_HEIGHT,

      flexibleSpace: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned.fill(
                  child: CachedNetworkImage(
                    imageUrl: "$IMAGE_BASE_URL$image",
                    fit: BoxFit.cover,
                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                        Center(child: CircularProgressIndicator(value: downloadProgress.progress),),
                    errorWidget: (context, url, error) => Image.network("https://media1.thehungryjpeg.com/thumbs2/ori_3597614_rq13oe65xzl2zg0o121qpfzoe8su10u2igw7f2f1_video-camera-icon.jpg",
                    fit: BoxFit.cover,),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: PLAY_BUTTON_SIZE,
                    width: PLAY_BUTTON_SIZE,
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.white),
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.4),
                    ),
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 10,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                      size: 34,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              clipBehavior: Clip.antiAlias,
              height: SLIVER_APPBAR_DECO_HEIGHT,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(68.0),
                  topRight: Radius.circular(68.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
