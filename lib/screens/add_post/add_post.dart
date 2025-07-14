import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  String? _selectedImage;
  String _caption = '';
  List<String> _hashtags = [];
  final List<String> _allFriends = ['Alice', 'Bob', 'Charlie'];
  List<String> _friends = [];
  String? _selectedLocation;
  DateTime? _scheduledDate;
  String? _imageCredit;
  final List<String> _filters = ['None', 'Black & White', 'Warm', 'Cool', 'Vintage'];
  String? _selectedFilter;
  String? _selectedMusic;
  bool _shareOnFacebook = false;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _selectedImage = picked.path;
      });
    }
  }

  void _generateHashtags() {
    setState(() {
      _hashtags = ['#travel', '#adventure', '#explore'];
    });
  }

  void _showTagFriendsDialog() async {
    final selected = await showDialog<List<String>>(
      context: context,
      builder: (context) {
        List<String> tempSelected = List<String>.from(_friends);
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text('Tag Friends'),
              content: SizedBox(
                width: 300,
                child: ListView(
                  shrinkWrap: true,
                  children: _allFriends.map((friend) {
                    return CheckboxListTile(
                      value: tempSelected.contains(friend),
                      onChanged: (val) {
                        setStateDialog(() {
                          if (val == true) {
                            tempSelected.add(friend);
                          } else {
                            tempSelected.remove(friend);
                          }
                        });
                      },
                      title: Text(friend),
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, tempSelected),
                  child: const Text('Done'),
                ),
              ],
            );
          },
        );
      },
    );
    if (selected != null) {
      setState(() {
        _friends = selected;
      });
    }
  }

  void _showAddCreditDialog() async {
    final controller = TextEditingController(text: _imageCredit);
    final credit = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Image Credit'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'e.g. Photo by John Doe'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    if (credit != null) {
      setState(() {
        _imageCredit = credit;
      });
    }
  }

  void _pickSchedule() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _scheduledDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _scheduledDate = pickedDate;
      });
    }
  }

  void _showMusicPicker() async {
    // Mock music picker for demo
    final music = await showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Select Music'),
        children: [
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, 'Chill Vibes'),
            child: const Text('Chill Vibes'),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, 'Upbeat Adventure'),
            child: const Text('Upbeat Adventure'),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, 'No Music'),
            child: const Text('No Music'),
          ),
        ],
      ),
    );
    if (music != null) {
      setState(() {
        _selectedMusic = music == 'No Music' ? null : music;
      });
    }
  }

  void _showLocationPicker() async {
    final location = await showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Select Location'),
        children: [
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, 'New York'),
            child: const Text('New York'),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, 'Paris'),
            child: const Text('Paris'),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, 'Tokyo'),
            child: const Text('Tokyo'),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, null),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
    if (location != null) {
      setState(() {
        _selectedLocation = location;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Profile screen background
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: 100 + MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Create Post',
                        style: GoogleFonts.poppins(
                          color: Colors.black87,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                          image: _selectedImage != null
                              ? DecorationImage(
                                  image: FileImage(File(_selectedImage!)),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: _selectedImage == null
                            ? Center(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.black,
                                    shape: BoxShape.circle,
                                  ),
                                  padding: const EdgeInsets.all(12),
                                  child: const Icon(
                                    Icons.add_a_photo,
                                    color: Colors.white,
                                    size: 32,
                                  ),
                                ),
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      maxLines: 3,
                      style: GoogleFonts.poppins(color: Colors.black87),
                      decoration: InputDecoration(
                        hintText: 'Write a caption...',
                        hintStyle: GoogleFonts.poppins(color: Colors.black38),
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (v) => setState(() => _caption = v),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: _generateHashtags,
                          icon: const Icon(Icons.tag, size: 18),
                          label: const Text('Generate Hashtags'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            foregroundColor: Colors.white,
                            shape: const StadiumBorder(),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 8,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Wrap(
                            spacing: 8,
                            children: _hashtags
                                .map(
                                  (tag) => FilterChip(
                                    label: Text(tag),
                                    selected: true,
                                    onSelected: (_) {},
                                    backgroundColor: Colors.grey[200],
                                    selectedColor: Colors.blueAccent
                                        .withOpacity(0.15),
                                    labelStyle: GoogleFonts.poppins(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        OutlinedButton.icon(
                          onPressed: _showTagFriendsDialog,
                          icon: const Icon(
                            Icons.person_add,
                            color: Colors.blueAccent,
                          ),
                          label: Text(
                            _friends.isEmpty
                                ? 'Tag People'
                                : 'Tagged: ${_friends.join(', ')}',
                            style: GoogleFonts.poppins(color: Colors.black87),
                            overflow: TextOverflow.ellipsis,
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.blueAccent),
                            shape: const StadiumBorder(),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                        const SizedBox(width: 10),
                        OutlinedButton.icon(
                          onPressed: _showLocationPicker,
                          icon: const Icon(
                            Icons.location_on,
                            color: Colors.blueAccent,
                          ),
                          label: Text(
                            _selectedLocation ?? 'Add Location',
                            style: GoogleFonts.poppins(color: Colors.black87),
                            overflow: TextOverflow.ellipsis,
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.blueAccent),
                            shape: const StadiumBorder(),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        OutlinedButton.icon(
                          onPressed: _pickSchedule,
                          icon: const Icon(
                            Icons.schedule,
                            color: Colors.blueAccent,
                          ),
                          label: Text(
                            _scheduledDate == null
                                ? 'Set Schedule'
                                : 'Scheduled: ${DateFormat('yMMMd').format(_scheduledDate!)}',
                            style: GoogleFonts.poppins(color: Colors.black87),
                            overflow: TextOverflow.ellipsis,
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.blueAccent),
                            shape: const StadiumBorder(),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                        const SizedBox(width: 10),
                        OutlinedButton.icon(
                          onPressed: _showAddCreditDialog,
                          icon: const Icon(
                            Icons.info_outline,
                            color: Colors.blueAccent,
                          ),
                          label: Text(
                            _imageCredit == null || _imageCredit!.isEmpty
                                ? 'Add Credit'
                                : _imageCredit!,
                            style: GoogleFonts.poppins(color: Colors.black87),
                            overflow: TextOverflow.ellipsis,
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.blueAccent),
                            shape: const StadiumBorder(),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        OutlinedButton.icon(
                          onPressed: _showMusicPicker,
                          icon: const Icon(
                            Icons.music_note,
                            color: Colors.blueAccent,
                          ),
                          label: Text(
                            _selectedMusic == null
                                ? 'Add Music'
                                : 'Music: $_selectedMusic',
                            style: GoogleFonts.poppins(color: Colors.black87),
                            overflow: TextOverflow.ellipsis,
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.blueAccent),
                            shape: const StadiumBorder(),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Row(
                          children: [
                            Checkbox(
                              value: _shareOnFacebook,
                              onChanged: (val) {
                                setState(() {
                                  _shareOnFacebook = val ?? false;
                                });
                              },
                              activeColor: Colors.blueAccent,
                            ),
                            Text(
                              'Share on Facebook',
                              style: GoogleFonts.poppins(color: Colors.black87),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            // Fixed Post button at the bottom
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: MediaQuery.of(context).viewInsets.bottom > 0
                      ? MediaQuery.of(context).viewInsets.bottom
                      : 24,
                  top: 8,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Implement post logic
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Post created (UI only)!'),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text('Post'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
