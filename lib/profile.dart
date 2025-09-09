import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

import '../constants.dart';
//import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  final File? image;
  ProfileScreen({this.image});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _profileImage;
  String _name = "John Doe";
  String _email = "johndoe@email.com";
  String _phone = "+234 812 345 6789";

  @override
  void initState() {
    super.initState();
    _profileImage = widget.image;
    _loadProfileData();
  }

  // ===== Load saved profile data =====
  Future<void> _loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name') ?? _name;
      _email = prefs.getString('email') ?? _email;
      _phone = prefs.getString('phone') ?? _phone;
      //String? imagePath = prefs.getString('profileImage');
      // if (imagePath.isNotEmpty) {
      //   _profileImage = File(imagePath);
      // }
    });
  }

  // ===== Navigate to Edit Profile Page =====
  Future<void> _editProfile() async {
    final updatedData = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(
          currentName: _name,
          currentEmail: _email,
          currentPhone: _phone,
          currentImage: _profileImage,
        ),
      ),
    );

    if (updatedData != null && mounted) {
      setState(() {
        _name = updatedData['name'];
        _email = updatedData['email'];
        _phone = updatedData['phone'];
        _profileImage = updatedData['image'];
      });
    }
  }

  // ===== View profile picture fullscreen =====
  void _viewImage() {
    if (_profileImage == null) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullImageView(image: _profileImage!),
      ),
    );
  }

  Widget buildInfoCard(String label, String value, IconData icon) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: Icon(icon, color: Colors.pink, size: 28),
        title: Text(
          label,
          style: TextStyle(color: Colors.grey[600], fontSize: 14),
        ),
        subtitle: Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          // ===== Gradient Header =====
          Container(
            height: 280,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.pinkAccent, Colors.deepPurple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
          ),

          // ===== Profile Content =====
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 60),
                Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      // ===== Profile Image =====
                      GestureDetector(
                        onTap: _viewImage,
                        child: CircleAvatar(
                          radius: 70,
                          backgroundColor: Colors.white,
                          backgroundImage: _profileImage != null
                              ? FileImage(_profileImage!)
                              : null,
                          child: _profileImage == null
                              ? Icon(Icons.person, size: 80, color: Colors.grey)
                              : null,
                        ),
                      ),
                      // ===== Edit Icon =====
                      Positioned(
                        bottom: 5,
                        right: 5,
                        child: GestureDetector(
                          onTap: _editProfile,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.pink,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                )
                              ],
                            ),
                            child: const Icon(Icons.camera_alt,
                                color: Colors.white, size: 22),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 15),
                Text(
                  _name,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  "Member",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[900],
                  ),
                ),
                const SizedBox(height: 20),

                // ===== User Info Cards =====
                buildInfoCard("Email", _email, Icons.email),
                buildInfoCard("Phone", _phone, Icons.phone),
              ],
            ),
          ),
        ],
      ),

      // ===== Floating Action Button =====
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _editProfile,
        icon: Icon(Icons.edit, color: Colors.white,),
        label: Text("Edit Profile", style: TextStyle(color: Colors.white),),
        backgroundColor: primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

// ===== Full Screen Image Viewer =====
class FullImageView extends StatelessWidget {
  final File image;
  FullImageView({required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: InteractiveViewer(
          child: Image.file(image),
        ),
      ),
    );
  }
}
class EditProfileScreen extends StatefulWidget {
  final String currentName;
  final String currentEmail;
  final String currentPhone;
  final File? currentImage;

  EditProfileScreen({
    required this.currentName,
    required this.currentEmail,
    required this.currentPhone,
    this.currentImage,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _profileImage = widget.currentImage;
    _nameController = TextEditingController(text: widget.currentName);
    _emailController = TextEditingController(text: widget.currentEmail);
    _phoneController = TextEditingController(text: widget.currentPhone);
  }

  // ===== Pick new profile picture =====
  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  // ===== Save updated profile data =====
  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('name', _nameController.text);
      await prefs.setString('email', _emailController.text);
      await prefs.setString('phone', _phoneController.text);
      await prefs.setString('profileImage', _profileImage?.path ?? '');

      Navigator.pop(context, {
        'name': _nameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
        'image': _profileImage,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Profile")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // ===== Profile Image =====
              Center(
                child: GestureDetector(
                  onTap: () => _pickImage(ImageSource.gallery),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage:
                        _profileImage != null ? FileImage(_profileImage!) : null,
                    child: _profileImage == null
                        ? Icon(Icons.person, size: 60)
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // ===== Name =====
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Full Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? "Enter your name" : null,
              ),
              const SizedBox(height: 15),

              // ===== Email =====
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                    value == null || value.isEmpty ? "Enter your email" : null,
              ),
              const SizedBox(height: 15),

              // ===== Phone =====
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) =>
                    value == null || value.isEmpty ? "Enter your phone" : null,
              ),
              const SizedBox(height: 25),

              // ===== Save Button =====
              ElevatedButton(
                onPressed: _saveProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "Save Changes",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}