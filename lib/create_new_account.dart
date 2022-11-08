import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:semsarkapp/net_work_handler.dart';
import '../pallete.dart';
import '../widgets/widgets.dart';

// ignore: use_key_in_widget_constructors
class CreateNewAccount extends StatefulWidget {
  @override
  State<CreateNewAccount> createState() => _CreateNewAccountState();
}

class _CreateNewAccountState extends State<CreateNewAccount> {
// ignore: prefer_typing_uninitialized_variables
var selectedCounrty;
 final _globalkey = GlobalKey<FormState>();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _email =  TextEditingController();
  //final TextEditingController _location = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final  TextEditingController _password = TextEditingController();
    bool vis=true;
  RegExp regex =
  RegExp(r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}$');
  String? errorText;
  bool validate = false;
  bool circular = false;
NetworkHandler networkHandler = NetworkHandler();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        const BackgroundImage(image: 'assets/images/image2.jpg'),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child:Form(
              key: _globalkey,
            child: Column(
              children: [
                SizedBox(
                  height: size.width * 0.1,
                ),
                Stack(
                  children: [
                    Center(
                      child: ClipOval(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                          child: CircleAvatar(
                            radius: size.width * 0.14,
                            backgroundColor: Colors.grey[400]!.withOpacity(
                              0.4,
                            ),
                            child: Icon(
                              FontAwesomeIcons.user,
                              color: kWhite,
                              size: size.width * 0.1,
                            ),
                          ),
                        ),
                      ),
                    ),
             
                  ],
                ),
                SizedBox(
                  height: size.width * 0.1,
                ),
                Column(
                  children: [
                usernameTextField(),
                emailTextField(),
                locationDrop(),
                phoneWidget(),
               passTextFiled(),
                 
               
                    const SizedBox(
                      height: 25,
                    ),

                 
    InkWell(
      
      onTap:() async{
        setState(() {
          circular=true;
        });
        await checkUser();
      if(_globalkey.currentState?.validate()==true && validate){
        Map<String,String>data={
          "Username":_username.text,
          "email":_email.text,
          "password":_password.text

        };
       // print(data);
         await networkHandler.post("/user/register",data);
         setState(() {
           circular=false;
         });
      }
      else{
        setState(() {
          circular=false;
        });
      }
      },

    child:circular? const CircularProgressIndicator()
    :Container(
      height: size.height * 0.08,
      width: size.width * 0.6,
      
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: kBlue,
      ),
        child:Center(
        child: Text(
          'Register'.tr(),
          style: kBodyText.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        ),
    ),
    ),
     
                    
              
         
               
                    
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Text(
                          'Already have an account?'.tr(),
                          style: kBodyText,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, 'LoginScreen');
                          },
                          child: Text(
                            'Login'.tr(),
                            style: kBodyText.copyWith(
                                color: kBlue, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        ),
      ],
    );
  }

  checkUser() async{
    if(_username.text.isEmpty){
      setState(() {
        validate = false;
        errorText = "Username Can't be empty";
      });
    }else {
      var response = await networkHandler.get("/user/checkusername/${_username.text}");
      if(response['Status']){
        setState(() {
          validate = false;
          errorText = "Username alredy taken";
        });
      }
      else{
        setState(() {
          validate = true;
        });
      }
    }
  }

Widget usernameTextField(){
  Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        height: size.height * 0.08,
        width: size.width * 0.8,
        decoration: BoxDecoration(
          color: Colors.grey[500]!.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: TextFormField(
            controller: _username,
               decoration: InputDecoration(
                errorText: validate?null:errorText,
             // border: InputBorder.none,
              prefixIcon: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(
                 FontAwesomeIcons.user,
                  size: 28,
                  color: kWhite,
                ),
              ),
               contentPadding: const EdgeInsets.all(18),
              hintText: 'User'.tr(),
              hintStyle: kBodyText,
            ),
                //  validator: (value) {
                //         if (value!.isEmpty) {
                //           return  "Required";
                //         }
                //         return null;
                //       },

         
            
            style: kBodyText,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
          ),
        ),
      ),
    );
}

Widget emailTextField(){
  Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        height: size.height * 0.08,
        width: size.width * 0.8,
        decoration: BoxDecoration(
          color: Colors.grey[500]!.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: TextFormField(
            controller: _email,
          

            decoration:  InputDecoration(
            
             // border: InputBorder.none,
              prefixIcon: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(
                 FontAwesomeIcons.envelope,
                  size: 28,
                  color: kWhite,
                ),
              ),
               contentPadding: const EdgeInsets.all(18),
              hintText: 'Email'.tr(),
              hintStyle: kBodyText,
            ),
              
                 validator: (value) {
                        if (value!.isEmpty) {
                          return  "Required";
                         
                        }
                         if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}').hasMatch(value)) {
                          return  "Invalid Email";
                        }
                        return null;
                      },
            style: kBodyText,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next, 
          ),
        ),
      ),
    );
}

Widget locationDrop(){
  Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        
       
      padding: const EdgeInsets.only(left: 10),
        height: size.height * 0.08,
        width: size.width * 0.8,
        decoration: BoxDecoration(
          color: Colors.grey[500]!.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        
        
        child: Center(
      
           child: DropdownButton(
            
                 
                      icon:const Icon(Icons.arrow_drop_down,
                        color: kWhite,
                       size: 36,
                      
                       
                      ),
                      
                      
                    
                        hint:const Text("Select City",style: kBodyText),
                      dropdownColor: barColor,
                    underline:const Divider(thickness: 0,) ,
                    isExpanded: true,
                    
                     items: [      'Nablus',
    'Hebron',
    'Ramallah',
    'Tulkarm',
    'Jericho',
    'Jenin',
    'Bethlehem',
    'Qalqilya',             ].map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),))
                          .toList(),
                      onChanged:(val) {
                      setState(() {
                        selectedCounrty=val;

                      });
                            },
                            

  value: selectedCounrty,

        ),
        
      ),
      
      ),
      
    );
}


Widget phoneWidget(){
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        height: size.height * 0.08,
        width: size.width * 0.8,
        decoration: BoxDecoration(
          color: Colors.grey[500]!.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: TextFormField(
          controller: _phone,

            decoration:  InputDecoration(
            
             // border: InputBorder.none,
              prefixIcon: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(
                 FontAwesomeIcons.phone,
                  size: 28,
                  color: kWhite,
                ),
              ),
              
               contentPadding: const EdgeInsets.all(18),
              hintText: 'Phone Number'.tr(),
              hintStyle: kBodyText,
            ),
              
           validator: (value) {
                        if (value!.isEmpty) {
                          return "Required";
                        }
                        else {
                          if (!RegExp(r'^(?:[0])?[0-9]{9}$').hasMatch(value)) {
                            return ' Should start with 09';
                          }
                          else {
                            return null;}}
                      },
            style: kBodyText,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next, 
          ),
        ),
      ),
    );
}

Widget passTextFiled(){
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
            controller: _password,
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
              hintText: 'Password'.tr(),
              hintStyle: kBodyText,
          
              
              
            ),
            obscureText: vis,
            style: kBodyText,
            textInputAction: TextInputAction.next,
          ),
        ),
      ),
    );
  
}

}