import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list_app/application/utils/project_utitl.dart';
import '../../app_global_components/build_text_field.dart';
import '../../app_global_components/custom_app_bar.dart';
import '../../app_global_components/widgets.dart';
import '../../application/enums/app_enum.dart';
import '../../application/utils/app_color.dart';
import '../../application/utils/font_sizes.dart';
import '../bloc/tasks_bloc.dart';
import '../models/task_model.dart';

class EditTaskScreen extends StatefulWidget {
  final TaskModel taskModel;
  const EditTaskScreen({super.key,required this.taskModel});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  bool init = false;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    if(!init){
      init = true;
      title.text = widget.taskModel.title;
      description.text = widget.taskModel.description;
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        child: Scaffold(
            backgroundColor: dWhiteColor,
            appBar: const CustomAppBar(
              title: 'Edit Task',
            ),
            body: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => FocusScope.of(context).unfocus(),
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: BlocConsumer<TasksBloc, TasksState>(
                        listener: (context, state) {
                          if (state is AddTaskFailure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                projectUtil.getSnackBar(state.error, dRed));
                          }
                          if (state is UpdateTaskSuccess) {
                            Navigator.pop(context);
                          }
                        }, builder: (context, state) {
                      String errorMessage = "";
                      if (state is AddTaskFailure) {
                        errorMessage = state.error;
                      }
                      return ListView(
                        children: [

                          const SizedBox(height: 20),
                          buildText(
                              'Title',
                              dBlackColor,
                              textMedium,
                              FontWeight.bold,
                              TextAlign.start,
                              TextOverflow.clip),
                          const SizedBox(
                            height: 10,
                          ),
                          BuildTextField(
                              hint: "Task Title",
                              controller: title,
                              inputType: TextInputType.text,
                              fillColor: dWhiteColor,errorMessage: errorMessage,
                              onChange: (value) {

                              }
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          buildText(
                              'Description',
                              dBlackColor,
                              textMedium,
                              FontWeight.bold,
                              TextAlign.start,
                              TextOverflow.clip),
                          const SizedBox(
                            height: 10,
                          ),
                          BuildTextField(
                              hint: "Task Description",
                              controller: description,
                              inputType: TextInputType.multiline,
                              fillColor: dWhiteColor,
                              onChange: (value) {}),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                      foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                      backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          dWhiteColor),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              10), // Adjust the radius as needed
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: buildText(
                                          'Cancel',
                                          dBlackColor,
                                          textMedium,
                                          FontWeight.w600,
                                          TextAlign.center,
                                          TextOverflow.clip),
                                    )),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                      foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                      backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          dPrimaryColor),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              10), // Adjust the radius as needed
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      TaskModel taskModel = TaskModel.fromJson(widget.taskModel.toJson());
                                      taskModel.title = title.text;
                                      taskModel.description = description.text;
                                      context.read<TasksBloc>().add(
                                          UpdateTaskEvent(
                                              taskModel: taskModel,taskStatusTyp: TaskStatusTyp.updateDetails));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: buildText(
                                          'Update',
                                          dWhiteColor,
                                          textMedium,
                                          FontWeight.w600,
                                          TextAlign.center,
                                          TextOverflow.clip),
                                    )),
                              ),
                            ],
                          )
                        ],
                      );
                    })))));
  }
}