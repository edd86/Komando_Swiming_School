import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:komando_app/data/models/data_models.dart';
import 'package:komando_app/data/source/firebase_datasource.dart';

class PaymentHelper {
  final FirebaseDataSource _dataSource =
      FirebaseDataSourceImpl(FirebaseFirestore.instance);

  Future<bool> addPayment(
      double mont, DateTime insDate, Student student) async {
    Payment payment = Payment(date: insDate, mont: mont, student: student);
    try {
      await _dataSource.addPayment(payment);
      return true;
    } catch (e) {
      print('Error adding payment: $e');
      return false;
    }
  }

  Future<List<Payment>> getPaymentsByStudent(Student student) async {
    List<Payment> payments = await _dataSource.getPayments();
    final filteredPayments =
        payments.where((payment) => payment.student.id == student.id).toList();
    return filteredPayments;
  }
}
