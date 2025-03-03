import 'package:flutter/material.dart';

class CreateNewHabit extends StatefulWidget {
  const CreateNewHabit({super.key});

  @override
  _CreateNewHabitState createState() => _CreateNewHabitState();
}

class _CreateNewHabitState extends State<CreateNewHabit> {
  final TextEditingController _habitController = TextEditingController();
  String _habitName = '';
  String? _selectFreq;
  final List<String> _frequencies = ['Every Day','Every 2 Days','Every week','Every 2 weeks','Every Month'];
  String? _selectDuration;
  final List<String> _durations = ['1 week','2 weeks','3 weeks','1 month','2 months','3 months','4 months','5 months','6 months','1 year'];
  


  void _saveHabit() {
    if (_habitName.isNotEmpty&& _selectFreq != null) {
      print('Habit saved: $_habitName with frequency: $_selectFreq');
      // Optionally clear the text field after saving
      _habitController.clear();
      setState(() {
        _habitName = '';
        _selectFreq = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Habit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _habitController,
              decoration: InputDecoration(labelText: 'Habit Name'),
              onChanged: (value) {
                setState(() {
                  _habitName = value;
                });
              },
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: _selectFreq,
              hint: Text('Select Frequency'),
              items: _frequencies.map((String frequency) {
                return DropdownMenuItem<String>(
                  value: frequency,
                  child: Text(frequency),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectFreq = newValue;
                });
              },
            ),
             SizedBox(height: 20),
            DropdownButton<String>(
              value: _selectDuration,
              hint: Text('How long do you want to do this habit for'),
              items: _durations.map((String durations) {
                return DropdownMenuItem<String>(
                  value: durations,
                  child: Text(durations),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectDuration = newValue;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveHabit,
              child: Text('Save Habit'),
            ),
          ],
        ),
      ),
    );
  }
}
