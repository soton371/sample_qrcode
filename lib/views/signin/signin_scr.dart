import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_qrcode/blocs/login/login_bloc.dart';
import 'package:sample_qrcode/config/colors.dart';
import 'package:sample_qrcode/config/sizes.dart';
import 'package:sample_qrcode/config/urls.dart';
import 'package:sample_qrcode/utilities/responsive.dart';
import 'package:sample_qrcode/views/generate_qr/generate_qr_scr.dart';
import 'package:sample_qrcode/widgets/app_alert.dart';
import 'package:sample_qrcode/widgets/app_button.dart';
import 'package:sample_qrcode/widgets/app_loader.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController usernameCon = TextEditingController();
    TextEditingController passwordCon = TextEditingController();
    bool obscure = true;
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginFailed) {
            Navigator.pop(context);
            appAlert(context,
                title: Text(state.title),
                content: Text(state.content),
                actions: [
                  AppButton(
                      name: "Close",
                      bgColor: AppColors.grey,
                      textColor: AppColors.black,
                      onPressed: () {
                        Navigator.pop(context);
                      })
                ]);
          } else if (state is LoginSuccess) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const GenerateQrScreen()));
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: AppSizes.width(context) * 0.15, vertical: 50),
          height: double.maxFinite,
          width: double.maxFinite,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/bg.jpg"),
                  fit: BoxFit.cover)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //for login
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/drug_icon.png",width: AppSizes.width(context) * 0.025,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "  Sample QRcode",
                            style: TextStyle(
                                fontSize: AppSizes.width(context) * 0.018,
                                fontWeight: FontWeight.bold),
                          ),
                          Text("   ${AppUrls.version}",style: TextStyle(
                            fontSize: AppSizes.width(context) * 0.01,
                            color: AppColors.grey),)
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: AppSizes.height(context) * 0.2,
                  ),
                  const Text(
                    "Start for"
                  ),
                  Text(
                    "Login to your account.\n",
                    style: TextStyle(
                        fontSize: AppSizes.width(context) * 0.03,
                        fontWeight: FontWeight.bold),
                  ),
                  //for input box
                  SizedBox(
                    width: !Responsive.isMobile(context) ? AppSizes.width(context) * 0.25 : AppSizes.width(context) * 0.5,
                    child: TextField(
                      controller: usernameCon,
                      decoration: const InputDecoration(
                          hintText: "Username",
                          filled: true,
                          isDense: true,
                          suffixIcon: Icon(Icons.abc,color: Colors.transparent,),
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide.none,
                              gapPadding: 0)),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: !Responsive.isMobile(context) ? AppSizes.width(context) * 0.25 : AppSizes.width(context) * 0.5,
                    child: TextField(
                      controller: passwordCon,
                      obscureText: obscure,
                      decoration: InputDecoration(
                          hintText: "Password",
                          filled: true,
                          isDense: true,
                          suffixIcon: IconButton(
                            onPressed: (){
                            obscure = !obscure;
                            setState(() {
                              
                            });
                          }, icon: Icon(obscure ? CupertinoIcons.eye :CupertinoIcons.eye_slash)),
                          contentPadding: const EdgeInsets.all(10),
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide.none,
                              gapPadding: 0)),
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        appLoader(context, "Please wait");
                        context.read<LoginBloc>().add(DoLoginEvent(
                            username: usernameCon.text,
                            password: passwordCon.text));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.seed,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero)),
                      child: const Text(
                        "Login to my account",
                        style: TextStyle(color: AppColors.white),
                      ))
                  //for input box
                ],
              ),

              //for icon
              Align(
                alignment: Alignment.bottomRight,
                child: Image.asset(
                  "assets/images/qr.png",
                  height: 40,
                  width: 40,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
