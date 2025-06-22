import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

const List<String> topLanguages = [
  'English',
  'Mandarin Chinese',
  'Hindi',
  'Spanish',
  'French',
  'Standard Arabic',
  'Bengali',
  'Russian',
  'Portuguese',
  'Urdu',
  'Indonesian',
  'German',
  'Japanese',
  'Swahili',
  'Marathi',
  'Telugu',
  'Turkish',
  'Tamil',
  'Western Punjabi',
  'Wu Chinese (Shanghainese)',
  'Korean',
  'Vietnamese',
  'Hausa',
  'Javanese',
  'Egyptian Arabic',
  'Italian',
  'Thai',
  'Gujarati',
  'Kannada',
  'Persian (Farsi)',
  'Yue Chinese (Cantonese)',
  'Polish',
  'Malayalam',
  'Odia (Oriya)',
  'Maithili',
  'Burmese',
  'Sunda',
  'Romanian',
  'Pashto',
  'Sindhi',
  'Amharic',
  'Fula (Fulani)',
  'Azerbaijani',
  'Igbo',
  'Awadhi',
  'Gan Chinese',
  'Ukrainian',
  'Hebrew',
  'Bhojpuri',
  'Serbo-Croatian',
  'Dutch',
  'Saraiki',
  'Sinhalese',
  'Chittagonian',
  'Zhuang',
  'Greek',
  'Kazakh',
  'Shona',
  'Kinyarwanda',
  'Zulu',
  'Czech',
  'Madurese',
  'Belarusian',
  'Hungarian',
  'Somali',
  'Hiligaynon (Ilonggo)',
  'Quechua',
  'Swedish',
  'Kurdish (Kurmanji)',
  'Nepali',
  'Assamese',
  'Tagalog (Filipino)',
  'Uyghur',
  'Mossi',
  'Xhosa',
  'Malagasy',
  'Tswana',
  'Lithuanian',
  'Turkmen',
  'Slovak',
  'Bulgarian',
  'Finnish',
  'Danish',
  'Norwegian',
  'Lao',
  'Khmer',
  'Latvian',
  'Tajik',
  'Tigrinya',
  'Cebuano',
  'Chhattisgarhi',
  'Akan (Twi/Fante)',
  'Mongolian',
  'Bosnian',
  'Konkani',
  'Estonian',
  'Macedonian',
  'Yoruba',
  'Pampangan (Kapampangan)',
  'Lombard',
];

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  XFile? _profileImage;
  final ImagePicker _picker = ImagePicker();

  String fullName = '';
  String username = '';
  String bio = '';
  DateTime? dob;
  String? gender;
  String location = '';
  String phone = '';
  String email = '';
  String language = '';
  List<String> interests = [];
  final List<String> allInterests = [
    'Travel',
    'Tech',
    'Music',
    'Sports',
    'Art',
    'Food',
    'Movies',
    'Books',
  ];
  DateTime createdDate = DateTime(2023, 1, 1);
  int followers = 120;
  int following = 80;

  List<String> allLanguages = [];
  bool _loadingLanguages = false;
  List<String> selectedLanguages = [];
  final FocusNode _langFocusNode = FocusNode();

  final List<String> genderOptions = [
    'Male',
    'Female',
    'Transgender',
    'Non-binary',
    'Genderqueer',
    'Genderfluid',
    'Agender',
    'Bigender',
    'Pangender',
    'Two-Spirit',
    'Third Gender',
    'Other',
    'Prefer not to say',
  ];

  @override
  void initState() {
    super.initState();
    allLanguages = List<String>.from(topLanguages);
  }

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _profileImage = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: _profileImage != null
                          ? Image.file(
                              File(_profileImage!.path),
                              fit: BoxFit.cover,
                            ).image
                          : const AssetImage('assets/profile_placeholder.png'),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(8),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                fullName,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              Text(username, style: GoogleFonts.poppins(color: Colors.grey)),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        '$followers',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Followers',
                        style: GoogleFonts.poppins(fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(width: 24),
                  Column(
                    children: [
                      Text(
                        '$following',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Following',
                        style: GoogleFonts.poppins(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: fullName,
                decoration: const InputDecoration(hintText: 'Full Name'),
                style: GoogleFonts.poppins(),
                onTap: () {
                  if (fullName.isNotEmpty) setState(() => fullName = '');
                },
                onChanged: (v) => setState(() => fullName = v),
              ),
              TextFormField(
                initialValue: username,
                decoration: const InputDecoration(hintText: 'Username'),
                style: GoogleFonts.poppins(),
                onTap: () {
                  if (username.isNotEmpty) setState(() => username = '');
                },
                onChanged: (v) => setState(() => username = v),
              ),
              TextFormField(
                initialValue: bio,
                decoration: const InputDecoration(hintText: 'Bio'),
                style: GoogleFonts.poppins(),
                onTap: () {
                  if (bio.isNotEmpty) setState(() => bio = '');
                },
                onChanged: (v) => setState(() => bio = v),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Date of Birth: ${dob != null ? DateFormat('yMMMd').format(dob!) : 'Not set'}',
                      style: GoogleFonts.poppins(),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: dob ?? DateTime(2000, 1, 1),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) setState(() => dob = picked);
                    },
                    child: const Text('Select'),
                  ),
                ],
              ),
              DropdownButtonFormField<String>(
                value: genderOptions.contains(gender) ? gender : null,
                items: genderOptions
                    .map(
                      (g) => DropdownMenuItem(
                        value: g,
                        child: Text(
                          g,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (v) => setState(() => gender = v),
                decoration: const InputDecoration(hintText: 'Gender'),
                style: GoogleFonts.poppins(color: Colors.black),
              ),
              TextFormField(
                initialValue: location,
                decoration: const InputDecoration(hintText: 'Location'),
                style: GoogleFonts.poppins(),
                onTap: () {
                  if (location.isNotEmpty) setState(() => location = '');
                },
                onChanged: (v) => setState(() => location = v),
              ),
              TextFormField(
                initialValue: phone,
                decoration: const InputDecoration(hintText: 'Phone Number'),
                style: GoogleFonts.poppins(),
                keyboardType: TextInputType.phone,
                validator: (v) =>
                    v != null && v.length < 10 ? 'Enter valid phone' : null,
                onTap: () {
                  if (phone.isNotEmpty) setState(() => phone = '');
                },
                onChanged: (v) => setState(() => phone = v),
              ),
              TextFormField(
                initialValue: email,
                decoration: const InputDecoration(hintText: 'Email Address'),
                style: GoogleFonts.poppins(),
                keyboardType: TextInputType.emailAddress,
                validator: (v) =>
                    v != null && !v.contains('@') ? 'Enter valid email' : null,
                onTap: () {
                  if (email.isNotEmpty) setState(() => email = '');
                },
                onChanged: (v) => setState(() => email = v),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Language Preferences',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 8),
              // Language Preferences Multi-Select Dropdown
              _LanguageDropdown(
                allLanguages: allLanguages,
                selectedLanguages: selectedLanguages,
                loading: _loadingLanguages,
                onChanged: (langs) => setState(() => selectedLanguages = langs),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Interests',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                ),
              ),
              Wrap(
                spacing: 8,
                children: allInterests.map((interest) {
                  final selected = interests.contains(interest);
                  return FilterChip(
                    label: Text(interest),
                    selected: selected,
                    onSelected: (val) {
                      setState(() {
                        if (val) {
                          interests.add(interest);
                        } else {
                          interests.remove(interest);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Account Created: ${DateFormat('yMMMd').format(createdDate)}',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.lock),
                      label: const Text('Change Password'),
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(48),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.privacy_tip),
                      label: const Text('Privacy Settings'),
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(48),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.notifications),
                      label: const Text('Notification Settings'),
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(48),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: const Icon(Icons.logout),
                label: const Text('Logout'),
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(48),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _langFocusNode.dispose();
    super.dispose();
  }
}

class _LanguageDropdown extends StatefulWidget {
  final List<String> allLanguages;
  final List<String> selectedLanguages;
  final bool loading;
  final ValueChanged<List<String>> onChanged;

  const _LanguageDropdown({
    required this.allLanguages,
    required this.selectedLanguages,
    required this.loading,
    required this.onChanged,
  });

  @override
  State<_LanguageDropdown> createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends State<_LanguageDropdown> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;
  final FocusNode _focusNode = FocusNode();
  String _search = '';

  String _customLanguage = '';
  bool _showCustomInput = false;

  List<String> get _topTen => widget.allLanguages.take(10).toList();
  List<String> get _filteredLanguages {
    if (_search.isEmpty) {
      return _topTen;
    } else {
      return widget.allLanguages
          .where((lang) => lang.toLowerCase().contains(_search.toLowerCase()))
          .toList();
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _removeOverlay();
    super.dispose();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _isOpen = false;
  }

  void _toggleDropdown() {
    if (_isOpen) {
      _removeOverlay();
    } else {
      _showOverlay();
    }
    setState(() {});
  }

  void _showOverlay() {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: renderBox.localToGlobal(Offset.zero).dx,
        top: renderBox.localToGlobal(Offset.zero).dy + size.height + 4,
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, 0),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              constraints: const BoxConstraints(maxHeight: 350, minWidth: 200),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 40), // for alignment
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 8.0,
                            left: 12,
                            right: 12,
                          ),
                          child: Text(
                            'Select Language',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        tooltip: 'Close',
                        onPressed: _removeOverlay,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    child: TextField(
                      autofocus: true,
                      style: GoogleFonts.poppins(),
                      decoration: InputDecoration(
                        hintText: 'Search languages...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 12,
                        ),
                        prefixIcon: const Icon(Icons.search, size: 20),
                      ),
                      onChanged: (v) {
                        setState(() {
                          _search = v;
                          _showCustomInput =
                              _filteredLanguages.isEmpty && _search.isNotEmpty;
                        });
                      },
                    ),
                  ),
                  if (_showCustomInput)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              style: GoogleFonts.poppins(),
                              decoration: const InputDecoration(
                                hintText: 'Enter your language',
                                isDense: true,
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (v) =>
                                  setState(() => _customLanguage = v),
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: _customLanguage.trim().isEmpty
                                ? null
                                : () {
                                    final newList = List<String>.from(
                                      widget.selectedLanguages,
                                    );
                                    newList.add(_customLanguage.trim());
                                    widget.onChanged(newList);
                                    setState(() {
                                      _customLanguage = '';
                                      _showCustomInput = false;
                                      _search = '';
                                    });
                                    _removeOverlay();
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text('Add'),
                          ),
                        ],
                      ),
                    ),
                  if (!_showCustomInput) const Divider(height: 1),
                  Expanded(
                    child: _filteredLanguages.isEmpty && _search.isNotEmpty
                        ? ListTile(
                            title: Text('Other', style: GoogleFonts.poppins()),
                            leading: const Icon(Icons.add),
                            onTap: () =>
                                setState(() => _showCustomInput = true),
                          )
                        : _filteredLanguages.isEmpty
                        ? Center(
                            child: Text(
                              'No languages found',
                              style: GoogleFonts.poppins(),
                            ),
                          )
                        : ListView(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            shrinkWrap: true,
                            children: _filteredLanguages.map((lang) {
                              final isSelected = widget.selectedLanguages
                                  .contains(lang);
                              return CheckboxListTile(
                                value: isSelected,
                                title: Text(
                                  lang,
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                  ),
                                ),
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                dense: true,
                                onChanged: isSelected
                                    ? (val) {
                                        // Only allow unchecking (removal)
                                        if (val == false) {
                                          final newList = List<String>.from(
                                            widget.selectedLanguages,
                                          );
                                          newList.remove(lang);
                                          widget.onChanged(newList);
                                        }
                                      }
                                    : (val) {
                                        if (val == true) {
                                          final newList = List<String>.from(
                                            widget.selectedLanguages,
                                          );
                                          newList.add(lang);
                                          widget.onChanged(newList);
                                        }
                                      },
                              );
                            }).toList(),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ); // <-- This closes Positioned
    overlay.insert(_overlayEntry!);
    _isOpen = true;
    // Dismiss on tap outside
    Future.delayed(Duration.zero, () {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: widget.loading ? null : _toggleDropdown,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Wrap(
            spacing: 8,
            runSpacing: 4,
            children: widget.selectedLanguages.isEmpty
                ? [
                    Text(
                      'Select languages...',
                      style: GoogleFonts.poppins(color: Colors.grey),
                    ),
                  ]
                : widget.selectedLanguages
                      .map(
                        (lang) => Chip(
                          label: Text(lang),
                          onDeleted: () {
                            final newList = List<String>.from(
                              widget.selectedLanguages,
                            );
                            newList.remove(lang);
                            widget.onChanged(newList);
                          },
                        ),
                      )
                      .toList(),
          ),
        ),
      ),
    );
  }
}
