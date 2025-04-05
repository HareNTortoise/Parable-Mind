
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../constants/app_constants.dart';
import '../../language/blocs/l10n/l10n_bloc.dart';
import '../blocs/auth_bloc.dart';
import '../cubit/phone_form/phone_number_form_cubit.dart';
import 'components/phone_number_form.dart';
import 'components/sign_in_options.dart';

class SignInDesktop extends StatelessWidget {
  const SignInDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaledBox(
      width: AppConstants.desktopScaleWidth,
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            context.go('/teacher-dashboard');
          }
        },
        child: BlocBuilder<L10nBloc, L10nState>(
          builder: (context, state) {
            return Localizations.override(
              context: context,
              locale: (state as L10n).locale,
              child: Scaffold(
                body: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Builder(
                          builder: (context) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // SvgPicture.asset(
                                //   'lib/assets/logo.svg',
                                //   width: 220,
                                //   height: 220,
                                // ),
                                Text(
                                  'Parable Mind',
                                  style: GoogleFonts.jost(fontSize: 145, fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            );
                          }
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          const SizedBox(height: 50),
                          // Container(
                          //   padding: const EdgeInsets.symmetric(horizontal: 100),
                          //   alignment: Alignment.topRight,
                          //   child: const LanguageDropdown(),
                          // ),
                          Expanded(
                            child: Center(
                              child: BlocBuilder<PhoneNumberFormCubit, PhoneNumberFormState>(
                                builder: (context, state) {
                                  return Container(
                                    width: 750,
                                    height: 550,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: (state as PhoneNumberForm).isPhoneInputOpen
                                        ? const PhoneNumberFormDesktop()
                                        : const SignInOptionsDesktop(),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
