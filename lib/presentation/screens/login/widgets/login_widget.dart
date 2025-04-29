import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pos2/domain/repositories/login_repository.dart';
import 'package:pos2/presentation/providers/session_provider.dart';

class LoginWidget extends ConsumerStatefulWidget {
  const LoginWidget({super.key});

  @override
  ConsumerState createState() => LoginWidgetState();
}

class LoginWidgetState extends ConsumerState<LoginWidget> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController loginEmailController = TextEditingController();

  TextEditingController loginPasswordController = TextEditingController();

  final FocusNode focusNodeEmail = FocusNode();

  final FocusNode focusNodePassword = FocusNode();

  bool _obscureTextPassword = true;

  final LoginRepository loginRepository = LoginRepository();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    loginEmailController.dispose();
    loginPasswordController.dispose();
    focusNodeEmail.dispose();
    focusNodePassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text(
            "Inicio de Sesión",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 20),
          TextFormField(
            focusNode: focusNodeEmail,
            controller: loginEmailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.email_outlined),
              hintText: 'Email',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Ingrese un email, por favor';
              }
              return null;
            },
            onFieldSubmitted: (String _) {
              focusNodePassword.requestFocus();
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            focusNode: focusNodePassword,
            controller: loginPasswordController,
            obscureText: _obscureTextPassword,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.lock_outline),
              hintText: 'Contraseña',
              suffixIcon: GestureDetector(
                onTap: _togglePassVisibility,
                child: Icon(
                  _obscureTextPassword
                      ? Icons.remove_red_eye_outlined
                      : Icons.remove_red_eye,
                ),
              ),
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Ingrese su contraseña, por favor';
              }
              return null;
            },
            onFieldSubmitted: (String _) {
              _toggleLogin();
            },
            textInputAction: TextInputAction.go,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _toggleLogin();
            },
            child: const Text('Iniciar Sesión'),
          ),
        ],
      ),
    );
  }

  void _togglePassVisibility() {
    setState(() {
      _obscureTextPassword = !_obscureTextPassword;
    });
  }

  void _toggleLogin() async {
    String email = loginEmailController.text.trim();
    String password = loginPasswordController.text.trim();

    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Iniciando Sesión'),
          backgroundColor: Colors.green[600],
        ),
      );

      try {
        final response = await loginRepository.login(email, password);
        if (response.Success) {
          ref
              .read(sessionProvider.notifier)
              .login(response.Email, response.IdSubscription);
          context.go('/${response.Email}');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Credenciales incorrectas')),
          );
        }
      } catch (e) {
        debugPrint("Error: ${e.toString()}");
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error al procesar solicitud')));
      }
    }
  }
}
