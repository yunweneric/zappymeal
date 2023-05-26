import 'package:zappy_meal/models/base/base_res_model.dart';

import 'base_service.dart';

class CartService extends BaseService {
  Future<BaseResponse> list_items() async {
    return await baseGet(urlPath: '');
  }
}
