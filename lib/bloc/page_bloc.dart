import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:kridafighter/models/models.dart';

part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  PageBloc()
      : super(
          OnInitialPage(),
        ) {

    on<PageEvent>(mapEventToState);
  }

  @override
  void mapEventToState(
      PageEvent event, Emitter<PageState> emit) async {
    if (event is GoToSplashPage) {
      emit(OnSplashPage());
    } else if (event is GoToLoginPage) {
      emit(OnLoginPage());
    } else if (event is GoToSignUpPage) {
      emit(OnSignUpPage());
    } else if (event is GoToRegistrationPage) {
      emit(OnRegistrationPage(event.registrationData));
    } else if (event is GoToPreferencePage) {
      emit(OnPreferencePage(event.registrationData));
    } else if (event is GoToAccountConfirmationPage) {
      emit(OnAccountConfirmationPage(event.registrationData));
    } else if (event is GoToMenuPage) {
      emit(OnMenuPage());
    } else if (event is GoToProfileScreen) {
      emit(OnProfileScreen());
    } else if (event is GoToEditProfilePage) {
      emit(OnEditProfilePage(event.user));
    }
  }
}
