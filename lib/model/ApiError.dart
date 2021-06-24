class ApiError {
   String _url;
   String _error;
   String _body;
   String _headers;

   String get url => _url;

  set url(String value) {
    _url = value;
  }

   String get error => _error;

   String get headers => _headers;

  set headers(String value) {
    _headers = value;
  }

  String get body => _body;

  set body(String value) {
    _body = value;
  }

  set error(String value) {
    _error = value;
  }
}