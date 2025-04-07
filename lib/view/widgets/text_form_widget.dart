import 'package:flutter/material.dart';
import 'package:words/controller/write_data_cubit/write_data_cubit.dart';
import 'package:words/view/styles/color_manager.dart';

class TextFormWidget extends StatelessWidget {
  const TextFormWidget({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
     minLines: 1,
     maxLines: 2,
     cursorColor: ColorManager.white,
     style: const TextStyle(color: ColorManager.white,),
     decoration: InputDecoration(

       label: Text(label,style: const TextStyle(color :ColorManager.white),),
       focusedBorder: buildOutlineInputBorder(),
       enabledBorder: buildOutlineInputBorder(),
       errorBorder: buildOutlineInputBorder(isError: true),


     ),
     onChanged: (value) => WriteDataCubit.get(context).updateText(value),
      validator: (value) {
       return _validator(value, WriteDataCubit.get(context).isArabic);
      },
    );
  }

  String?  _validator(String? value,bool isArabic){
    if(value==null  || value.trim().isEmpty  ){
      return 'Can not be Empty Word!';
    }

    for(int i =0 ;i <value.length; i++ ){
      CharType charType =_getCharType(value.codeUnitAt(i));
      if(charType ==CharType.english && isArabic==true){
        return 'Char Number ${i+1} is not Arabic!,';
      } else if(charType ==CharType.arabic && isArabic==false){
        return 'Char Number ${i+1} is not English!,';
      } else if(charType ==CharType.notValid ){
        return 'Char Number ${i+1} is not Valid Character!,';
      }


    }
  }

  CharType _getCharType(int asciiCode){
    if( ( asciiCode >= 65 && asciiCode <= 90) ||( asciiCode >= 97 && asciiCode <= 122)){
      return CharType.english;
    }else if(asciiCode>=1569 && asciiCode <=1610){
      return CharType.arabic;
    }else if(asciiCode== 32){
      return CharType.space;
    }else{
      return CharType.notValid;
    }
  }

  OutlineInputBorder buildOutlineInputBorder({bool isError = false}) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
       borderSide: BorderSide(color:isError ? ColorManager.red: ColorManager.white,width: 2),

     );
  }


}

enum CharType{
  arabic,
  english,
  space,
  notValid

}
