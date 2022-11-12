part of 'pages.dart';

class Wrapper extends StatefulWidget {

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    
     auth.User? firebaseUser = Provider.of<auth.User?>(context);

    if (firebaseUser == null) {
      if (!(prevPageEvent is GoToSplashPage)) {
        prevPageEvent = GoToSplashPage();
        context.read<PageBloc>().add(prevPageEvent!);
      }
    } else {
      if (!(prevPageEvent is GoToMenuPage)) {
        context.read<UserBloc>().add(LoadUser(firebaseUser.uid)); 
        print("aaaaaaaaaaaaaa ${firebaseUser.uid}");

        prevPageEvent = GoToMenuPage();
        context.read<PageBloc>().add(prevPageEvent!);
      }
    }

return BlocBuilder<PageBloc, PageState>(
        builder: (_, pageState) => (pageState is OnSplashPage)
          
         ? SplashPage()
            : (pageState is OnLoginPage)
                ? SignInPage()
                : (pageState is OnMenuPage)
                    ? MenuPage()
                    : (pageState is OnEditProfilePage)
                        ? EditProfilePage(pageState.user)
                        : MenuPage()
            );
  }
}
