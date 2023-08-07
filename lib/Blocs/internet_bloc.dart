import 'dart:async';

import 'package:c_bloc/Blocs/internet_bloc_event.dart';
import 'package:c_bloc/Blocs/internet_bloc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity/connectivity.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  Connectivity connectivity = Connectivity();
  StreamSubscription? connectivitySubscription;

  InternetBloc() : super(InternetInitialState()) {
    // * state works
    on<InternetGainEvent>((event, emit) {
      emit(InternetGainState());
    });

    on<InternetLostEvent>((event, emit) {
      emit(InternetLostState());
    });

    // * working
    connectivitySubscription =
        connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        add(InternetGainEvent());
      } else {
        add(InternetLostEvent());
      }
    });
  }

  @override
  Future<void> close() {
    connectivitySubscription?.cancel();
    return super.close();
  }
}
