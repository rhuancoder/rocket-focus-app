import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fokus/app/view_model/timer_view_model.dart';

void main() {
  group('TimerViewModel', () {
    late TimerViewModel vm;
    late ValueNotifier<bool> isPaused;

    setUp(() {
      vm = TimerViewModel();
      isPaused = ValueNotifier<bool>(false);
    });
    test('inicia parado com duração zero', () {
      expect(vm.isPlaying, isFalse);
      expect(vm.duration, Duration.zero);
    });

    group('startTimer', () {
      test('liga o temporizador e zera a duração', () {
        vm.duration = Duration(minutes: 10);
        vm.startTimer(5, isPaused);

        expect(vm.isPlaying, isTrue);
        expect(vm.duration, Duration.zero);
      });

      test('incrementa a cada segundo quando não está pausado', () async {
        vm.startTimer(5, isPaused);
        await Future.delayed(Duration(seconds: 1));

        expect(vm.duration.inSeconds, 1);
      });

      test('não incrementa o valor quando está pausado', () async {
        isPaused.value = true;
        vm.startTimer(5, isPaused);
        await Future.delayed(Duration(seconds: 1));

        expect(vm.duration, Duration.zero);

        isPaused.value = false;
        await Future.delayed(Duration(seconds: 1));

        expect(vm.duration.inSeconds, 1);
      });
    });

    group('stopTime - ', () {
      test('desliga o temporizador', () {
        vm.startTimer(1, isPaused);

        expect(vm.isPlaying, isTrue);

        vm.stopTime();

        expect(vm.isPlaying, isFalse);
      });
    });
  });
}
