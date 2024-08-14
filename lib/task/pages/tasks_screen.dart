import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do_list_app/application/utils/app_icons.dart';
import 'package:to_do_list_app/application/utils/project_utitl.dart';
import 'package:to_do_list_app/task/bloc/tasks_bloc.dart';
import '../../app_global_components/build_text_field.dart';
import '../../app_global_components/custom_app_bar.dart';
import '../../app_global_components/widgets.dart';
import '../../application/enums/app_enum.dart';
import '../../application/utils/app_color.dart';
import '../../application/utils/font_sizes.dart';
import '../../application/utils/messages.dart';
import '../widget/task_item_view.dart';


class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    context.read<TasksBloc>().add(FetchTaskEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        child: ScaffoldMessenger(
            child: Scaffold(
              backgroundColor: dWhiteColor,
              appBar: CustomAppBar(
                title: 'Hello, guest',
                showBackArrow: false,
                actionWidgets: [
                  filterAction(),
                ],
              ),
              body: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: BlocConsumer<TasksBloc, TasksState>(
                          listener: (context, state) {
                            if (state is LoadTaskFailure) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(projectUtil.getSnackBar(state.error, dRed));
                            }
                            if (state is UpdateTaskSuccess) {

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(projectUtil.getSnackBar(getUpdateMessage(state.taskStatusTyp!), dGreen));
                            }
                            if (state is DeleteTaskSuccess) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(projectUtil.getSnackBar(deleteSuccessMessage, dRed));
                            }
                            if (state is AddTaskFailure || state is UpdateTaskFailure) {
                              context.read<TasksBloc>().add(FetchTaskEvent());
                            }
                          }, builder: (context, state) {
                        if (state is TasksLoading) {
                          return const Center(
                            child: CupertinoActivityIndicator(),
                          );
                        }

                        if (state is LoadTaskFailure) {
                          return Center(
                            child: buildText(
                                state.error,
                                dBlackColor,
                                textMedium,
                                FontWeight.normal,
                                TextAlign.center,
                                TextOverflow.clip),
                          );
                        }

                        if (state is FetchTasksSuccess) {
                          return state.tasks.isNotEmpty || state.isSearching
                              ? Column(
                            children: [
                              BuildTextField(
                                  hint: searchHint ,
                                  controller: searchController,
                                  inputType: TextInputType.text,
                                  prefixIcon: const Icon(
                                    Icons.search,
                                    color: dGrey2,
                                  ),
                                  fillColor: dWhiteColor,
                                  onChange: (value) {
                                    context.read<TasksBloc>().add(
                                        SearchTaskEvent(keywords: value));
                                  }),
                              const SizedBox(
                                height: 20,
                              ),
                              Expanded(
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    itemCount: state.tasks.length,
                                    itemBuilder: (context, index) {
                                      return TaskItemView(
                                          taskModel: state.tasks[index]);
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return const Divider(
                                        color: dGrey3,
                                      );
                                    },
                                  ))
                            ],
                          )
                              : Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buildText(
                                    emptyTaskListTitleMessage,
                                    dBlackColor,
                                    textBold,
                                    FontWeight.w600,
                                    TextAlign.center,
                                    TextOverflow.clip),
                                buildText(
                                    emptyTaskListSubTitleMessage,
                                    dBlackColor.withOpacity(.5),
                                    textSmall,
                                    FontWeight.normal,
                                    TextAlign.center,
                                    TextOverflow.clip),
                              ],
                            ),
                          );
                        }
                        return Container();
                      }))),
              floatingActionButton:    FloatingActionButton(
                  backgroundColor: dDuttonBgColor4,
                  foregroundColor: Colors.white,
                  child: const Icon(
                    Icons.add,
                    color: dWhiteColor,
                    size: 30,
                  ),
                  onPressed: () {
                    context.go("/task_page/new_task_page");
                    // Navigator.pushNamed(context, Pages.createNewTask);
                  }),
            )));
  }



  /// Return Message according to update task action by user
  String getUpdateMessage(TaskStatusTyp taskStatusTyp){
    switch(taskStatusTyp){
      case TaskStatusTyp.updateStatus :
        return updateStatusMessage;
      default:
        return updateSuccessMessage;
    }
  }

  //m Manage filter according to task list
  filterAction() {
    return BlocConsumer<TasksBloc, TasksState>( builder: (context, state){
      if (state is FetchTasksSuccess ) {
        if(state.tasks.isEmpty){
return const SizedBox();
        }
        return PopupMenuButton<int>(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 1,
          onSelected: (value) {
            switch (value) {
              case 0:
                {
                  context
                      .read<TasksBloc>()
                      .add(SortTaskEvent(sortOption: 0));
                  break;
                }
              case 1:
                {
                  context
                      .read<TasksBloc>()
                      .add(SortTaskEvent(sortOption: 1));
                  break;
                }
              case 2:
                {
                  context
                      .read<TasksBloc>()
                      .add(SortTaskEvent(sortOption: 2));
                  break;
                }
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<int>(
                value: 0,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    buildText(
                        'Sort by date',
                        dBlackColor,
                        textSmall,
                        FontWeight.normal,
                        TextAlign.start,
                        TextOverflow.clip)
                  ],
                ),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: Row(
                  children: [

                    const SizedBox(
                      width: 10,
                    ),
                    buildText(
                        'Completed tasks',
                        dBlackColor,
                        textSmall,
                        FontWeight.normal,
                        TextAlign.start,
                        TextOverflow.clip)
                  ],
                ),
              ),
              PopupMenuItem<int>(
                value: 2,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    buildText(
                        'Pending tasks',
                        dBlackColor,
                        textSmall,
                        FontWeight.normal,
                        TextAlign.start,
                        TextOverflow.clip)
                  ],
                ),
              ),
            ];
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: AppIcons.iconSvgProvider(imageUrl: AppIcons.filterIcon),
          ),
        );
      }
      return const SizedBox();

    }, listener: (BuildContext context, TasksState state) {  },);
  }
}
