import 'package:bloc/bloc.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zappy_meal/models/base/base_res_model.dart';
import 'package:zappy_meal/repositories/cart_repository.dart';
import 'package:zappy_meal/services/base_service.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  CartRepository cart_repository = CartRepository();

  void list_items(BuildContext context) async {
    emit(CartListInit());
    try {
      BaseResponse res = await cart_repository.list_items(context);
      res.statusCode == 200 ? emit(CartListSuccess(res)) : emit(CartListError(res));
    } catch (e) {
      emit(CartListError(BaseService.serverError()));
    }
  }
}
