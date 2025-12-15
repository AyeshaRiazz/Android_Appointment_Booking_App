import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateDoctorScreen extends StatefulWidget {
  final String doctorId;

  const UpdateDoctorScreen({super.key, required this.doctorId});

  @override
  _UpdateDoctorScreenState createState() => _UpdateDoctorScreenState();
}

class _UpdateDoctorScreenState extends State<UpdateDoctorScreen> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Form controllers
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _qualificationController = TextEditingController();
  final TextEditingController _consultationFeeController = TextEditingController();

  // Dropdown values
  String? _selectedDepartment;
  String? _selectedSpecialization;
  String? _selectedGender;
  String? _selectedStatus;
  List<String> _availableTimes = [];

  // Doctor data
  String _doctorName = '';
  bool _isLoading = true;
  bool _isUpdating = false;

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
  final List<String> _statusOptions = ['active', 'inactive'];
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
    _loadDoctorData();
  }

  Future<void> _loadDoctorData() async {
    try {
      DocumentSnapshot doctorDoc = await _firestore
          .collection('doctors')
          .doc(widget.doctorId)
          .get();

      if (doctorDoc.exists) {
        final data = doctorDoc.data() as Map<String, dynamic>;

        setState(() {
          _doctorName = data['fullName'] ?? 'Unknown';
          _phoneController.text = data['phone'] ?? '';
          _qualificationController.text = data['qualification'] ?? '';
          _consultationFeeController.text = data['consultationFee']?.toString() ?? '';
          _selectedDepartment = data['department'];
          _selectedSpecialization = data['specialization'];
          _selectedGender = data['gender'];
          _selectedStatus = data['status'] ?? 'active';
          _availableTimes = List<String>.from(data['availableTimes'] ?? []);
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        _showError('Doctor not found');
      }
    } catch (e) {
      print('Error loading doctor: $e');
      setState(() {
        _isLoading = false;
      });
      _showError('Failed to load doctor data');
    }
  }

  Future<void> _updateDoctor() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedDepartment == null ||
        _selectedSpecialization == null ||
        _selectedGender == null ||
        _selectedStatus == null) {
      _showError('Please fill all required fields');
      return;
    }

    if (_availableTimes.isEmpty) {
      _showError('Please select at least one available time slot');
      return;
    }

    setState(() {
      _isUpdating = true;
    });

    try {
      await _firestore.collection('doctors').doc(widget.doctorId).update({
        'phone': _phoneController.text.trim(),
        'department': _selectedDepartment,
        'specialization': _selectedSpecialization,
        'qualification': _qualificationController.text.trim(),
        'consultationFee': _consultationFeeController.text.trim(),
        'gender': _selectedGender,
        'status': _selectedStatus,
        'availableTimes': _availableTimes,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Doctor updated successfully!'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            duration: const Duration(seconds: 2),
          ),
        );

        // Navigate back after a short delay
        Future.delayed(const Duration(milliseconds: 1500), () {
          if (mounted) {
            Navigator.pop(context, true); // Pass true to indicate success
          }
        });
      }
    } catch (e) {
      print('Error updating doctor: $e');
      _showError('Failed to update doctor: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isUpdating = false;
        });
      }
    }
  }

  void _showError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
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
    _phoneController.dispose();
    _qualificationController.dispose();
    _consultationFeeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color(0xFFED7D6D);
    final Color secondaryColor = const Color(0xFF6AB1AB);
    final Color backgroundColor = const Color(0xFFF8F9FA);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          "Update Doctor",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: secondaryColor,
        elevation: 0,
        centerTitle: true,
        shape: const Border(
          bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1),
        ),
        actions: [
          if (_isUpdating)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: secondaryColor,
                ),
              ),
            ),
        ],
      ),
      body: _isLoading
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: secondaryColor),
            const SizedBox(height: 16),
            Text(
              'Loading Doctor Details...',
              style: TextStyle(
                color: secondaryColor,
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
                  border: Border.all(color: secondaryColor.withOpacity(0.2)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: secondaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.edit_document,
                        color: secondaryColor,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Update Doctor Information',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[800],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'ID: ${widget.doctorId}',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Doctor Name (Read Only)
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: secondaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.person,
                        color: secondaryColor,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Doctor Name',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _doctorName,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF333333),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Fixed',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.blue[700],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Contact Information Section
              _buildSectionHeader('Contact Information'),

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
              const SizedBox(height: 12),

              // Status Dropdown
              _buildCompactDropdown(
                label: 'Status',
                value: _selectedStatus,
                items: _statusOptions,
                onChanged: (value) {
                  setState(() {
                    _selectedStatus = value;
                  });
                },
                icon: Icons.circle_outlined,
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
                          selectedColor: secondaryColor,
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
                        onPressed: _isUpdating ? null : () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.grey[300]!),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: Text(
                          'Cancel',
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
                        onPressed: _isUpdating ? null : _updateDoctor,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: secondaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          elevation: 0,
                        ),
                        child: _isUpdating
                            ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          ),
                        )
                            : Text(
                          'Update Doctor',
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
                        'Doctor name cannot be changed for record consistency',
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
    final Color secondaryColor = const Color(0xFF6AB1AB);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: secondaryColor,
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
    final Color secondaryColor = const Color(0xFF6AB1AB);

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
                  color: secondaryColor,
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
    final Color secondaryColor = const Color(0xFF6AB1AB);

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
                  color: secondaryColor,
                  size: 20,
                ),
              ),
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: value,
                    isExpanded: true,
                    icon: Icon(Icons.arrow_drop_down, color: secondaryColor, size: 22),
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