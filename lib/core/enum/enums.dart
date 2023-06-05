enum RequestContentType { json, xWwwFormUrlencoded }

enum ApplicationState { empty, loading, loaded, error }

class Timeout {
  static int get connectTimeout => 30000;
  static int get receiveTimeout => 30000;
}
