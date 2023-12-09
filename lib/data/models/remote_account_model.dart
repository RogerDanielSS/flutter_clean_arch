import '../../domain/entities/entities.dart';

import '../http/http.dart';

class RemoteAccountModel {
  final String accessToken;

  RemoteAccountModel(this.accessToken);

  factory RemoteAccountModel.fromJson(Map json) {
    if (!json.containsKey('accessToken') || json['accessToken'] == '') {
      throw HttpError.invalidData;
    }

    return RemoteAccountModel(json['accessToken']);
  }

  AccountEntity toEntity() {
    return AccountEntity(accessToken);
  }
}
