import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:komando_app/config/themes/app_theme.dart';
import 'package:komando_app/data/models/data_models.dart';
import 'package:komando_app/presentation/providers/providers.dart';
import 'package:komando_app/presentation/widgets/custom_progress_indicator.dart';

class StudentDetailsPage extends ConsumerWidget {
  StudentDetailsPage({super.key});

  final TextStyle style = GoogleFonts.robotoCondensed(
      fontSize: 18,
      color: AppTheme.secondaryColor,
      fontWeight: FontWeight.w500);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Student studentSelected = ref.watch(studentSelectedProvider);
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: size.height * .10,
              width: size.width,
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              decoration: const BoxDecoration(
                color: AppTheme.softColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    studentSelected.name,
                    style: style,
                  ),
                  Text(
                    studentSelected.mobilePhone,
                    style: style,
                  ),
                  Text(
                    '${studentSelected.dateIn.day}-${studentSelected.dateIn.month}-${studentSelected.dateIn.year}',
                    style: style,
                  ),
                ],
              ),
            ),
            Expanded(child: PaymentsList()),
            Container(
              height: size.height * .07,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(color: AppTheme.softColor),
              child: TotalPayments(),
            )
          ],
        ),
      ),
    );
  }
}

class PaymentsList extends ConsumerWidget {
  PaymentsList({super.key});

  final TextStyle style = GoogleFonts.robotoCondensed(
      fontSize: 16,
      color: AppTheme.secondaryColor,
      fontWeight: FontWeight.w500);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final payments = ref.watch(paymentsProvider);
    return payments.when(
      data: (data) {
        if (data.isEmpty) {
          return const Center(
            child: Text('No hay pagos registrados para este alumno'),
          );
        } else {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final payment = data[index];
              return ListTile(
                title: Row(
                  children: [
                    const Icon(Icons.calendar_month),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${payment.date.day}-${payment.date.month}-${payment.date.year}',
                      style: style,
                    ),
                  ],
                ),
                trailing: Text(
                  '${payment.mont}',
                  style: style,
                ),
              );
            },
          );
        }
      },
      error: (error, stackTrace) => Center(
        child: Text('ERROR: $error'),
      ),
      loading: () => CustomProgressIndicator(
        size: 50,
      ),
    );
  }
}

class TotalPayments extends ConsumerWidget {
  TotalPayments({super.key});

  final TextStyle style = GoogleFonts.robotoCondensed(
      fontSize: 18,
      color: AppTheme.secondaryColor,
      fontWeight: FontWeight.w500);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final payments = ref.watch(paymentsProvider);
    return payments.when(
      data: (data) {
        double total = 0;
        for (final payment in data) {
          total += payment.mont;
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'TOTAL ',
              style: style,
            ),
            Text(
              '$total',
              style: style,
            )
          ],
        );
      },
      error: (error, stackTrace) => Center(
        child: Text('ERROR: $error'),
      ),
      loading: () => CustomProgressIndicator(
        size: 50,
      ),
    );
  }
}
