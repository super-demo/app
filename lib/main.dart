import 'package:app/config/app_config.dart';
import 'package:app/core/constants/app_color.dart';
import 'package:app/features/authentication/data/datasources/auth_remote_datasource.dart';
import 'package:app/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:app/features/authentication/presentation/bloc/auth_event.dart';
import 'package:app/features/authentication/presentation/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            authRepository: AuthRepository(
              authRemoteDataSource: AuthRemoteDataSourceImpl(
                baseUrl: AppConfig.baseUrl,
                appSecret: AppConfig.appSecret,
              ),
            ),
          )..add(CheckAuthStatusEvent()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Super Space',
        theme: ThemeData(
          primarySwatch: AppColors.kPrimarySwatch,
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
