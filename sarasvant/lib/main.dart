import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:sarasvant/router/router.dart';
import 'apps/auth/blocs/auth_bloc.dart';
import 'apps/auth/cubit/phone_form/phone_number_form_cubit.dart';
import 'apps/auth/services/google_auth_services.dart';
import 'apps/auth/services/phone_auth_services.dart';
import 'apps/language/blocs/l10n/l10n_bloc.dart';
import 'constants/app_constants.dart';
import 'firebase_options.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Sarasvant());
}

class Sarasvant extends StatelessWidget {
  const Sarasvant({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => GoogleAuth()),
        RepositoryProvider(create: (context) => PhoneAuth()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
                googleAuthServices: RepositoryProvider.of<GoogleAuth>(context),
                phoneAuthServices: RepositoryProvider.of<PhoneAuth>(context)),
          ),
          BlocProvider(create: (context) => PhoneNumberFormCubit()),
          BlocProvider(create: (context) => L10nBloc()),
        ],
        child: MaterialApp.router(
          title: AppConstants.appName,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          routerConfig: router,
          builder: (context, child) => ResponsiveBreakpoints.builder(
            child: child!,
            breakpoints: [
              const Breakpoint(start: 0, end: 450, name: MOBILE),
              const Breakpoint(start: 451, end: 800, name: TABLET),
              const Breakpoint(start: 801, end: 1920, name: DESKTOP),
            ],
          ),
        ),
      ),
    );
  }
}
