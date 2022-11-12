part of 'pages.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool shouldPop = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _key = GlobalKey<FormState>();

  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    Widget _header() {
      return Container(
        margin: EdgeInsets.only(bottom: 70),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Login",
              style: whiteTextStyle.copyWith(
                fontSize: 24,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              "Sign In to Countinue",
              style: greyTextStyle.copyWith(
                fontSize: 14,
                fontWeight: regular,
              ),
            ),
          ],
        ),
      );
    }

    Widget _body() {
      return Container(
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Email Address",
                style: whiteTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                height: 50,
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: kBackgroundColor2,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icon-email.png',
                        width: 17,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: TextFormField(
                          onChanged: (text) {
                            setState(() {
                              isEmailValid = EmailValidator.validate(text);
                            });
                          },
                          style: whiteTextStyle,
                          controller: emailController,
                          decoration: InputDecoration.collapsed(
                            hintText: 'Your Email Address',
                            hintStyle: subtitleTextStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Password",
                style: whiteTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                height: 50,
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: kBackgroundColor2,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icon-password.png',
                        width: 17,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: TextFormField(
                          onChanged: (text) {
                            setState(() {
                              isPasswordValid = text.length >= 6;
                            });
                          },
                          style: whiteTextStyle,
                          obscureText: true,
                          controller: passwordController,
                          decoration: InputDecoration.collapsed(
                            hintText: 'Your Password',
                            hintStyle: subtitleTextStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget _button() {
      return Container(
          margin: EdgeInsets.only(top: defaultMargin),
          child: isSigningIn
              ? SpinKitFadingCircle(color: kGreenColor)
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric( vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    backgroundColor: kGreenColor,
                  ),
                  child: Text('Sign In',
                      style: whiteTextStyle.copyWith(
                          fontSize: 22, fontWeight: medium)),
                  onPressed: isEmailValid && isPasswordValid
                      ? () async {
                          setState(() {
                            isSigningIn = true;
                          });

                          SignInSignUpResult result = await AuthServices.signIn(
                              emailController.text, passwordController.text);

                          if (result.user == null) {
                            setState(() {
                              isSigningIn = false;
                            });

                            Flushbar(
                              duration: Duration(seconds: 4),
                              flushbarPosition: FlushbarPosition.TOP,
                              backgroundColor: Color(0xFFFF5C83),
                              message: result.message,
                            )..show(context);
                          }
                        }
                      : null));
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(
            defaultMargin,
          ),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              _header(),
              _body(),
              _button(),
            ],
          ),
        ),
      ),
    );
  }
}
