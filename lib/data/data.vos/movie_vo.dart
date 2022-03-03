import 'package:hive/hive.dart';
import 'package:hw3_movie_booking_app/data/data.vos/collection_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/genre_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/production_company_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/production_country_vo.dart';
import 'package:hw3_movie_booking_app/data/data.vos/spoken_language_vo.dart';
import 'package:hw3_movie_booking_app/persistance/hive_constants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_vo.g.dart';


///budget for movie detail can be double or int.api is int.


@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_MOVIE_VO,adapterName: "MovieVOAdapter")
class MovieVO{
  @JsonKey(name: "adult")
  @HiveField(0)
    bool? adult;

  @JsonKey(name: "backdrop_path")
  @HiveField(1)
    String? backdropPath;

  @JsonKey(name: "genre_ids")
  @HiveField(2)
    List<int>? genreId;

  @JsonKey(name: "id")
  @HiveField(3)
    int? id;

  @JsonKey(name: "original_language")
  @HiveField(4)
    String? originalLanguage;

  @JsonKey(name: "original_title")
  @HiveField(5)
    String? originalTitle;

  @JsonKey(name: "overview")
  @HiveField(6)
    String? overView;

  @JsonKey(name: "popularity")
  @HiveField(7)
    double? popularity;

  @JsonKey(name: "poster_path")
  @HiveField(8)
    String? posterPath;

  @JsonKey(name: "release_date")
  @HiveField(9)
    String? releaseDate;

  @JsonKey(name: "title")
  @HiveField(10)
    String? title;

  @JsonKey(name: "video")
  @HiveField(11)
    bool? video;

  @JsonKey(name: "vote_average")
  @HiveField(12)
    double? voteAverage;

  @JsonKey(name: "vote_count")
  @HiveField(13)
    int? voteCount;

  @JsonKey(name: "belongs_to_collection")
  @HiveField(14)
  CollectionVO? belongsToCollection;

  @JsonKey(name: "budget")
  @HiveField(15)
  double? budget;

  @JsonKey(name: "genres")
  @HiveField(16)
  List<GenreVO>? genres;

  @JsonKey(name: "homepage")
  @HiveField(17)
  String? homepage;

  @JsonKey(name: "imdb_id")
  @HiveField(18)
  String? imdbId;

  @JsonKey(name: "production_companies")
  @HiveField(19)
  List<ProductionCompanyVO>? productionCompanies;

  @JsonKey(name: "production_countries")
  @HiveField(20)
  List<ProductionCountryVO>? productoinCountries;

  @JsonKey(name: "revenue")
  @HiveField(21)
  int? revenue;

  @JsonKey(name: "runtime")
  @HiveField(22)
  int? runtime;

  @JsonKey(name: "spoken_languages")
  @HiveField(23)
  List<SpokenLanguageVO>? spokenLanguages;

  @JsonKey(name: "status")
  @HiveField(24)
  String? status;

  @JsonKey(name: "tagline")
  @HiveField(25)
  String? tagline;
  
  @HiveField(26)
  bool? isNowPlaying;
  
  @HiveField(27)
  bool? isComingSoon;

  MovieVO.emptySituation();

  MovieVO(
      this.adult,
      this.backdropPath,
      this.genreId,
      this.id,
      this.originalLanguage,
      this.originalTitle,
      this.overView,
      this.popularity,
      this.posterPath,
      this.releaseDate,
      this.title,
      this.video,
      this.voteAverage,
      this.voteCount,
      this.belongsToCollection,
      this.budget,
      this.genres,
      this.homepage,
      this.imdbId,
      this.productionCompanies,
      this.productoinCountries,
      this.revenue,
      this.runtime,
      this.spokenLanguages,
      this.status,
      this.tagline,
      this.isNowPlaying,
      this.isComingSoon);

  String runTimeShowDetail(int runTime){
    late String hour;
    late String minute;

    hour = (runTime/60).toStringAsFixed(0);
    minute = (runTime%60).toString();

    return "${hour}hr ${minute}min";
  }

  List<String> genreSeparatedList(){
    return genres?.map((genreType) => genreType.name ?? "").toList() ?? [];
  }


  factory MovieVO.fromJson(Map<String,dynamic> json) => _$MovieVOFromJson(json);

  Map<String,dynamic> toJson() => _$MovieVOToJson(this);
}