import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:form_mobx/form/form_store.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Form'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final validation = FormStore();

    @override
    void initState() {
      super.initState();
      validation.setupValidations();
    }

    @override
    void dispose() {
      validation.dispose();
      super.dispose();
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Observer(
              builder: (context) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      onChanged: ((value) {
                        validation.setUsername(value.toString());
                      }),
                      controller: _userNameController,
                      decoration: InputDecoration(
                          errorText: validation.error.username,
                          labelText: 'Username',
                          contentPadding: const EdgeInsets.all(8)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      onChanged: ((value) {
                        validation.setEmail(value.toString());
                      }),
                      controller: _emailController,
                      decoration: InputDecoration(
                          errorText: validation.error.email,
                          labelText: 'Email',
                          contentPadding: const EdgeInsets.all(8)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      onChanged: ((value) {
                        validation.setPassword(value.toString());
                      }),
                      controller: _passwordNameController,
                      decoration: InputDecoration(
                          errorText: validation.error.password,
                          labelText: 'Password',
                          contentPadding: const EdgeInsets.all(8)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: (() {
                          validation.validateAll();
                        }),
                        child: const Text("Sign Up"))
                  ],
                );
              },
            )),
      ),
    );
  }
}
