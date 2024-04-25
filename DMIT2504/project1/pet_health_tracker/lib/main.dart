import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Health Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const PetHealthTrackerHome(title: 'Pet Health Tracker'),
    );
  }
}

class PetHealthTrackerHome extends StatefulWidget {
  const PetHealthTrackerHome({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<PetHealthTrackerHome> createState() => _PetHealthTrackerHomeState();
}

class _PetHealthTrackerHomeState extends State<PetHealthTrackerHome> {
  List<PetProfile> pets = [];
  final TextEditingController petNameController = TextEditingController();
  final TextEditingController breedController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  void _addPetProfile() {
    if (petNameController.text.isNotEmpty &&
        breedController.text.isNotEmpty &&
        ageController.text.isNotEmpty &&
        weightController.text.isNotEmpty) {
      setState(() {
        pets.add(PetProfile(
          name: petNameController.text,
          breed: breedController.text,
          age: int.tryParse(ageController.text) ?? 0,
          weight: double.tryParse(weightController.text) ?? 0.0,
          appointments: [],
          activityLogs: [],
        ));
        petNameController.clear();
        breedController.clear();
        ageController.clear();
        weightController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: petNameController,
              decoration: const InputDecoration(
                labelText: 'Pet\'s Name',
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: breedController,
              decoration: const InputDecoration(
                labelText: 'Breed',
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: ageController,
              decoration: const InputDecoration(
                labelText: 'Age',
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: weightController,
              decoration: const InputDecoration(
                labelText: 'Weight (kg)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: _addPetProfile,
              child: const Text('Add Pet Profile'),
            ),
            ...pets.map((pet) => PetAppointmentTile(pet: pet)).toList(),
          ],
        ),
      ),
    );
  }
}

class PetAppointmentTile extends StatefulWidget {
  final PetProfile pet;

  const PetAppointmentTile({Key? key, required this.pet}) : super(key: key);

  @override
  _PetAppointmentTileState createState() => _PetAppointmentTileState();
}

class _PetAppointmentTileState extends State<PetAppointmentTile> {
  final TextEditingController appointmentController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        dateController.text = "${picked.year}-${picked.month}-${picked.day}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Text(widget.pet.name),
        subtitle: Text(
            'Breed: ${widget.pet.breed} - Age: ${widget.pet.age} years - Weight: ${widget.pet.weight} kg'),
        children: <Widget>[
          ...widget.pet.appointments.map(
            (appointment) => ListTile(
              title: Text(appointment),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: appointmentController,
              decoration: const InputDecoration(
                labelText: 'Enter Appointment Details',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: dateController,
              readOnly: true,
              onTap: () => _selectDate(context),
              decoration: const InputDecoration(
                labelText: 'Select Appointment Date',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (appointmentController.text.isNotEmpty &&
                  dateController.text.isNotEmpty) {
                setState(() {
                  widget.pet.appointments.add(
                      '${dateController.text}: ${appointmentController.text}');
                  appointmentController.clear();
                  dateController.clear();
                });
              }
            },
            child: const Text('Add Appointment'),
          ),
          ElevatedButton(
            onPressed: () {
              _editPetDetails(context);
            },
            child: const Text('Edit Pet Details'),
          ),
        ],
      ),
    );
  }

  Future<void> _editPetDetails(BuildContext context) async {
    final editedPet = await showDialog<PetProfile>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Pet Details'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: TextEditingController(text: widget.pet.name),
                  decoration: const InputDecoration(labelText: 'Pet\'s Name'),
                  onChanged: (value) => widget.pet.name = value,
                ),
                TextField(
                  controller: TextEditingController(text: widget.pet.breed),
                  decoration: const InputDecoration(labelText: 'Breed'),
                  onChanged: (value) => widget.pet.breed = value,
                ),
                TextField(
                  controller:
                      TextEditingController(text: widget.pet.age.toString()),
                  decoration: const InputDecoration(labelText: 'Age'),
                  onChanged: (value) =>
                      widget.pet.age = int.tryParse(value) ?? 0,
                ),
                TextField(
                  controller:
                      TextEditingController(text: widget.pet.weight.toString()),
                  decoration: const InputDecoration(labelText: 'Weight (kg)'),
                  onChanged: (value) =>
                      widget.pet.weight = double.tryParse(value) ?? 0.0,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(widget.pet);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
    if (editedPet != null) {
      setState(() {
        var pets;
        final index = pets.indexWhere((element) => element == widget.pet);
        if (index != -1) {
          pets[index] = editedPet;
        }
      });
    }
  }
}

class PetProfile {
  String name;
  String breed;
  int age;
  double weight;
  List<String> appointments;
  List<String> activityLogs;

  PetProfile({
    required this.name,
    required this.breed,
    required this.age,
    required this.weight,
    required this.appointments,
    required this.activityLogs,
  });
}
