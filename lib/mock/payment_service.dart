import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:zappy_meal/mock/data.dart';
import 'package:zappy_meal/models/base/base_res_model.dart';
import 'package:zappy_meal/models/payment/psp_model.dart';
import '../services/base_service.dart';

class MockPaymentService extends BaseService {
  Future<AppBaseReponse> list_psps(BuildContext context) async {
    List<PSPModel> psps = MockData.psp;
    await Future.delayed(3000.ms, () {});
    return apiSuccess(message: "Psps successfully gotten", data: {"data": psps});
  }
}
