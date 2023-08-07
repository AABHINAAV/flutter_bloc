import 'package:c_bloc/Blocs/internet_bloc.dart';
import 'package:c_bloc/Blocs/internet_bloc_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Learn Bloc"),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: BlocConsumer<InternetBloc, InternetState>(
            listener: (context, state) {
              if (state is InternetGainState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Internet Connected"),
                    backgroundColor: Colors.green,
                  ),
                );
              } else if (state is InternetLostState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Internet Disconnected"),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is InternetGainState) {
                return Text("Internet Gained");
              } else if (state is InternetLostState) {
                return Text("Internet Lost");
              }

              return Text("Loading...");
            },
          ),
        ),
      ),
    );
  }
}
