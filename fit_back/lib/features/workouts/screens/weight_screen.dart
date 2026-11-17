import 'package:fit_back/features/workouts/models/weight_model.dart';
import 'package:fit_back/features/workouts/screens/add_weight_screen.dart';
import 'package:flutter/material.dart';

class WeightScreen extends StatefulWidget {

  const WeightScreen({super.key});

  @override
  State<WeightScreen> createState() => _WeightScreenState();

}

class _WeightScreenState extends State<WeightScreen> {
  List<WeightModel> registros = [];

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Registro de peso'),
    ),
    body: registros.isEmpty
        ? Center(child: Text('No hay registros'))
        : ListView.builder(
            itemCount: registros.length,
            itemBuilder: (context, index) {
              final registro = registros[index];
              return Card(
                child: ListTile(
                  title: Text(registro.fecha),
                  subtitle: Text('${registro.pesoKilos} kg'),
                ),
              );
            },
          ),
    floatingActionButton: FloatingActionButton(
      onPressed: () async {
        final newWeight = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddWeightScreen()),
        );

        if (newWeight != null && newWeight is WeightModel) {
          setState(() {
            registros.add(newWeight);
          });
        }
      },
      child: Icon(Icons.add),
    ),
  );
}

}