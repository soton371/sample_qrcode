import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_qrcode/blocs/login/login_bloc.dart';
import 'package:sample_qrcode/blocs/submit_label/submit_label_bloc.dart';
import 'package:sample_qrcode/config/colors.dart';
import 'package:sample_qrcode/views/signin/signin_scr.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async{
  //for hive
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  //for hive
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SubmitLabelBloc>(
          create: (BuildContext context) => SubmitLabelBloc(),
        ),
        BlocProvider<LoginBloc>(
          create: (BuildContext context) => LoginBloc(),
        ),

      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.seed),
          useMaterial3: true,
        ),
        home: const SignInScreen(),
      ),
    );
  }
}
