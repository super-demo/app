import 'package:app/config/app_config.dart';
import 'package:app/core/constants/app_color.dart';
import 'package:app/core/services/api.dart';
import 'package:app/features/authentication/data/datasources/auth_remote_datasource.dart';
import 'package:app/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:app/features/authentication/presentation/bloc/auth_event.dart';
import 'package:app/features/authentication/presentation/pages/login_screen.dart';
import 'package:app/features/home/data/repositories/announcement_repository_impl.dart';
import 'package:app/features/home/presentation/bloc/home_bloc.dart';
import 'package:app/features/notification/data/repositories/noti_repository_impl.dart';
import 'package:app/features/notification/presentation/bloc/noti_bloc.dart';
import 'package:app/features/services/data/repositories/mini_app_repository_impl.dart';
import 'package:app/features/services/presentation/bloc/mini_app_bloc.dart';
import 'package:app/features/workspace/data/repositories/workspace_repository_impl.dart';
import 'package:app/features/workspace/presentation/bloc/workspace_bloc.dart';
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
    // Create auth repository first
    final authRemoteDataSource = AuthRemoteDataSourceImpl(
      baseUrl: AppConfig.baseUrl,
      appSecret: AppConfig.appSecret,
    );

    final authRepository = AuthRepository(
      authRemoteDataSource: authRemoteDataSource,
    );

    // Create API service with the auth repository
    final apiService = ApiService(
      baseUrl: AppConfig.baseUrl,
      authRepository: authRepository,
    );

    return MultiRepositoryProvider(
      providers: [
        // Provide repositories and services
        RepositoryProvider<AuthRepository>.value(
          value: authRepository,
        ),
        RepositoryProvider<ApiService>.value(
          value: apiService,
        ),
        RepositoryProvider<NotificationRepository>(
          create: (context) => NotificationRepositoryImpl(
            apiService: apiService, // Use the instance directly
          ),
        ),
        RepositoryProvider<AnnouncementRepository>(
          create: (context) => AnnouncementRepositoryImpl(
            apiService: apiService,
          ),
        ),
        RepositoryProvider<MiniAppRepository>(
          create: (context) => MiniAppRepositoryImpl(
            apiService: apiService,
          ),
        ),
        RepositoryProvider<WorkspaceRepository>(
          create: (context) => WorkspaceRepositoryImpl(
            apiService: apiService,
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepository: authRepository, // Use the instance directly
            )..add(CheckAuthStatusEvent()),
          ),
          BlocProvider<NotificationBloc>(
            create: (context) => NotificationBloc(
              repository: context.read<NotificationRepository>(),
            ),
          ),
          BlocProvider<AnnouncementBloc>(
            create: (context) => AnnouncementBloc(
              repository: context.read<AnnouncementRepository>(),
            ),
          ),
          BlocProvider<MiniAppBloc>(
            create: (context) =>
                MiniAppBloc(repository: context.read<MiniAppRepository>()),
          ),
          BlocProvider<WorkspaceBloc>(
            create: (context) =>
                WorkspaceBloc(repository: context.read<WorkspaceRepository>()),
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
      ),
    );
  }
}
