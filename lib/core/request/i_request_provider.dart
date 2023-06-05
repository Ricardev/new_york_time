abstract class IRequestProvider {
  void setDataName(String name);
  void setHeaders(Map<String, dynamic> headers);

  Future<T> getAsync<T>(String url);

  Future<T> postAsync<T>(
    String url,
  );

  Future<T> putAsync<T>(
      String url, T objeto, T Function(Map<String, dynamic> json) fromJson);

  Future<T> deleteAsync<T>(
      String url, T objeto, T Function(Map<String, dynamic> json) fromJson);
}
