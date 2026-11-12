import 'package:fit_back/core/storage/local_storage_service.dart';
import 'package:fit_back/features/auth/screens/login_screen.dart';
import 'package:fit_back/features/workouts/models/workout_model.dart';
import 'package:fit_back/features/workouts/screens/add_workout_screen.dart';
import 'package:fit_back/features/workouts/services/local_workout_service.dart';
import 'package:flutter/material.dart';
import 'package:fit_back/features/workouts/screens/edit_workout_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LocalWorkoutService _dbService = LocalWorkoutService();

  List<WorkoutModel> _workouts = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadWorkouts();
  }

  Future<void> _loadWorkouts() async {
    setState(() {
      _isLoading = true;
    });

    final workouts = await _dbService.getWorkouts();

    if (!mounted) return;

    setState(() {
      _workouts = workouts;
      _isLoading = false;
    });
  }

  // void _showAddWorkoutDialog() {
  //   final titleController = TextEditingController();
  //   final categoryController = TextEditingController();
  //   final durationMinutesController = TextEditingController();

  //   showDialog(
  //     context: context,
  //     builder: (dialogContext) => AlertDialog(
  //       title: const Text('Nueva Rutina'),
  //       content: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           TextField(
  //             controller: titleController,
  //             decoration: const InputDecoration(labelText: 'Nombre'),
  //           ),
  //           TextField(
  //             controller: categoryController,
  //             decoration: const InputDecoration(labelText: 'Categoría'),
  //           ),
  //           TextField(
  //             controller: durationMinutesController,
  //             decoration: const InputDecoration(labelText: 'Duración (minutos)'),
  //             keyboardType: TextInputType.number,
  //           ),
  //         ],
  //       ),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.pop(dialogContext),
  //           child: const Text('Cancelar'),
  //         ),
  //         ElevatedButton(
  //           onPressed: () async {
  //             final title = titleController.text.trim();
  //             final category = categoryController.text.trim();
  //             final duration = int.tryParse(durationMinutesController.text.trim());

  //             if (title.isEmpty || category.isEmpty || duration == null) {
  //               return;
  //             }

  //             await _dbService.insertWorkout(
  //               WorkoutModel(
  //                 title: title,
  //                 category: category,
  //                 durationMinutes: duration,
  //               ),
  //             );

  //             if (!dialogContext.mounted) return;

  //             Navigator.pop(dialogContext);
  //             _loadWorkouts();
  //           },
  //           child: const Text('Guardar'),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Future <void> _navigateToAddWorkoutScreen() async {
    final newWorkout = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddWorkoutScreen()),
    );

    if (newWorkout != null && newWorkout is WorkoutModel) {
     await _dbService.insertWorkout(newWorkout);
      _loadWorkouts();

      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Rutina agregada: ${newWorkout.title}')),
        );
      }

    }
  }

  Future<void> _navigateToEditWorkoutScreen(WorkoutModel workout) async {
  final updatedWorkout = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => EditWorkoutScreen(workout: workout),
    ),
  );

  if (updatedWorkout != null && updatedWorkout is WorkoutModel) {
    await _dbService.updateWorkout(updatedWorkout);
    _loadWorkouts();
  }
}


  Future<void> _deleteWorkout(int id, String title) async {
    await _dbService.deleteWorkout(id);

    if (!mounted) return;

    _loadWorkouts();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Rutina eliminada: $title')),
    );
  }


  // Future<void> _updateWorkout(WorkoutModel workout) async {
  //   await _dbService.updateWorkout(workout);

  //   if (!mounted){
  //     return;
  //   } 

  //   _loadWorkouts();
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(content: Text('Rutina actualizada: ${workout.title}')),
  //   );
  // }


//   Future <void> _showEditWorkoutDialog(WorkoutModel workout) async {
//     final titleController = TextEditingController(text: workout.title);
//     final categoryController = TextEditingController(text: workout.category);
//     final durationMinutesController = TextEditingController(text: workout.durationMinutes.toString());

   
  
//     showDialog(
//       context: context,
//       builder: (dialogContext) => AlertDialog(
//         title: const Text('Editar Rutina'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: titleController,
//               decoration: const InputDecoration(labelText: 'Nombre'),
//             ),
//             TextField(
//               controller: categoryController,
//               decoration: const InputDecoration(labelText: 'Categoría'),
//             ),
//             TextField(
//               controller: durationMinutesController,
//               decoration: const InputDecoration(labelText: 'Duración (minutos)'),
//               keyboardType: TextInputType.number,
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(dialogContext),
//             child: const Text('Cancelar'),
//           ),
//           ElevatedButton(
//             onPressed: () async {
//               final title = titleController.text.trim();
//               final category = categoryController.text.trim();
//               final duration = int.tryParse(durationMinutesController.text.trim());

//               if (title.isEmpty || category.isEmpty || duration == null) {
//                 return;
//               }

//               await _dbService.updateWorkout(
//   WorkoutModel(
//     localId: workout.localId,
//     title: title,
//     category: category,
//     durationMinutes: duration,
//   ),
// );

// if (!dialogContext.mounted) return;

// Navigator.pop(dialogContext);
// _loadWorkouts();
//             },
//             child: const Text('Actualizar'),
//           ),
//         ],
//       ),
//     );
//   }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis entrenamientos'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon : Icon (Icons.logout),
            onPressed: () {
              showDialog(
                context:context,
                builder: (context) => AlertDialog(
                title : Text("Cerrar sesión"),
                content: Text("¿Estás seguro de que deseas cerrar sesión?"),
                actions: [
                  TextButton(
                  onPressed:() => Navigator.pop(context),
                  child: Text("Cancelar"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _logout();
                    },
                    child: Text("Cerrar sesión"),
                  ),
                
                ],
                )

              );
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _workouts.isEmpty
              ? const Center(child: Text('No tienes rutinas creadas'))
              : ListView.builder(
                  itemCount: _workouts.length,
                  itemBuilder: (context, index) {
                    final workout = _workouts[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: ListTile(
                        leading: const CircleAvatar(
                          child: Icon(Icons.fitness_center),
                        ),
                        title: Text(
                          workout.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          '${workout.category} - ${workout.durationMinutes} min',
                        ),
                        trailing: 
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                          onPressed: () =>
                              _deleteWorkout(workout.localId!, workout.title),
                          icon: const Icon(Icons.delete, color: Colors.red),
                          ),
                          IconButton(
                          onPressed: () =>
          
                              _navigateToEditWorkoutScreen(workout),
                              icon: Icon(Icons.edit_attributes, color: Colors.blueAccent)
                        ),
                            
                          ]
            

                        )
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddWorkoutScreen,
        child: const Icon(Icons.add),
      ),
    );
  }


  void _logout() async {
    final storage = LocalStorageService();
    await storage.deleteToken();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (Route<dynamic> route) => false,
    );
  }
}