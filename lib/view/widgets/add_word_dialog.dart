import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words/controller/write_data_cubit/write_data_cubit.dart';
import 'package:words/view/widgets/arabic_or_engliah_widget.dart';
import 'package:words/view/widgets/colors_widget.dart';
import 'package:words/view/widgets/done_widget.dart';

import '../../helper/snack_bar.dart';
import 'form_widget.dart';

class AddWordDialog extends StatelessWidget with ShowSnackBar{
   AddWordDialog({super.key, required this.backgroundColor});
  final int backgroundColor;

  final GlobalKey<FormState> formKey = GlobalKey<FormState> ();


  @override
  Widget build(BuildContext context) {
    return  Dialog(
      backgroundColor: Color(backgroundColor),
      child: BlocConsumer<WriteDataCubit,WriteDataState>(
        listener: (context, state) {
          if(state is WriteDataSuccessState){
            Navigator.of(context).pop(context);
          }  else if(state is WriteDataErrorState){
        showSnackBar(context, message: state.message,error: true);

          }
        },
        builder:(context,state){
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
            color: Color(WriteDataCubit.get(context).colorCode),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ArabicOrEnglishWidget(colorCode: WriteDataCubit.get(context).colorCode, arabicIsSelected: WriteDataCubit.get(context).isArabic,),
               const SizedBox(
                  height: 12,
                ),
                ColorsWidget(activeColorCode: WriteDataCubit.get(context).colorCode),
                const SizedBox(
                  height: 12,
                ),
                FormWidget(
                  formKey:formKey ,

                ),
                const SizedBox(
                  height: 15,
                ),
                DoneWidget(onTap: () {
                  if(formKey.currentState!.validate()){
                    WriteDataCubit.get(context).addWord();
                  }
                }, activeColor: WriteDataCubit.get(context).colorCode ),



              ],
            ),
          );
        }
      )

    );
  }
}
