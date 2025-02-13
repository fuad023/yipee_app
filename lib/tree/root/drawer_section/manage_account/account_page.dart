import 'package:flutter/material.dart';
import 'package:student_app/tree/root/drawer_section/manage_account/database_user.dart';
import 'package:student_app/tree/root/drawer_section/manage_account/components/my_input_theme.dart';
import 'package:student_app/tree/root/drawer_section/manage_account/components/string_extentions.dart';

class AccountManagePage extends StatefulWidget {
  const AccountManagePage({super.key});

  @override
  State<AccountManagePage> createState() => _AccountManagePageState();
}

class Field {
  bool canEdit = true;
  bool isEditing = false;
  TextEditingController controller = TextEditingController();
}

class _AccountManagePageState extends State<AccountManagePage> {
  late Map<String, dynamic> userData;
  bool dataFetching = true;
  bool deleteIcon = false;
  DatabaseUser database = DatabaseUser();
  final inputTheme = MyInputTheme().theme();
  final _formKey = GlobalKey<FormState>();

  Map<String, Field> fieldMap = {
    'name': Field(),
    'user_id': Field(),
    'email': Field(),
    'id' : Field(),
    'year': Field(),
    'semester': Field(),
    'handle': Field(),
  };

  void fetchHandle() async {
    userData = await database.fetchData();
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
      backgroundColor: const Color(0xFFF7F7F7),
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
      : SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _singleTextField(
                  label: 'NAME',
                  field: _nameField(),
                ),
                const SizedBox(height: 8.0),

                _singleTextField(
                  label: 'USER ID',
                  field: _userIdField(),
                ),
                const SizedBox(height: 8.0),

                _singleTextField(
                  label: 'EMAIL',
                  field: _emailField(),
                ),
                const SizedBox(height: 8.0),

                _singleTextField(
                  label: 'ID',
                  field: _idField(),
                ),
                const SizedBox(height: 8.0),

                _doubleTextField(
                  labelFirst: 'YEAR',
                  fieldFirst: _yearField(),
                  labelSecond: 'SEMESTER',
                  fieldSecond: _semesterField(),
                ),
                const SizedBox(height: 8.0),

                _singleTextField(
                  label: 'CODEFORCES',
                  field: _handleField(),
                ),
                const SizedBox(height: 8.0),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _singleTextField({
    required String label,
    required Widget field,
  }) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14.0,
                letterSpacing: 2.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            field,
          ],
        ),
      ),
    );
  }

 Widget _doubleTextField({
    required String labelFirst,
    required Widget fieldFirst,
    required String labelSecond,
    required Widget fieldSecond,
  }) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: SizedBox(
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    labelFirst,
                    style: const TextStyle(
                      fontSize: 14.0,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  fieldFirst,
                ],
              ),
            ),
            const Expanded(
              child: VerticalDivider( // for some reason it's not showing
                color: Color(0xFFF7F7F7),
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    labelSecond,
                    style: const TextStyle(
                      fontSize: 14.0,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  fieldSecond,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _nameField() {
    return _buildEditableField(
      field: "name",
      hint: "Alex Clerk",
      helper: "",
      userData: userData['name'] ?? "",
      isEditing: fieldMap['name']!.isEditing,
      canEdit: fieldMap['name']!.canEdit,
      controller: fieldMap['name']!.controller,
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value == null || value.isWhitespace()) {
          return "Enter a valid name!";
        } return null;
      },
      onSave: (newField) {
        setState(() {
          userData['name'] = newField;
          database.setName(newField);
          fieldMap['name']!.isEditing = false;
          fieldMap.forEach((key, value) {
            value.canEdit = true;
          });
        });
      },
      onEdit: () {
        setState(() {
          fieldMap['name']!.isEditing = true;
          fieldMap.forEach((key, value) {
            value.canEdit = key != 'name' ? false : true;
          });
          fieldMap['name']!.controller.text = userData['name'] ?? "";
        });
      },
    );
  }

  Widget _userIdField() {
    String data = userData['user_id'] != null ? userData['user_id'].toString().substring(1) : "";
    return _buildEditableField(
      field: "user_id",
      prefix: const Text('@'),
      hint: "fuadxlr8",
      helper: "",
      userData: data,
      isEditing: fieldMap['user_id']!.isEditing,
      canEdit: fieldMap['user_id']!.canEdit,
      controller: fieldMap['user_id']!.controller,
      textCapitalization: TextCapitalization.none,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isWhitespace()) {
          return "This ID is not available!";
        } return null;
      },
      onSave: (newField) {
        setState(() {
          userData['user_id'] = newField;
          database.setUserId(newField);
          fieldMap['user_id']!.isEditing = false;
          fieldMap.forEach((key, value) {
            value.canEdit = true;
          });
        });
      },
      onEdit: () {
        setState(() {
          fieldMap['user_id']!.isEditing = true;
          fieldMap.forEach((key, value) {
            value.canEdit = key != 'user_id' ? false : true;
          });
          fieldMap['user_id']!.controller.text = data;
        });
      },
    );
  }

  Widget _emailField() {
    return _buildEditableField(
      field: "email",
      hint: "help@aust.edu",
      helper: "",
      userData: userData['email'] ?? "",
      isEditing: fieldMap['email']!.isEditing,
      canEdit: fieldMap['email']!.canEdit,
      controller: fieldMap['email']!.controller,
      textCapitalization: TextCapitalization.none,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isWhitespace() || !value.isValidEmail()) {
          return "Enter a valid email!";
        } return null;
      },
      onSave: (newField) {
        setState(() {
          userData['email'] = newField;
          database.setEmail(newField);
          fieldMap['email']!.isEditing = false;
          fieldMap.forEach((key, value) {
            value.canEdit = true;
          });
        });
      },
      onEdit: () {
        setState(() {
          fieldMap['email']!.isEditing = true;
          fieldMap.forEach((key, value) {
            value.canEdit = key != 'email' ? false : true;
          });
          fieldMap['email']!.controller.text = userData['email'] ?? "";
        });
      },
    );
  }

  Widget _idField() {
    return _buildEditableField(
      field: "id",
      hint: "20230104043",
      helper: "",
      userData: userData['id'] ?? "",
      isEditing: fieldMap['id']!.isEditing,
      canEdit: fieldMap['id']!.canEdit,
      controller: fieldMap['id']!.controller,
      textCapitalization: TextCapitalization.none,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || !value.isValidInt()) {
          return "Enter a valid number!";
        } return null;
      },
      onSave: (newField) {
        setState(() {
          userData['id'] = newField;
          database.setID(newField);
          fieldMap['id']!.isEditing = false;
          fieldMap.forEach((key, value) {
            value.canEdit = true;
          });
        });
      },
      onEdit: () {
        setState(() {
          fieldMap['id']!.isEditing = true;
          fieldMap.forEach((key, value) {
            value.canEdit = key != 'id' ? false : true;
          });
          fieldMap['id']!.controller.text = userData['id'] ?? "";
        });
      },
    );
  }

  Widget _yearField() {
    return _buildEditableField(
      field: "year",
      hint: "2",
      helper: "",
      userData: userData['year'] ?? "",
      isEditing: fieldMap['year']!.isEditing,
      canEdit: fieldMap['year']!.canEdit,
      controller: fieldMap['year']!.controller,
      textCapitalization: TextCapitalization.none,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || !value.isValidInt()) {
          return "Enter a valid number!";
        } return null;
      },
      onSave: (newField) {
        setState(() {
          userData['year'] = newField;
          database.setYear(newField);
          fieldMap['year']!.isEditing = false;
          fieldMap.forEach((key, value) {
            value.canEdit = true;
          });
        });
      },
      onEdit: () {
        setState(() {
          fieldMap['year']!.isEditing = true;
          fieldMap.forEach((key, value) {
            value.canEdit = key != 'year' ? false : true;
          });
          fieldMap['year']!.controller.text = userData['year'] ?? "";
        });
      },
    );
  }

  Widget _semesterField() {
    return _buildEditableField(
      field: "semester",
      hint: "1",
      helper: "",
      userData: userData['semester'].toString() == "null" ? "" : userData['semester'].toString(),
      isEditing: fieldMap['semester']!.isEditing,
      canEdit: fieldMap['semester']!.canEdit,
      controller: fieldMap['semester']!.controller,
      textCapitalization: TextCapitalization.none,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || !value.isValidInt()) {
          return "Enter a valid number!";
        } return null;
      },
      onSave: (newField) {
        setState(() {
          userData['semester'] = newField;
          database.setSemester(newField);
          fieldMap['semester']!.isEditing = false;
          fieldMap.forEach((key, value) {
            value.canEdit = true;
          });
        });
      },
      onEdit: () {
        setState(() {
          fieldMap['semester']!.isEditing = true;
          fieldMap.forEach((key, value) {
            value.canEdit = key != 'semester' ? false : true;
          });
          fieldMap['semester']!.controller.text = userData['semester'] ?? "";
        });
      },
    );
  }

  Widget _handleField() {
    return _buildEditableField(
      field: "handle",
      hint: "fuad023",
      helper: "You can always change your handle here.",
      userData: userData['handle'] ?? "",
      isEditing: fieldMap['handle']!.isEditing,
      canEdit: fieldMap['handle']!.canEdit,
      controller: fieldMap['handle']!.controller,
      textCapitalization: TextCapitalization.none,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value == null || value.isWhitespace()) {
          return "Enter a valid handle!";
        } return null;
      },
      onSave: (newField) {
        setState(() {
          userData['handle'] = newField;
          database.setHandle(newField);
          fieldMap['handle']!.isEditing = false;
          fieldMap.forEach((key, value) {
            value.canEdit = true;
          });
        });
      },
      onEdit: () {
        setState(() {
          fieldMap['handle']!.isEditing = true;
          fieldMap.forEach((key, value) {
            value.canEdit = key != 'handle' ? false : true;
          });
          fieldMap['handle']!.controller.text = userData['handle'] ?? "";
        });
      },
    );
  }

  Widget _buildEditableField({
    required String field,
    required String userData,
    required bool isEditing,
    required bool canEdit,
    Text prefix = const Text(''),
    required String hint,
    required String helper,
    required TextEditingController controller,
    required TextCapitalization textCapitalization,
    required TextInputType? keyboardType,
    required String? Function(String?) validator,
    required void Function(String) onSave,
    required VoidCallback onEdit,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: isEditing
            ? Theme(
              data: Theme.of(context).copyWith(
                textSelectionTheme: TextSelectionThemeData(
                  cursorColor: Colors.green[700],
                  selectionColor: Colors.green[200],
                  selectionHandleColor: Colors.green[700],
                ),
              ),
              child: TextFormField(
                controller: controller,
                textCapitalization: textCapitalization,
                autofocus: true,
                keyboardType: keyboardType,
                decoration: InputDecoration(
                  prefix: prefix,
                  helperText: helper,
                  hintText: hint,
                  filled: true,
                  fillColor: Colors.white
                ).applyDefaults(inputTheme),
                validator: validator,
              ),
            )
            : Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                prefix.data! + userData,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
        ),
        canEdit
        ? GestureDetector(
          onLongPress: () {
            setState(() {
              if (isEditing) {
                deleteIcon = !deleteIcon;
              }
            });
          },
          child: IconButton(
            icon: Icon(
              isEditing ? (deleteIcon ? Icons.delete : Icons.check)  : Icons.chevron_right_rounded,
              color: deleteIcon && isEditing ? Colors.red : Colors.green,
            ),
            onPressed: () {
              if (isEditing) {
                if (deleteIcon) {
                  deleteIcon = !deleteIcon;
                  onSave(controller.text = "");
                }
                else if (_formKey.currentState!.validate()) {
                  onSave(prefix.data! + controller.text);
                }
              } else {
                onEdit();
              }
            },
          ),
        )
        : Container(),
      ],
    );
  }

}