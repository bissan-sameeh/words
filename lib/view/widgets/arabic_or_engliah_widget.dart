import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:words/controller/write_data_cubit/write_data_cubit.dart';

import '../styles/color_manager.dart';

class ArabicOrEnglishWidget extends StatelessWidget {
  const ArabicOrEnglishWidget(
      {super.key, required this.colorCode, required this.arabicIsSelected});

  final int colorCode;
  final bool arabicIsSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildContainer(true, context),
        const SizedBox(width: 8,),
        _buildContainer(false, context),

      ],
    );
  }

  Widget _buildContainer(bool isArabic, BuildContext context) {
    bool selected =isArabic == arabicIsSelected;
    return InkWell(
      onTap: () => WriteDataCubit.get(context).updateIsArabic(isArabic),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: selected ? ColorManager.white: Color(WriteDataCubit.get(context).colorCode),
          border:selected ? null : Border.all(width: 2),
        ),
        child: Text(isArabic ? 'Ar' : 'En', style: TextStyle(fontSize: 18,
            fontWeight: FontWeight.bold,
            color: selected ? Color(WriteDataCubit
                .get(context)
                .colorCode) : ColorManager.white),),
      ),
    );
  }


}
