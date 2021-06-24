import 'package:appentus_assignment/model/dto/PhotoDto.dart';
import 'package:appentus_assignment/model/view/PhotoViewModel.dart';
import 'package:appentus_assignment/res/Strings.dart';

import 'IMapper.dart';

class PhotoMapper extends IMapper<String, List<PhotoModel>, PhotoViewModel> {
  @override
  PhotoViewModel toViewModel(String string, int statusCode) {
    PhotoViewModel vm = PhotoViewModel();
    if (statusCode == 200) {
      vm.status = true;
      List<PhotoModel> dto = toDTO(string);
      List<PhotoDataModel> list = new List();

      if (dto != null && dto.length > 0) {
        for (PhotoModel dtoModel in dto) {
          PhotoDataModel dataModel = new PhotoDataModel();
          dataModel.image = dtoModel.downloadUrl;
          dataModel.author = dtoModel.author;
          list.add(dataModel);
        }
      }
      vm.imageList.addAll(list);
    } else {
      vm.status = false;
      vm.error = Strings.tryAgainText;
    }
    return vm;
  }

  @override
  List<PhotoModel> toDTO(String string) {
    return photoDtoFromJson(string);
  }
}
