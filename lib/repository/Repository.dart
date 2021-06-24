import 'package:appentus_assignment/base/BaseResponseListener.dart';
import 'package:appentus_assignment/data/network/api/ApiEnum.dart';
import 'package:appentus_assignment/data/network/api/ApiUtils.dart';
import 'package:appentus_assignment/data/network/rest/RestClient.dart';
import 'package:appentus_assignment/mapper/IMapper.dart';
import 'package:appentus_assignment/mapper/PhotoMapper.dart';
import 'package:appentus_assignment/model/view/IViewModel.dart';
import 'package:appentus_assignment/res/Strings.dart';
import 'package:appentus_assignment/util/Utils.dart';
import 'package:flutter/foundation.dart';

class Repository extends ApiService {
  Repository(String baseUrl) : super(baseUrl, kDebugMode);

  getPhotoData<T extends IViewModel>(BaseResponseListener<T> listener) {
    _hitApi<T>(
        type: ApiType.GET, endPoint: API_ENDPOINT, listener: listener, mapper: PhotoMapper());
  }

  _hitApi<T extends IViewModel>({
    ApiType type,
    String endPoint,
    BaseResponseListener<T> listener,
    IMapper mapper,
    String query,
  }) async {
    listener.showProgress(true);
    isConnected().then(
      (b) {
        if (b != null && b) {
          apiRequest<T>(
            apiType: type,
            endPoint: endPoint,
            mapper: mapper,
            queryParams: query,
          ).listen((dataModel) {
            if (dataModel != null) {
              if (dataModel.status) {
                listener.showProgress(false);
                listener.updateIfLive(dataModel);
              } else {
                listener.showProgress(false);
                listener.onError(dataModel.error);
              }
            } else {
              listener.showProgress(false);
              listener.onError('null data model');
            }
          }, onError: (ee) {
            print(ee.toString());
            listener.showProgress(false);
            listener.onError(Strings.tryAgainText);
          });
        } else {
          listener.showProgress(false);
          listener.onError(Strings.noInternet);
        }
      },
      onError: (ee) {
        listener.showProgress(false);
        listener.onError(Strings.internetError);
      },
    );
  }
}
