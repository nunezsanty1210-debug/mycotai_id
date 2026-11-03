import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/student.dart';
import 'package:flutter/services.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({super.key});

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final carnetController = TextEditingController();
  String? selectedSection;
  int permissions = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Estudiante'),
        backgroundColor: const Color(0xFF1B5E20),
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Nombre completo',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              validator: (v) => v == null || v.isEmpty ? 'Requerido' : null,
              textCapitalization: TextCapitalization.characters,
            ),
            const SizedBox(height: 16),
            TextFormField(
                controller: carnetController,
                decoration: const InputDecoration(
                  labelText: 'Número de carnet',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.numbers),
                  helperText: 'Formato: X-XXXX-XXXX',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CarnetInputFormatter(), // ← Formateador personalizado
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Requerido';
                  }
                  // Quitar los guiones para validar la cantidad de dígitos
                  final digits = value.replaceAll('-', '');
                  if (digits.length != 9) {
                    return 'Debe tener 9 dígitos (X-XXXX-XXXX)';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
              value: selectedSection,
              decoration: const InputDecoration(
                labelText: 'Sección',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.class_),
              ),
              borderRadius: BorderRadius.circular(12),
              menuMaxHeight: 300,
              items: const [
                DropdownMenuItem(value: 'SÉPTIMO 7-1', child: Text('SÉPTIMO 7-1')),
                DropdownMenuItem(value: 'SÉPTIMO 7-2', child: Text('SÉPTIMO 7-2')),
                DropdownMenuItem(value: 'SÉPTIMO 7-3', child: Text('SÉPTIMO 7-3')),
                DropdownMenuItem(value: 'OCTAVO 8-1', child: Text('OCTAVO 8-1')),
                DropdownMenuItem(value: 'OCTAVO 8-2', child: Text('OCTAVO 8-2')),
                DropdownMenuItem(value: 'OCTAVO 8-3', child: Text('OCTAVO 8-3')),
                DropdownMenuItem(value: 'NOVENO 9-1', child: Text('NOVENO 9-1')),
                DropdownMenuItem(value: 'NOVENO 9-2', child: Text('NOVENO 9-2')),
                DropdownMenuItem(value: 'NOVENO 9-3', child: Text('NOVENO 9-3')),
                DropdownMenuItem(value: 'DÉCIMO 10-1', child: Text('DÉCIMO 10-1')),
                DropdownMenuItem(value: 'DÉCIMO 10-2', child: Text('DÉCIMO 10-2')),
                DropdownMenuItem(value: 'DÉCIMO 10-3', child: Text('DÉCIMO 10-3')),
                DropdownMenuItem(value: 'UNDÉCIMO 11-1', child: Text('UNDÉCIMO 11-1')),
                DropdownMenuItem(value: 'UNDÉCIMO 11-2', child: Text('UNDÉCIMO 11-2')),
                DropdownMenuItem(value: 'UNDÉCIMO 11-3', child: Text('UNDÉCIMO 11-3')),
                DropdownMenuItem(value: 'DUODÉCIMO 12-1', child: Text('DUODÉCIMO 12-1')),
                DropdownMenuItem(value: 'DUODÉCIMO 12-2', child: Text('DUODÉCIMO 12-2')),
                DropdownMenuItem(value: 'DUODÉCIMO 12-3', child: Text('DUODÉCIMO 12-3')),
              ],
              onChanged: (value) {
                setState(() {
                  selectedSection = value;
                });
              },
              validator: (value) =>
                  value == null || value.isEmpty ? 'Seleccione una sección' : null 
              
            ),
            const SizedBox(height: 24),
            const Text('Estado de permisos:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 3, label: Text('Verde'), icon: Icon(Icons.check_circle)),
                ButtonSegment(value: 2, label: Text('Amarillo'), icon: Icon(Icons.warning)),
                ButtonSegment(value: 0, label: Text('Rojo'), icon: Icon(Icons.cancel)),
              ],
              selected: {permissions},
              onSelectionChanged: (s) => setState(() => permissions = s.first),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final student = Student(
                    id: const Uuid().v4(),
                    name: nameController.text.trim().toUpperCase(),
                    carnetNumber: carnetController.text.trim(),
                    section: selectedSection ?? '',
                    permissions: permissions,
                  );
                  Navigator.pop(context, student);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E7D32),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Guardar Carnet', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}

class CarnetInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Solo dejamos los números
    String digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // Limitamos a 9 dígitos
    if (digits.length > 9) {
      digits = digits.substring(0, 9);
    }

    // Construimos el formato X-XXXX-XXXX
    final buffer = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      buffer.write(digits[i]);
      if (i == 0 || i == 4) {
        if (i != digits.length - 1) {
          buffer.write('-');
        }
      }
    }

    final formatted = buffer.toString();

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}