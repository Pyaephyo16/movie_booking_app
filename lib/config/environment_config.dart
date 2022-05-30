class EnvironmentConfig{

  static const String CONFIG_THEME_COLOR = String.fromEnvironment("CONFIG_THEME_COLOR",defaultValue: "MOVIE_APP_COLOR");
  static const String CONFIG_TITLE = String.fromEnvironment("CONFIG_TITLE",defaultValue: "MOVIE_APP_TITLE");
  static const String CONFIG_WIDGET_DESIGN_MOVIES = String.fromEnvironment("CONFIG_WIDGET_DESIGN_MOVIES",defaultValue: "MOVIE_APP_DESIGN");
  static const String CONFIG_WIDGET_DESIGN_ACTORS = String.fromEnvironment("CONFIG_WIDGET_DESIGN_ACTORS",defaultValue: "MOVIE_APP_DESIGN");
  static const String CONFIG_WIDGET_DESIGN_CARDS = String.fromEnvironment("CONFIG_WIDGET_DESIGN_CARDS",defaultValue: "MOVIE_APP_DESIGN");

}


///Galaxy app
///flutter run --dart-define=CONFIG_THEME_COLOR=GALAXY_APP_COLOR --dart-define=CONFIG_TITLE=GALAXY_APP_TITLE --dart-define=CONFIG_WIDGET_DESIGN_MOVIES=GALAXY_APP_DESIGN --dart-define=CONFIG_WIDGET_DESIGN_ACTORS=GALAXY_APP_DESIGN --dart-define=CONFIG_WIDGET_DESIGN_CARDS=GALAXY_APP_DESIGN


///Movie app
///flutter run --dart-define=CONFIG_THEME_COLOR=MOVIE_APP_COLOR --dart-define=CONFIG_TITLE=MOVIE_APP_TITLE --dart-define=CONFIG_WIDGET_DESIGN_MOVIES=MOVIE_APP_DESIGN --dart-define=CONFIG_WIDGET_DESIGN_ACTORS=MOVIE_APP_DESIGN --dart-define=CONFIG_WIDGET_DESIGN_CARDS=MOVIE_APP_DESIGN