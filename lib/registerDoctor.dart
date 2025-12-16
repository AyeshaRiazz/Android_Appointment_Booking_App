import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorRegistrationScreen extends StatefulWidget {
  final Color primaryColor = const Color(0xFFED7D6D); // Coral
  final Color secondaryColor = const Color(0xFF6AB1AB); // Teal
  final Color backgroundColor = const Color(0xFFF8F9FA);

  @override
  _DoctorRegistrationScreenState createState() => _DoctorRegistrationScreenState();
}

class _DoctorRegistrationScreenState extends State<DoctorRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Form controllers
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _qualificationController = TextEditingController();
  final TextEditingController _consultationFeeController = TextEditingController();

  // Dropdown values
  String? _selectedDepartment;
  String? _selectedSpecialization;
  String? _selectedGender;
  List<String> _availableTimes = [];

  bool _isLoading = false;

  // Predefined options
  final List<String> _departments = [
    'Cardiology',
    'Neurology',
    'Orthopedics',
    'Pediatrics',
    'Dermatology',
    'Oncology',
    'Gynecology',
    'Psychiatry',
    'Urology',
    'ENT',
    'General Medicine',
    'Dentistry',
  ];

  final List<String> _specializations = [
    'Cardiologist',
    'Neurologist',
    'Orthopedic Surgeon',
    'Pediatrician',
    'Dermatologist',
    'Oncologist',
    'Gynecologist',
    'Psychiatrist',
    'Urologist',
    'ENT Specialist',
    'General Physician',
    'Dentist',
    'Surgeon',
    'Radiologist',
    'Anesthesiologist',
  ];

  final List<String> _genders = ['Male', 'Female', 'Other'];
  final List<String> _availableTimeSlots = [
    '9-10 AM',
    '10-11 AM',
    '11-12 PM',
    '2-3 PM',
    '3-4 PM',
    '4-5 PM',
    '5-6 PM',
    '6-7 PM',
  ];

  @override
  void initState() {
    super.initState();
  }

  Future<void> _registerDoctor() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedDepartment == null || _selectedSpecialization == null || _selectedGender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select all required options'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_availableTimes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one available time slot'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Generate unique document ID using timestamp
      String doctorDocId = DateTime.now().millisecondsSinceEpoch.toString();

      // Store doctor details in Firestore
      await _firestore.collection('doctors').doc(doctorDocId).set({
        'doctorId': doctorDocId,
        'fullName': _fullNameController.text.trim(),
        'phone': _phoneController.text.trim(),
        'specialization': _selectedSpecialization,
        'department': _selectedDepartment,
        'qualification': _qualificationController.text.trim(),
        'consultationFee': _consultationFeeController.text.trim(),
        'gender': _selectedGender,
        'availableTimes': _availableTimes,
        'status': 'active',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'totalAppointments': 0,
        'rating': 0.0,
        'reviews': 0,
      });

      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Doctor registered successfully!'),
            backgroundColor: widget.secondaryColor,
            duration: const Duration(seconds: 3),
          ),
        );

        // Show success dialog
        _showSuccessDialog();
      }
    } catch (e) {
      print('Error saving doctor: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: widget.secondaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle,
                  color: widget.secondaryColor,
                  size: 40,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Registration Successful',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: widget.secondaryColor,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Doctor has been registered successfully!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow('Name', _fullNameController.text),
                    const SizedBox(height: 8),
                    _buildInfoRow('Specialization', _selectedSpecialization ?? ''),
                    const SizedBox(height: 8),
                    _buildInfoRow('Department', _selectedDepartment ?? ''),
                    const SizedBox(height: 8),
                    _buildInfoRow('Phone', _phoneController.text),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Doctor will appear in the doctors list.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _clearForm();
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: widget.secondaryColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(
                        'Add Another',
                        style: TextStyle(
                          color: widget.secondaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: widget.secondaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text(
                        'Done',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            '$label:',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
              fontSize: 13,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }

  void _clearForm() {
    _formKey.currentState?.reset();
    setState(() {
      _fullNameController.clear();
      _phoneController.clear();
      _qualificationController.clear();
      _consultationFeeController.clear();
      _selectedDepartment = null;
      _selectedSpecialization = null;
      _selectedGender = null;
      _availableTimes.clear();
    });
  }

  void _toggleTimeSlot(String timeSlot) {
    setState(() {
      if (_availableTimes.contains(timeSlot)) {
        _availableTimes.remove(timeSlot);
      } else {
        _availableTimes.add(timeSlot);
      }
    });
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _qualificationController.dispose();
    _consultationFeeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      appBar: AppBar(
        title: const Text(
          "Register Doctor",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: widget.secondaryColor,
        elevation: 0,
        centerTitle: true,
        shape: const Border(
          bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1),
        ),
      ),
      body: _isLoading
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: widget.secondaryColor),
            const SizedBox(height: 16),
            Text(
              'Registering Doctor...',
              style: TextStyle(
                color: widget.secondaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      )
          : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 16),

              // Header Card
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: widget.secondaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.person_add,
                        color: widget.secondaryColor,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'New Doctor Registration',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[800],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Fill in all required details',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Personal Information Section
              _buildSectionHeader('Personal Information'),

              // Full Name
              _buildCompactTextField(
                controller: _fullNameController,
                label: 'Full Name',
                hint: 'Enter doctor name',
                icon: Icons.person_outline,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required field';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // Phone Number
              _buildCompactTextField(
                controller: _phoneController,
                label: 'Phone Number',
                hint: 'Enter 10-digit number',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required field';
                  }
                  if (value.length != 10) {
                    return 'Must be 10 digits';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // Gender Dropdown
              _buildCompactDropdown(
                label: 'Gender',
                value: _selectedGender,
                items: _genders,
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
                icon: Icons.transgender,
              ),
              const SizedBox(height: 20),

              // Professional Information Section
              _buildSectionHeader('Professional Information'),

              // Department Dropdown
              _buildCompactDropdown(
                label: 'Department',
                value: _selectedDepartment,
                items: _departments,
                onChanged: (value) {
                  setState(() {
                    _selectedDepartment = value;
                  });
                },
                icon: Icons.business_center_outlined,
              ),
              const SizedBox(height: 12),

              // Specialization Dropdown
              _buildCompactDropdown(
                label: 'Specialization',
                value: _selectedSpecialization,
                items: _specializations,
                onChanged: (value) {
                  setState(() {
                    _selectedSpecialization = value;
                  });
                },
                icon: Icons.medical_services_outlined,
              ),
              const SizedBox(height: 12),

              // Qualification
              _buildCompactTextField(
                controller: _qualificationController,
                label: 'Qualification',
                hint: 'e.g., MBBS, MD, MS',
                icon: Icons.school_outlined,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required field';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // Consultation Fee
              _buildCompactTextField(
                controller: _consultationFeeController,
                label: 'Consultation Fee (₹)',
                hint: 'e.g., 500',
                icon: Icons.currency_rupee_outlined,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required field';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Enter valid amount';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Available Time Slots Section
              _buildSectionHeader('Available Time Slots'),
              const SizedBox(height: 8),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select available slots:',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _availableTimeSlots.map((timeSlot) {
                        bool isSelected = _availableTimes.contains(timeSlot);
                        return FilterChip(
                          label: Text(
                            timeSlot,
                            style: TextStyle(
                              fontSize: 12,
                              color: isSelected ? Colors.white : Colors.grey[700],
                            ),
                          ),
                          selected: isSelected,
                          onSelected: (selected) => _toggleTimeSlot(timeSlot),
                          selectedColor: widget.secondaryColor,
                          backgroundColor: Colors.grey[100],
                          checkmarkColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          labelPadding: const EdgeInsets.symmetric(horizontal: 12),
                        );
                      }).toList(),
                    ),
                    if (_availableTimes.isEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          '* Please select at least one time slot',
                          style: TextStyle(
                            color: Colors.red[400],
                            fontSize: 11,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Action Buttons
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(color: Colors.grey[200]!),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _clearForm,
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.grey[300]!),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: Text(
                          'Clear All',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _registerDoctor,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: widget.secondaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          elevation: 0,
                        ),
                        child: _isLoading
                            ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          ),
                        )
                            : Text(
                          'Register Doctor',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),

              // Footer Note
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.grey[500],
                      size: 14,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'All fields marked with * are required',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: widget.secondaryColor,
        ),
      ),
    );
  }

  Widget _buildCompactTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 6),
          child: Row(
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
              ),
              Text(
                ' *',
                style: TextStyle(
                  color: Colors.red[400],
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 8),
                child: Icon(
                  icon,
                  color: widget.secondaryColor,
                  size: 20,
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: controller,
                  keyboardType: keyboardType,
                  validator: validator,
                  style: const TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 13,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.only(right: 12),
                    errorStyle: TextStyle(
                      fontSize: 11,
                      color: Colors.red[400],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCompactDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 6),
          child: Row(
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
              ),
              Text(
                ' *',
                style: TextStyle(
                  color: Colors.red[400],
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 8),
                child: Icon(
                  icon,
                  color: widget.secondaryColor,
                  size: 20,
                ),
              ),
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: value,
                    isExpanded: true,
                    icon: Icon(Icons.arrow_drop_down, color: widget.secondaryColor, size: 22),
                    items: items.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Text(
                            item,
                            style: const TextStyle(fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: onChanged,
                    hint: Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Text(
                        'Select $label',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 13,
                        ),
                      ),
                    ),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    dropdownColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ],
    );
  }
}