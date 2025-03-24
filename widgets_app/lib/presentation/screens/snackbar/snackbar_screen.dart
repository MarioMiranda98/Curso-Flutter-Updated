import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SnackbarScreen extends StatelessWidget {
  static const name = 'snackbar_screen';

  const SnackbarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snackbars y Dialogos'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton.tonal(
              onPressed: () {
                showAboutDialog(context: context, children: [
                  const Text(
                    'Nisi eu tempor duis irure mollit culpa tempor ut nostrud aliqua elit consequat dolor.',
                  ),
                ]);
              },
              child: const Text(
                'Licencias usadas',
              ),
            ),
            FilledButton.tonal(
              onPressed: () => _openDialog(context),
              child: const Text(
                'Mostrar diálogo',
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showSnackBar(context),
        label: const Text('Mostrar Snackbar'),
        icon: const Icon(
          Icons.remove_red_eye_outlined,
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: const Text('Hola mundo'),
      action: SnackBarAction(
        label: 'Ok!',
        onPressed: () {},
      ),
      duration: const Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _openDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('¿Estás seguro?'),
        content: const Text(
          '''
            Enim amet dolor occaecat qui tempor velit laborum nostrud ex commodo. 
            Ut amet sit excepteur sit adipisicing. Ex do mollit excepteur do dolor 
            Lorem sunt quis laborum aliqua sunt. Fugiat proident ut fugiat non
            reprehenderit Lorem magna nisi magna ad. Dolor nisi nisi anim duis minim 
            aliquip enim deserunt laboris eiusmod aliquip.
          ''',
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }
}
