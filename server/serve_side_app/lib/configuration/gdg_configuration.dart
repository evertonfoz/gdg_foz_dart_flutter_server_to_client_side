import 'package:serve_side_app/serve_side_app.dart';

class GdgConfiguration extends Configuration{
  GdgConfiguration(String path) : super.fromFile(File(path));

  DatabaseConfiguration database;
}