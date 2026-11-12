
import 'package:fit_back/features/workouts/models/workout_model.dart';
import 'package:flutter/material.dart';

class EditWorkoutScreen extends StatefulWidget {
  final WorkoutModel workout;

  const EditWorkoutScreen({
    super.key,
    required this.workout,
  });

  @override
  State<EditWorkoutScreen> createState() => _EditWorkoutScreenState();
}

class _EditWorkoutScreenState extends State<EditWorkoutScreen> {
final _formKey = GlobalKey<FormState>();

late final TextEditingController _titleController;
late final TextEditingController _durationController;

String _selectedCategory = 'Fuerza';

final List<String> _categories = [
  'Fuerza',
  'Cardio',
  'Flexibilidad',
  'Pierna',
  'Pecho',
  'Espalda',
  'Bíceps',
  'Core'
];

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController(
      text: widget.workout.title,
    );

    _durationController = TextEditingController(
      text: widget.workout.durationMinutes.toString(),
    );

    _selectedCategory = _categories.contains(widget.workout.category)
    ? widget.workout.category
    : _categories.first;
  }

  void _updateWorkout() {
    if (_formKey.currentState!.validate()) {
      final updatedWorkout = WorkoutModel(
        localId: widget.workout.localId,
        title: _titleController.text,
        category: _selectedCategory,
        durationMinutes: int.parse(_durationController.text),
      );

      Navigator.pop(context, updatedWorkout);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Entrenamiento'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Titulo',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.title),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor ingrese nombre';
                  }
                  if (value.length < 3) {
                    return 'El nombre debe tener al menos 3 caracteres';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              DropdownButtonFormField<String>(
                initialValue: _selectedCategory,
                decoration: InputDecoration(
                  labelText: 'Categoria',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.category),
                ),
                items: _categories.map((String category) {
                  return DropdownMenuItem<String>(
                    child: Text(category),
                    value: category,
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue!;
                  });
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _durationController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Duración (minutos)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.timer),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese los minutos';
                  }

                  if (int.tryParse(value) == null) {
                    return 'Solo valores numericos';
                  }
                  return null;
                },
              ),
              Spacer(),
              ElevatedButton(
                onPressed: _updateWorkout,
                child: Text(
                  'Actualizar Rutina',
                  style: TextStyle(fontSize: 18.0),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
