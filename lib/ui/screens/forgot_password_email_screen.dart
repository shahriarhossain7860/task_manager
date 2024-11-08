import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/widget/snack_bar_message.dart';

import '../../utils/app_colors.dart';
import '../../widget/screen_background.dart';
import 'forgot_password_otp_screen.dart';

class ForgotPasswordEmailScreen extends StatefulWidget {
  static const String name = '/forgotPasswordEmail';

  const ForgotPasswordEmailScreen({super.key});

  @override
  State<ForgotPasswordEmailScreen> createState() =>
      _ForgotPasswordEmailScreenState();
}

class _ForgotPasswordEmailScreenState extends State<ForgotPasswordEmailScreen> {
  final TextEditingController _emailVerifyController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _inProgress = false;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 82),
                Text(
                  'Your Email Address',
                  style: textTheme.displaySmall
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Text(
                  'A 6 digits verification otp will be sent to your email address',
                  style: textTheme.titleSmall?.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 24),
                _buildVerifyEmailForm(),
                const SizedBox(height: 48),
                Center(
                  child: _buildHaveAccountSection(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVerifyEmailForm() {
    return Form(
      key: _formkey, // Assign form key here
      child: Column(
        children: [
          TextFormField(
            controller: _emailVerifyController, // Attach controller here
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: 'Email'),
            validator: (value) {
              if (value == null || value.isEmpty || !value.contains('@')) {
                return 'Enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _onTapNextButton,
            child: const Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }

  Widget _buildHaveAccountSection() {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 14,
            letterSpacing: 0.5),
        text: "Have account? ",
        children: [
          TextSpan(
              text: 'Sign In',
              style: const TextStyle(color: AppColors.themeColor),
              recognizer: TapGestureRecognizer()..onTap = _onTapSignIn),
        ],
      ),
    );
  }

  void _onTapNextButton() {
    if (_formkey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ForgotPasswordOtpScreen(),
        ),
      );
      getEmailRecovery();
    } else {
      showSnackBarMessage(context, 'Enter a valid email');
    }
  }

  void _onTapSignIn() {
    Navigator.pop(context);
  }

  void _cleartextfield() {
    _emailVerifyController.clear();
  }

  Future<void> getEmailRecovery() async {
    _inProgress = true;
    setState(() {});
    final NetworkResponse response = await NetworkCaller.getRequest(
      url: '${Urls.verifyRecoverEmail}/${_emailVerifyController.text}',
    );
    _inProgress = false;
    setState(() {});
    if (response.isSuccess) {
      _cleartextfield();
      setState(() {});

      showSnackBarMessage(context, 'OTP Sent');
    } else {
      showSnackBarMessage(context, response.errorMessage);
    }
  }
}
