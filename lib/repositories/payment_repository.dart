import 'package:flutter/src/widgets/framework.dart';
import 'package:zappy_meal/mock/payment_service.dart';

class PaymentRepository {
  MockPaymentService paymentService = MockPaymentService();
  list_psps(BuildContext context) {
    return paymentService.list_psps(context);
  }
}
