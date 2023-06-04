import 'package:flutter/src/widgets/framework.dart';
import 'package:zappy_meal/mock/cart_service.dart';
import 'package:zappy_meal/models/base/base_res_model.dart';

class CartRepository {
  MockCartService meal_service = new MockCartService();
  Future<AppBaseReponse> list_items(BuildContext context) async {
    return meal_service.list_items();
  }
}
