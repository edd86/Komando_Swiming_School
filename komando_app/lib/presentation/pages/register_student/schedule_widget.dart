import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:komando_app/presentation/providers/schedule_provider.dart';
import 'package:komando_app/presentation/widgets/custom_progress_indicator.dart';

class ScheduleWidget extends ConsumerStatefulWidget {
  const ScheduleWidget({super.key});

  @override
  ScheduleWidgetState createState() => ScheduleWidgetState();
}

class ScheduleWidgetState extends ConsumerState {
  @override
  Widget build(BuildContext context) {
    final schedules = ref.watch(scheduleProvider);
    final scheduleSelected = ref.watch(scheduleSelectedProvider);
    return Center(
      child: schedules.when(
        data: (data) {
          return FadeIn(
              child: SegmentedButton(
            segments: data
                .map((e) => ButtonSegment(
                    value: e.startTime,
                    label: Text('${e.startTime} ${e.shift}')))
                .toList(),
            selected: {scheduleSelected},
            onSelectionChanged: (option) {
              ref
                  .read(scheduleSelectedProvider.notifier)
                  .changeSelection(option.first);
              //print('opcion: ${option}');
            },
          ));
        },
        error: (error, stackTrace) {
          //print('error: ${error}');
          return const Text('No existen datos para mostrar');
        },
        loading: () => CustomProgressIndicator(size: 50),
      ),
    );
  }
}


