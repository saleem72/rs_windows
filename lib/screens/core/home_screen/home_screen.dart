//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rs_windows/screens/core/home_screen/dashboard_bloc/dashboard_bloc.dart';
import 'package:rs_windows/widgets/loading_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardBloc()..add(DashboardGetData()),
      child: const HomeScreenContent(),
    );
  }
}

class HomeScreenContent extends StatelessWidget {
  const HomeScreenContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: SegmantedView(
        child: Column(children: [
          _content(context),
        ]),
      ),
    );
  }

  Widget _content(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        return Expanded(
          child: Stack(
            children: [
              const Text('Home'),
              LoadingView(
                  isVisible: (state is DashboardLoading) ? true : false),
            ],
          ),
        );
      },
    );
  }
}

class SegmantedView extends StatelessWidget {
  const SegmantedView({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool showFlangs = size.width > 600;
    return Row(
      children: [
        if (showFlangs)
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.green,
            ),
          ),
        showFlangs
            ? Container(
                constraints: const BoxConstraints(
                  maxWidth: 600,
                ),
                color: Colors.pink,
                alignment: Alignment.center,
                child: child,
              )
            : Expanded(
                child: Container(
                color: Colors.pink,
                alignment: Alignment.center,
                child: child,
              )),
        if (showFlangs)
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.green,
            ),
          ),
      ],
    );
  }
}
