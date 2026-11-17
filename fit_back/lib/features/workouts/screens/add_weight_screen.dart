import 'package:fit_back/features/workouts/models/weight_model.dart';

import 'package:flutter/material.dart';

class AddWeightScreen extends StatefulWidget {
  const AddWeightScreen({super.key});

  @override
  State<AddWeightScreen> createState() => _AddWeightScreenState();
}

class _AddWeightScreenState extends State<AddWeightScreen> {
  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final _weigthController = TextEditingController();


  void _addWeigth() {
  if (_formKey.currentState!.validate()) {
    final addWeight = WeightModel(
      fecha: _dateController.text,
      pesoKilos: double.parse(_weigthController.text),
    );
    Navigator.pop(context, addWeight);
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Nuevo dato de peso'),
      ),
      body: Padding(
        padding:  EdgeInsets.all(20),
        child: Form(
        key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // fcha 
          TextFormField(
            controller: _dateController,
            keyboardType: TextInputType.datetime,
            decoration:  InputDecoration(
            labelText: 'Fecha'
          ),
          validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'La fecha no puede estar vacía';
          }
          return null;
        },
      ),
      // peso 
      TextFormField(
        controller: _weigthController,
        keyboardType: TextInputType.number,
            decoration:  InputDecoration(
            labelText: 'Peso en kilos'
          ),

          validator: (value) {
            if(value == null || value.isEmpty){
              return 'Ingrese el peso';
            }
                  
            if(double.tryParse(value) == null ) {
              return 'peso solo en valores numericos';
            }

            if(double.parse(value) <= 0){
              return 'solo valores positivos';
            }
          return null;
        },
      ),
      ElevatedButton(
        onPressed: _addWeigth,
        child:  Text('Guardar nuevo peso'),
      ),
      
    ],
  ),
),
      ),
    );
  }




}

