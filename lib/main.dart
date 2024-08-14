import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list_app/task/bloc/tasks_bloc.dart';
import 'package:to_do_list_app/task/data_providers/tasks_data_provider.dart';
import 'application/routes/routes.dart';
import 'application/utils/project_utitl.dart';
import 'global_repository/task_repository.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {

    projectUtil.statusBarColor();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => TasksBloc(TaskRepository(taskDataProvider: TaskDataProvider())),
        ),
      ],
      child: MaterialApp.router(
        //navigatorKey: NavigationService.navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'My Todo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
        routerConfig: Routes.router,
      ),
    );
  }
}