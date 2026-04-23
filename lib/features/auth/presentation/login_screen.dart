import 'package:flutter/material.dart';

import '../../../core/routes/route_names.dart';
import '../../../core/state/app_scope.dart';
import '../../../core/widgets/app_primary_button.dart';
import '../../../core/widgets/app_text_input.dart';
import '../widgets/auth_brand_logo.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;
  final TextEditingController _emailController = TextEditingController(
    text: 'aswin@gmail.com',
  );
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signIn() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || !email.contains('@') || password.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enter a valid email and password to continue.'),
        ),
      );
      return;
    }

    AppScope.of(context).logIn(email: email);
    Navigator.pushReplacementNamed(context, RouteNames.mainShell);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isWide = size.width >= 700;
    final horizontalPadding = isWide ? 40.0 : 28.0;
    final formWidth = isWide ? 420.0 : double.infinity;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final topSectionHeight = constraints.maxHeight * (isWide ? 0.42 : 0.38);

            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  children: [
                    Container(
                      height: topSectionHeight,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF222424),
                            Color(0xFF717574),
                          ],
                        ),
                      ),
                      child: const Center(
                        child: AuthBrandLogo(),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: formWidth),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                            horizontalPadding,
                            42,
                            horizontalPadding,
                            32,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome back',
                                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                      fontSize: isWide ? 38 : 25,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: -0.6,
                                      color: const Color(0xFF161616),
                                    ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'SIGN IN TO YOUR ACCOUNT',
                                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                      color: const Color(0xFF666666),
                                      letterSpacing: 1.9,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              const SizedBox(height: 38),
                              AppTextInput(
                                label: 'Email Address',
                                hintText: 'name@example.com',
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                              ),
                              const SizedBox(height: 28),
                              AppTextInput(
                                label: 'Password',
                                hintText: '********',
                                controller: _passwordController,
                                obscureText: _obscurePassword,
                                textInputAction: TextInputAction.done,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    size: 18,
                                    color: const Color(0xFF6F6F6F),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              Center(
                                child: TextButton(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Forgot password flow will be added later.'),
                                      ),
                                    );
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: const Color(0xFF666666),
                                    padding: EdgeInsets.zero,
                                    textStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                                          letterSpacing: 1.5,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                  child: const Text('FORGOT PASSWORD?'),
                                ),
                              ),
                              const SizedBox(height: 22),
                              AppPrimaryButton(
                                label: 'Sign In',
                                onPressed: _signIn,
                              ),
                              const SizedBox(height: 18),
                              Center(
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Text(
                                      "DON'T HAVE AN ACCOUNT? ",
                                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                            color: const Color(0xFF666666),
                                            letterSpacing: 1.3,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(context, RouteNames.register);
                                      },
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.black,
                                        minimumSize: Size.zero,
                                        padding: const EdgeInsets.symmetric(horizontal: 2),
                                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        textStyle:
                                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                                  fontWeight: FontWeight.w700,
                                                  letterSpacing: 1.3,
                                                  decoration: TextDecoration.underline,
                                                  decorationThickness: 1.1,
                                                ),
                                      ),
                                      child: const Text('REGISTER'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
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
