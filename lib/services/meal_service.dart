import 'package:zappy_meal/models/base/base_res_model.dart';

import 'base_service.dart';

class MealService extends BaseService {
  Future<BaseResponse> listMeals() async {
    return await baseGet(urlPath: '');
  }
}
