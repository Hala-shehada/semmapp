
// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:semsarkapp/pallete.dart';

enum DialogsAction {Cancel, Delete}

class AlertDialogs {
   static Future<DialogsAction> yesCancelDialog(
    BuildContext context,
    String title,
    String body,
   ) async {
    final action= await showDialog(
      context: context,
  barrierDismissible: false,
builder: (BuildContext context) {
   return AlertDialog(
     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
    title: Text (title, textAlign: TextAlign.center,style: pText,),
     content: Text(body,textAlign: TextAlign.center),
    actions: <Widget>[
        
       TextButton(
         onPressed: () => Navigator.of(context).pop(DialogsAction.Cancel),
         child: const Text(
           'Cancel',
           style: TextStyle(
               color: Color(0xFFC41A38), fontWeight: FontWeight.w700), // TextStyle
         ), 
        ) ,
      TextButton(
        onPressed: () =>
            Navigator.of(context).pop(DialogsAction.Delete),
         child: const Text(
           'Delete',
           style: TextStyle(
               color: Color (0xFFC41A3B), fontWeight: FontWeight.bold), // TextStyle
          ), // Text
       ), 
    ],
   ); 
},);
        return (action != null) ? action : DialogsAction.Cancel;

        }
        }
