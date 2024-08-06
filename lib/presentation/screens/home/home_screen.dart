import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_search_app/presentation/screens/home/widgets/settings_widget.dart';
import 'package:github_search_app/presentation/screens/home/widgets/home_app_bar.dart';
import 'package:github_search_app/presentation/screens/home/widgets/home_body.dart';
import '../../bloc/home_repo/home_repo_bloc.dart';
import '../../bloc/home_repo/home_repo_event.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeRepoBloc>().add(HomeInitialRequested());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SettingsWidget(),
      appBar: const HomeAppBar(),
      body: const HomeBody(),
    );
  }
}
