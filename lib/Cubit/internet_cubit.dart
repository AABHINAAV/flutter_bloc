import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity/connectivity.dart';

enum InternetStates { Initial, Lost, Gain }

class InternetCubit extends Cubit<InternetStates> {
  Connectivity connectivity = Connectivity();
  StreamSubscription? connectivitySubscription;

  InternetCubit() : super(InternetStates.Initial) {
    connectivitySubscription =
        connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        emit(InternetStates.Gain);
      } else {
        emit(InternetStates.Lost);
      }
    });
  }

  @override
  Future<void> close() {
    connectivitySubscription?.cancel();
    return super.close();
  }
}
