import 'package:flutter/cupertino.dart';
import 'package:words/view/widgets/text_form_widget.dart';

class FormWidget extends StatelessWidget {
  const FormWidget({super.key, required this.formKey});
   final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    return  Form(

        key: formKey,

        child: const TextFormWidget(label: 'New Word',

    ));
  }
}
