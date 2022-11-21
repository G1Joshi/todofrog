import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todofrog_client/app/app.dart';
import 'package:todofrog_client/widgets/widgets.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoadingBloc()..add(const GetStatus()),
      child: const LoadingView(),
    );
  }
}

class LoadingView extends StatefulWidget {
  const LoadingView({super.key});

  @override
  LoadingViewState createState() => LoadingViewState();
}

class LoadingViewState extends State<LoadingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoadingBloc, LoadingState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute<HomePage>(
                builder: (context) => const HomePage(),
              ),
            );
          } else if (state is NotAuthenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute<AuthPage>(
                builder: (context) => const AuthPage(),
              ),
            );
          }
        },
        child: const Loader(),
      ),
    );
  }
}
