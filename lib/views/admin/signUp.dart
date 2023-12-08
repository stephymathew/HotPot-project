import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hotpotproject/views/admin/login.dart';
import 'package:hotpotproject/controller/firebase/auth/auth_service.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key});

  final TextEditingController _textcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 20, 20, 20),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: Text(
                    "Sign up...",
                    style: GoogleFonts.akatab(
                      textStyle: const TextStyle(fontSize: 30),
                      color: Colors.white,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 350,
                    child: TextFormField(
                        controller: _textcontroller,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: "username",
                          hintStyle: GoogleFonts.alike(
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          fillColor: const Color.fromARGB(255, 204, 160, 17),
                          filled: true,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "enter a valid name";
                          } else {
                            return null;
                          }
                        }),
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 350,
                    child: TextFormField(
                      controller: _emailcontroller,
                      autocorrect: false,
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: "email",
                        hintStyle: GoogleFonts.alike(
                          textStyle: const TextStyle(fontSize: 20),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        fillColor: const Color.fromARGB(255, 204, 160, 17),
                        filled: true,
                      ),
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@gmail.com')) {
                          return 'please enter a valid email';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                      width: 350,
                      child: TextFormField(
                        controller: _passwordcontroller,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white.withOpacity(0.9)),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: "password",
                          hintStyle: GoogleFonts.alike(
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          fillColor: const Color.fromARGB(255, 204, 160, 17),
                          filled: true,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                        validator: (value) {
                          if (value!.length < 8) {
                            return "must contain 8 leters";
                          } else {
                            return null;
                          }
                        },
                      )),
                ),
                const SizedBox(height: 50),
                Row(
                  children: [
                    Container(
                      width: 20,
                    ),
                    SizedBox(
                      height: 50,
                      width: 130,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "back",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 100,
                    ),
                    SizedBox(
                      height: 50,
                      width: 130,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Authservice.signUser(
                                _emailcontroller.text.trim(),
                                _passwordcontroller.text,
                                _textcontroller.text,
                                context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ).copyWith(
                          backgroundColor:
                              MaterialStateProperty.resolveWith((states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.black;
                            }
                            return Colors.white;
                          }),
                        ),
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
