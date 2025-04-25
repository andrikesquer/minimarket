import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pos2/core/encryption/secure_storage.dart';
import 'package:pos2/domain/repositories/login_repository.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  LoginWidgetState createState() => LoginWidgetState();
}

class LoginWidgetState extends State<LoginWidget> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController loginEmailController = TextEditingController();

  TextEditingController loginPasswordController = TextEditingController();

  final FocusNode focusNodeEmail = FocusNode();

  final FocusNode focusNodePassword = FocusNode();

  bool _obscureTextPassword = true;

  bool isLoading = false;

  final loginRepo = LoginRepository();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    focusNodeEmail.dispose();
    focusNodePassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Text("Inicio de Sesión"),
            TextFormField(
              focusNode: focusNodeEmail,
              controller: loginEmailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                icon: Icon(Icons.email),
                hintText: 'Email',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese un email, por favor';
                }
                return null;
              },
              onFieldSubmitted: (_) {
                focusNodePassword.requestFocus();
              },
            ),
            TextFormField(
              focusNode: focusNodePassword,
              controller: loginPasswordController,
              obscureText: _obscureTextPassword,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                icon: Icon(Icons.lock),
                hintText: 'Contraseña',
                suffixIcon: GestureDetector(
                  onTap: _togglePassVisibility,
                  child: Icon(
                    _obscureTextPassword ? Icons.remove_red_eye : Icons.block,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese su contraseña, por favor';
                }
                return null;
              },
              onFieldSubmitted: (_) {
                _toggleLogin();
              },
              textInputAction: TextInputAction.go,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () {
                  _toggleLogin();
                },
                child: const Text('Iniciar Sesión'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _togglePassVisibility() {
    setState(() {
      _obscureTextPassword = !_obscureTextPassword;
    });
  }

  void _toggleLogin() async {
    setState(() {
      isLoading = true;
    });

    String email = loginEmailController.text.trim();
    String password = loginPasswordController.text.trim();

    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: const Text('Iniciando Sesión'), backgroundColor: Colors.green[600]));

      try {
        final response = await loginRepo.login(email, password);
        if (response.Success) {
          debugPrint(
            "Login exitoso de ${response.Email}, IdSubscription: ${response.IdSubscription}",
          );
          UserCredentials.saveCredentials(
            response.Email,
            response.IdSubscription,
          );
          context.go('/${response.Email}');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Credenciales incorrectas')),
          );
          debugPrint("Credenciales incorrectas");
        }
      } catch (e) {
        debugPrint("Error: ${e.toString()}");
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error al procesar solicitud')));
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }
}
