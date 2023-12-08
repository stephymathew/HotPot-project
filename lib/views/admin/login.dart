import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hotpotproject/views/admin/LoginScreen.dart';
import 'package:hotpotproject/controller/firebase/auth/auth_service.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key});
  final TextEditingController _textcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: Text(
                    "Login ",
                    style: GoogleFonts.akatab(
                      textStyle:
                          const TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 350,
                    child: TextFormField(
                      controller: _textcontroller,
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
                      // onTap: () {
                      //   if (_formKey.currentState!.validate()) {
                      //     _formKey.currentState!.reset();
                      //   }
                      // },
                      onChanged: (value) {
                         _formKey.currentState!.validate();
                        // if (value.isNotEmpty) {
                        //   //_formKey.currentState!.reassemble();
                        // }
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
                      onChanged: (_) {
                        _formKey.currentState!.validate();
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 100),
                Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      height: 50,
                      width: 130,
                      // //decoration: BoxDecoration(color: Colors.white),
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const LoginhomeScreen(),
                                  ));
                            },
                            child: const Text(
                              "back",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          )),
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
                              Authservice.loginUser(_textcontroller.text.trim(),
                                  _passwordcontroller.text, context);
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
                            "Login",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ))
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
