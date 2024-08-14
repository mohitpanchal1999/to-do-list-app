import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list_app/application/utils/app_icons.dart';
import 'package:to_do_list_app/application/utils/font_sizes.dart';
import '../../app_global_components/widgets.dart';
import '../../application/enums/app_enum.dart';
import '../../application/utils/app_color.dart';
import '../../application/utils/project_utitl.dart';
import '../bloc/tasks_bloc.dart';
import '../models/task_model.dart';
import '../pages/edit_task_screen.dart';

class TaskItemView extends StatefulWidget {
  final TaskModel taskModel;
  const TaskItemView({super.key, required this.taskModel});

  @override
  State<TaskItemView> createState() => _TaskItemViewState();
}

class _TaskItemViewState extends State<TaskItemView> {

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Checkbox(
            activeColor: dCheckBoxColor,
                value: widget.taskModel.completed,
                onChanged: (value) {
                  DateTime dateTimeOfCompletion = DateTime.now();
                  TaskModel taskModel = TaskModel.fromJson(widget.taskModel.toJson());
                  taskModel.completed = !widget.taskModel.completed;
                  taskModel.dateTimeOfCompletion = dateTimeOfCompletion;
                  context.read<TasksBloc>().add(
                      UpdateTaskEvent(taskModel: taskModel,taskStatusTyp:TaskStatusTyp.updateStatus));
                }),
            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: buildText(
                          widget.taskModel.title,
                          dBlackColor,
                          textMedium,
                          FontWeight.w500,
                          TextAlign.start,
                          TextOverflow.clip)),
                      PopupMenuButton<int>(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: dWhiteColor,
                        elevation: 1,
                        onSelected: (value) {
                          switch (value) {
                            case 0:
                              {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => EditTaskScreen(taskModel: widget.taskModel)),
                                );

                                break;
                              }
                            case 1:
                              {
                                context.read<TasksBloc>().add(
                                    DeleteTaskEvent(taskModel: widget.taskModel));
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
                                  AppIcons.iconSvgProvider(imageUrl: AppIcons.editIcon,iconSize: const Size(20,20)),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  buildText(
                                      'Edit',
                                      dBlackColor,
                                      textMedium,
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
                              AppIcons.iconSvgProvider(imageUrl: AppIcons.deleteIcon,iconSize: const Size(20,20)),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  buildText(
                                      'Delete!',
                                      dRed,
                                      textMedium,
                                      FontWeight.normal,
                                      TextAlign.start,
                                      TextOverflow.clip)
                                ],
                              ),
                            ),
                          ];
                        },
                        child:  AppIcons.iconSvgProvider(imageUrl: AppIcons.verticalMenuIcon,iconSize: const Size(20,20)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5,),
                  buildText(
                      widget.taskModel
                          .description,
                      dGrey1,
                      textSmall,
                      FontWeight.normal,
                      TextAlign.start,
                      TextOverflow.clip),
                  const SizedBox(height: 15,),
                  Container(
                      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5))
                      ),
                      child: Row(
                        children: [
                          Expanded(child: buildText(
                              '${projectUtil.formatDate(dateTime: widget.taskModel
                                  .creationDateTime.toString())} ${ widget.taskModel.dateTimeOfCompletion!=null?"- ${projectUtil.formatDate(dateTime: widget.taskModel
                                  .dateTimeOfCompletion.toString())}":""}', dBlackColor, textTiny,
                              FontWeight.w400, TextAlign.start, TextOverflow.clip),)
                        ],
                      )
                  )
                ],
              ),
            )
          ],
        ));
  }

}