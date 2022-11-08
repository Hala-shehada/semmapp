// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../pallete.dart';

class PasswordInput extends StatefulWidget {
 
    const PasswordInput({
    Key? key,
    required this.icon,
    required this.hint,
    this.inputType,
    this.inputAction,
  }) : super(key: key);

  final IconData icon;
  final String hint;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  
  bool vis=true;
  RegExp regex =
  RegExp(r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}$');

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0,),
      child: Container(
        height: size.height * 0.08,
        width: size.width * 0.8,
        decoration: BoxDecoration(
          color: Colors.grey[500]!.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: TextFormField(
             validator: (value) {
                        if (value!.isEmpty) {
                          return 'Required';
                        }

                        else if(value.length<8){
                          return  "Password must be more than 8 characters";
                        }
                        else {
                          if (!regex.hasMatch(value)) {
                            return 'Password does not meet the conditions';
                          }
                          else {
                            return null;}}
                      },
            decoration: InputDecoration(
             // border: InputBorder.none,
              prefixIcon: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(
                 FontAwesomeIcons.lock,
                  size: 28,
                  color: kWhite,
                ),
              ),
             
              suffixIcon:  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: IconButton(
                  icon:  Icon( vis?Icons.visibility_off:Icons.visibility,size: 28,color: kWhite,),
                  onPressed:()  {
                    setState(() {
                      vis=!vis;
                    });
                  },
                ),
                
              ),
              
              contentPadding: const EdgeInsets.all(18),
              hintText: widget.hint,
              hintStyle: kBodyText,
          
              
              
            ),
            obscureText: vis,
            style: kBodyText,
            keyboardType: widget.inputType,
            textInputAction: widget.inputAction,
          ),
        ),
      ),
    );
  }
}
