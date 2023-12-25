// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:komando_app/config/themes/app_theme.dart';
import 'package:komando_app/data/models/data_models.dart';
import 'package:komando_app/helpers/helpers.dart';
import 'package:komando_app/presentation/providers/providers.dart';
import 'package:komando_app/presentation/widgets/widgets.dart';

class StudentPaymentsPage extends ConsumerWidget {
  Student student;
  StudentPaymentsPage(this.student, {super.key});

  final TextEditingController _tfMontController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTime insDate = ref.watch(studentDateProvider);
    final Size size = MediaQuery.of(context).size;
    return AlertDialog(
      icon: const Icon(Icons.monetization_on),
      title: const Text('Registro Pagos'),
      content: SizedBox(
        height: size.height / 5,
        width: size.width / 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: const BoxDecoration(
                color: Color.fromARGB(127, 195, 252, 242),
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              child: TextField(
                controller: _tfMontController,
                keyboardType: TextInputType.number,
                textCapitalization: TextCapitalization.sentences,
                style: GoogleFonts.robotoCondensed(fontSize: 17),
                decoration: const InputDecoration(
                  hintText: 'Monto',
                  icon: Icon(Icons.money),
                ),
              ),
            ),
            TextButton.icon(
              icon: const Icon(
                Icons.calendar_month,
                color: AppTheme.secondaryColor,
              ),
              label: Text(
                'Fecha: ${insDate.day} - ${insDate.month} - ${insDate.year}',
                style: GoogleFonts.robotoCondensed(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.secondaryColor,
                ),
              ),
              onPressed: () async {
                DateTime? newDate = await showDatePicker(
                  context: context,
                  firstDate: DateTime(2023),
                  lastDate: DateTime(2050),
                  currentDate: insDate,
                );
                if (newDate != null) {
                  ref.read(studentDateProvider.notifier).state = newDate;
                }
              },
            )
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text(
            'Guardar',
            style: GoogleFonts.robotoCondensed(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppTheme.secondaryColor,
            ),
          ),
          onPressed: () async {
            if (_tfMontController.text.isNotEmpty) {
              double mont = double.parse(_tfMontController.text);
              PaymentHelper helper = PaymentHelper();
              if (await helper.addPayment(mont, insDate, student)) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(snackBarMessage('Pago Registrado'));
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context)
                    .showSnackBar(snackBarMessage('No se registro el Pago'));
              }
            }
          },
        ),
        TextButton(
          child: Text(
            'Cancelar',
            style: GoogleFonts.robotoCondensed(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppTheme.secondaryColor,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
