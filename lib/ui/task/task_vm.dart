import 'package:redux/redux.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:thingstodo/data/model/models.dart';
import 'package:thingstodo/redux/app/app_state.dart';
import 'package:thingstodo/redux/task/task_actions.dart';
import 'package:thingstodo/redux/task/task_selectors.dart';

class TaskVM {
  final Map<String, List<TaskModel>> doneTask;
  final Map<String, List<TaskModel>> laterTask;
  final Map<String, List<TaskModel>> importantTask;

  final List<TaskModel> dailyTask;
  final List<TaskModel> monthlyTask;
  final Map<String, List<TaskModel>> weeklyTask;

  final Function createTask;
  final Function removeTask;
  final Function updateTask;

  TaskVM({
    @required this.doneTask,
    @required this.laterTask,
    @required this.importantTask,
    @required this.dailyTask,
    @required this.weeklyTask,
    @required this.monthlyTask,
    @required this.createTask,
    @required this.removeTask,
    @required this.updateTask,
  });

  static TaskVM fromStore(Store<AppState> store) {
    final state = store.state;
    final dispatch = store.dispatch;

    return TaskVM(
      doneTask: TaskSelectors(state).doneTask,
      laterTask: TaskSelectors(state).laterTask,
      importantTask: TaskSelectors(state).importantTask,

      dailyTask: TaskSelectors(state).dailyTask,
      weeklyTask: TaskSelectors(state).weeklyTask,
      monthlyTask: TaskSelectors(state).monthlyTask,

      createTask: (TaskModel task) {
        dispatch(CreateTaskAction(task: task));
      },
      removeTask: (TaskModel task) {
        dispatch(RemoveTaskAction(task: task));
      },
      updateTask: (TaskModel task, TaskModel updates) {
        dispatch(UpdateTaskAction(task: task, updates: updates));
      },
    );
  }
}
