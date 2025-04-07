import 'package:flutter/material.dart';
import 'package:words/controller/write_data_cubit/write_data_cubit.dart';
import 'package:words/view/styles/color_manager.dart';

import '../widgets/add_word_dialog.dart';
import '../widgets/colors_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Home'),

      ),
      body: Column(
        children: [
          ColorsWidget(activeColorCode: WriteDataCubit.get(context).colorCode)
        ],
      ),
      floatingActionButton: buildFloatingActionButton(context),
    );
  }

  FloatingActionButton buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(onPressed: () {
      showDialog(context: context, builder: (context) =>  AddWordDialog(backgroundColor: WriteDataCubit.get(context).colorCode  ,),);
    },
    child: const Icon(Icons.add,color: ColorManager.black,),

    );
  }
}
