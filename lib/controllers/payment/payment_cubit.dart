import 'package:bloc/bloc.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zappy_meal/repositories/payment_repository.dart';
import 'package:zappy_meal/shared/utils/logger_util.dart';

import '../../models/base/base_res_model.dart';
import '../../services/base_service.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentRepository paymentRepository = PaymentRepository();
  PaymentCubit() : super(PaymentInitial());

  void list_psps(BuildContext context) async {
    emit(PaymentPSPListInit());
    try {
      AppBaseResponse res = await paymentRepository.list_psps(context);
      res.statusCode == 200 ? emit(PaymentPSPListSuccess(res)) : emit(PaymentPSPListError(res));
    } catch (e) {
      logError(["List psps cubit", e]);
      emit(PaymentPSPListError(BaseService.serverError()));
    }
  }
}
