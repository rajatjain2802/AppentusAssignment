import 'package:appentus_assignment/model/view/IViewModel.dart';

class BaseResponseListener<T extends IViewModel> {
  Function(T) onSuccess;
  Function(String) onError;
  Function(bool) showProgress;
  bool isLive = false;

  BaseResponseListener({this.onSuccess, this.onError, this.showProgress, this.isLive});

  updateIfLive(T t) {
    if (isLive != null && isLive) {
      onSuccess(t);
    }
  }
}
