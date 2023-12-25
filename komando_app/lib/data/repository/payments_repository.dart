import 'package:komando_app/data/models/data_models.dart';
import 'package:komando_app/data/source/firebase_datasource.dart';

abstract class PaymentsRepository {
  Future<List<Payment>> getPayments();
  Future<void> addPayment(Payment payment);
}

class PaymentsRepositoryImpl implements PaymentsRepository {
  final FirebaseDataSource _firebaseDataSource;

  PaymentsRepositoryImpl(this._firebaseDataSource);

  @override
  Future<void> addPayment(Payment payment) async {
    await _firebaseDataSource.addPayment(payment);
  }

  @override
  Future<List<Payment>> getPayments() async {
    return await _firebaseDataSource.getPayments();
  }
}
