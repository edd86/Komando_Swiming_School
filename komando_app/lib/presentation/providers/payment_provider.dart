import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:komando_app/data/models/data_models.dart';
import 'package:komando_app/helpers/helpers.dart';
import 'package:komando_app/presentation/providers/providers.dart';

final paymentsProvider = FutureProvider<List<Payment>>((ref) async {
  final studentSelected = ref.watch(studentSelectedProvider);
  PaymentHelper paymentHelper = PaymentHelper();
  return await paymentHelper.getPaymentsByStudent(studentSelected);
});
