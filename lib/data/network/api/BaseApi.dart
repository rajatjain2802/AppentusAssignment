enum Environment { STAGING, PROD }

class BaseApis {
  static String apiUrl = '';

  static void setEnvironment(Environment env) {
    switch (env) {
      case Environment.STAGING:
        setStagingUrl();
        break;
      case Environment.PROD:
        setProductionUrl();
        break;
    }
  }

  static void setStagingUrl() {
    apiUrl = 'picsum.photos';
  }

  static void setProductionUrl() {
    apiUrl = 'picsum.photos';
  }
}
