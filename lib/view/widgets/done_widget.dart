import 'package:flutter/material.dart';
import 'package:words/controller/write_data_cubit/write_data_cubit.dart';

import '../styles/color_manager.dart';

class DoneWidget extends StatelessWidget {
  const DoneWidget({super.key, required this.onTap, required this.activeColor});
  final VoidCallback onTap;
  final int activeColor;

  @override
  Widget build(BuildContext context) {
    return  Align(
      alignment: Alignment.bottomRight,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(20),
            color:ColorManager.white
          ),
          child:  Text("Done",style: TextStyle(color:Color( activeColor),),)
        ),
      ),
    );
  }
}
