import 'package:flutter/material.dart';
import 'package:student_app/tree/root/drawer_section/profile_database.dart';


class AccountManagePage extends StatefulWidget {
  const AccountManagePage({super.key});

  @override
  State<AccountManagePage> createState() => _AccountManagePageState();
}

class _AccountManagePageState extends State<AccountManagePage> {
  late Map<String, dynamic> userData;
  bool dataFetching = true;
  AccountDatabaseService database = AccountDatabaseService();

  bool isEditingName = false;
  bool isEditingEmail = false;

  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  void fetchHandle() async {
    userData = await database.fetchData();
    userData.forEach((key, value) {
      // ignore: avoid_print
      print('$key: $value');
    });
    setState(() {
      dataFetching = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchHandle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: const Text("Account Details"),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.green[700],
      ),
      body: dataFetching
      ? Center(
        child: CircularProgressIndicator(
          color: Colors.green[700],
        ),
      )
      : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildEditableField(
                label: "Name",
                value: userData['name'],
                isEditing: isEditingName,
                controller: nameController,
                textCapitalization: TextCapitalization.words,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Name cannot be empty";
                  }
                  return null;
                },
                onSave: (newValue) {
                  setState(() {
                    // name = newValue;
                    isEditingName = false;
                  });
                },
                onEdit: () {
                  setState(() {
                    isEditingName = true;
                    nameController.text = userData['name'];
                  });
                },
              ),

              const SizedBox(height: 16),

              _buildEditableField(
                label: "Email",
                value: userData['email'],
                isEditing: isEditingEmail,
                controller: emailController,
                textCapitalization: TextCapitalization.none,
                validator: (value) {
                  if (value == null || !value.contains("@")) {
                    return "Enter a valid email";
                  }
                  return null;
                },
                onSave: (newValue) {
                  setState(() {
                    // email = newValue;
                    isEditingEmail = false;
                  });
                },
                onEdit: () {
                  setState(() {
                    isEditingEmail = true;
                    emailController.text = userData['email'];
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditableField({
    required String label,
    required String value,
    required bool isEditing,
    required TextEditingController controller,
    required TextCapitalization textCapitalization,
    required String? Function(String?) validator,
    required void Function(String) onSave,
    required VoidCallback onEdit,
  }) {
    return Row(
      children: [
        Expanded(
          child: isEditing
            ? TextFormField(
              controller: controller,
              textCapitalization: textCapitalization,
              decoration: InputDecoration(
              border: const OutlineInputBorder(),
                labelText: label,
              ),
              validator: validator,
            )
            : Text(value, style: const TextStyle(fontSize: 18.0)),
        ),
        IconButton(
          icon: Icon(isEditing ? Icons.check : Icons.edit),
          onPressed: () {
            if (isEditing) {
              if (_formKey.currentState!.validate()) {
                onSave(controller.text);
              }
            } else {
              onEdit();
            }
          },
        ),
      ],
    );
  }
}