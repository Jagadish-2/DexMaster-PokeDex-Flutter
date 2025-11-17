import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/Screens/login_screen.dart';
import 'package:pokedex/utils/context_extension.dart';

import '../riverpod/auth_pod.dart';
import '../widgets/custom_formfield.dart';

class ForgotPassword extends ConsumerWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController _forgotPassController = TextEditingController();
    final authNotifier = ref.watch(authProvider);
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Image.asset('assets/images/new_loginscreen.png'),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(70),
                            child: Image.asset(
                              'assets/New_Logo.png',
                              width: constraints.maxWidth * 0.5,
                              height: constraints.maxHeight * 0.15,
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Enter Email to send you a password reset Link to your Email",
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.redAccent),
                          ),
                          const SizedBox(height: 20),
                          CustomFormField(
                            controller: _forgotPassController,
                            hintText: 'Enter Email',
                            obscureText: false,
                            iconsType: Icons.email,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 20),
                          authNotifier.isLoading
                              ? const Center(
                            child: SizedBox(
                              height: 50,
                              width: 50,
                              child: CircularProgressIndicator(),
                            ),
                          )
                              :
                              InkWell(
                                child:Container(
                                  height: 50,
                                  width: MediaQuery.sizeOf(context).width * 0.9,
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Send Rest Link',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                onTap: () async {
                                  FocusScope.of(context).unfocus();
                                  FocusScope.of(context).unfocus();
                                  if (_forgotPassController.text.isEmpty) {
                                    return;
                                  } else {
                                    await authNotifier.sendPasswordResetLink(
                                        _forgotPassController.text);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Container(
                                          padding: const EdgeInsets.all(1),
                                          height: 50,
                                          width: MediaQuery.of(context).size.width,
                                          decoration: const BoxDecoration(
                                            color: Colors.lightGreen,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                          child: const Row(
                                            children: [
                                              SizedBox(width: 8),
                                              Icon(
                                                Icons.done,
                                                color: Colors.white,
                                                size: 35,
                                              ),
                                              SizedBox(width: 8),
                                              Expanded(
                                                child: Center(
                                                  child: Text(
                                                    'An email for password reset has been sent to your mail',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.lightGreen
                                      ),
                                    );
                                    Navigator.pop(context);
                                  }
                                },
                              ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: GestureDetector(
                              child: RichText(
                                text: const TextSpan(
                                  text: 'Go back to ? ',
                                  // Regular text
                                  style: TextStyle(color: Colors.black),
                                  // Default style
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Login Page Instead',
                                      // Text to be styled differently
                                      style: TextStyle(
                                        color: Colors.deepPurple,
                                        // Different color for 'Login Instead'
                                        fontWeight: FontWeight.bold,
                                        // Bold font weight for emphasis
                                        decoration: TextDecoration
                                            .underline, // Underline to indicate a link
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                context.navigateToScreen(
                                    isReplace: true, child: LoginScreen());
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
