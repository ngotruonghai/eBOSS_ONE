import 'package:flutter/material.dart';

class TaskDetailView extends StatelessWidget{
  const TaskDetailView({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chi tiết nhiệm vụ"),
      ),
    );
  }

}