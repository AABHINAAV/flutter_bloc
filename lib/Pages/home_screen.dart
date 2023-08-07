import 'package:c_bloc/Cubit/internet_cubit.dart';
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
          child: BlocConsumer<InternetCubit, InternetStates>(
            listener: (context, state) {
              if (state == InternetStates.Gain) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Internet Connected"),
                    backgroundColor: Colors.green,
                  ),
                );
              } else if (state == InternetStates.Lost) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Internet Disconnected"),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state == InternetStates.Gain) {
                return Text("Internet Gained");
              } else if (state == InternetStates.Lost) {
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
