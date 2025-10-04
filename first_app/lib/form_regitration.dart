import 'package:flutter/material.dart';

class FormRegistration extends StatefulWidget {
  const FormRegistration({super.key});

  @override
  State<FormRegistration> createState() => _FormRegistrationState();
}

class _FormRegistrationState extends State<FormRegistration> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // controllers
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  String? gender = 'Male';
  String? selectedProvince; // <- แก้สะกด
  bool isAccept = false;

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registration Form')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: fullNameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your Name";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your Email";
                  }
                  // ใส่เช็คอีเมลอย่างง่าย
                  final ok = RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(value);
                  if (!ok) return "Invalid email format";
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Gender
              Column(
                children: [
                  RadioListTile<String>(
                    value: 'Male',
                    title: const Text('Male'),
                    groupValue: gender,
                    onChanged: (value) => setState(() => gender = value),
                  ),
                  RadioListTile<String>(
                    value: 'Female',
                    title: const Text('Female'),
                    groupValue: gender,
                    onChanged: (value) => setState(() => gender = value),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Province
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Province'),
                value: selectedProvince,
                items: const ['Bangkok', 'Chiang Mai', 'Phuket']
                    .map((item) => DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        ))
                    .toList(),
                onChanged: (value) => setState(() => selectedProvince = value),
                validator: (value) =>
                    value == null ? "Please select Province" : null,
              ),
              const SizedBox(height: 12),

              // Consent
              CheckboxListTile(
                title: const Text("Accept Terms & Conditions"),
                value: isAccept,
                onChanged: (bool? value) =>
                    setState(() => isAccept = value ?? false),
                controlAffinity: ListTileControlAffinity.leading,
              ),
              const SizedBox(height: 8),

              ElevatedButton(
                onPressed: () {
                  if (!isAccept) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please accept Terms & Conditions'),
                      ),
                    );
                    return;
                  }
                  if (formKey.currentState!.validate()) {
                    // แทนที่จะ print อย่างเดียว ลองโชว์ผลลัพธ์
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Form submitted!')),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
