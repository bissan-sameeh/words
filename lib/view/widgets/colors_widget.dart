import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:words/controller/write_data_cubit/write_data_cubit.dart';

import '../styles/color_manager.dart';

class ColorsWidget extends StatelessWidget {
   ColorsWidget({super.key, required this.activeColorCode});
  final int activeColorCode;

  final List<int> colorCode=[
    0xFF4A47A3,
    0xFF0C7893,
    0xFFBC6FF1,
    0xFFF4ABC4,
    0xFFC7ee39,
    0xFFef8c8F,
    0xFFFA8072,
    0xFF4D4C7D
  ];

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 50,

      child: ListView.separated(
        // padding: EdgeInsets.all(12),
       physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,

        itemBuilder: (BuildContext context, int index) {
        return  _getItemDesign(index,context);



      }, separatorBuilder: (context, index) => const SizedBox(width: 8,) , itemCount: colorCode.length,

      ),
    );
  }

  Widget _getItemDesign(int index,BuildContext context){
    return InkWell(
      onTap: () => WriteDataCubit.get(context).updateColorCode(colorCode[index])  ,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 750),
        width: 35,
          height: 35,
          decoration: BoxDecoration(
            border:activeColorCode==colorCode[index]? Border.all(color: ColorManager.white,width: 2):null,
          shape: BoxShape.circle,
          color: Color(colorCode[index]),
      ),
      child: Center(
        child:activeColorCode==colorCode[index]? const Icon(Icons.done,color: ColorManager.white,):null,
      ),
      ),
    );
  }
}
