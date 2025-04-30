import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms_app/src/presentation/blocs/counter_cubit/counter_cubit.dart';

class CubitCounterScreen extends StatelessWidget {
  const CubitCounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterCubit(),
      child: _CubitCounterView(),
    );
  }
}

class _CubitCounterView extends StatelessWidget {
  const _CubitCounterView();

  @override
  Widget build(BuildContext context) {
    final counterMethods = context.read<CounterCubit>();

    return Scaffold(
      appBar: AppBar(
        title: context.select(
          (CounterCubit value) =>
              Text('Cubit Counter: ${value.state.transactionCount}'),
        ),
        actions: [
          IconButton(
            onPressed: () => counterMethods.reset(),
            icon: const Icon(Icons.refresh_outlined),
          ),
        ],
      ),
      body: Center(
        child: context.select(
          (CounterCubit value) => Text('Counter value: ${value.state.counter}'),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => counterMethods.increaseBy(1),
            heroTag: '1',
            child: const Text('+1'),
          ),
          const SizedBox(height: 15.0),
          FloatingActionButton(
            onPressed: () => counterMethods.increaseBy(2),
            heroTag: '2',
            child: const Text('+2'),
          ),
          const SizedBox(height: 15.0),
          FloatingActionButton(
            onPressed: () => counterMethods.increaseBy(3),
            heroTag: '3',
            child: const Text('+3'),
          ),
        ],
      ),
    );
  }
}
