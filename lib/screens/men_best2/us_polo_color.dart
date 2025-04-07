import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopping_app/screens/men_best2/us_polo.dart';
import 'package:shopping_app/screens/women_best1/forever21.dart';
import 'package:shopping_app/screens/women_best1/vero_moda_screen.dart';

class GradientGenerator extends StatefulWidget {
  @override
  _GradientGeneratorState createState() => _GradientGeneratorState();
}

class _GradientGeneratorState extends State<GradientGenerator> {
  final List<Map<String, dynamic>> gradientSamples = [
    {'name': 'Sublime Vivid', 'colors': [Colors.red, Colors.blue]},
    {'name': 'Sublime Light', 'colors': [Colors.pink, Colors.purple]},
    {'name': 'Pun Y    Yeta', 'colors': [Colors.orange, Colors.brown]},
    {'name': 'Quepal', 'colors': [Colors.green, Colors.teal]},
    {'name': 'Sand to Blue', 'colors': [Colors.brown, Colors.blue]},
    {'name': 'Wedding Day Blues', 'colors': [Colors.cyan, Colors.blue]},
    {'name': 'Shifter', 'colors': [Colors.purple, Colors.red]},
    {'name': 'Red Sunset', 'colors': [Colors.red, Colors.orange]},
    {'name': 'Moon Purple', 'colors': [Colors.purple, Colors.indigo]},
    {'name': 'Pure Lust', 'colors': [Colors.red, Colors.pink]},
    {'name': 'Slight Ocean View', 'colors': [Colors.blue, Colors.lightBlue]},
    {'name': 'eXpresso', 'colors': [Colors.brown, Colors.black]},
  ];

  List<Color> selectedColors = [Colors.red, Colors.blue];
  GradientType selectedType = GradientType.linear;
  AlignmentGeometry begin = Alignment.centerLeft;
  AlignmentGeometry end = Alignment.centerRight;
  final ImagePicker _picker = ImagePicker();
  String? _imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PICK COLOR', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        actions: [
          TextButton(
            onPressed: () {
              // Feedback action
            },
            child: const Text(
              '',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          Container(
            width: 200,
            color: Colors.grey[200],
            child: ListView.builder(
              itemCount: gradientSamples.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(gradientSamples[index]['name']),
                  onTap: () {
                    setState(() {
                      selectedColors = List.from(gradientSamples[index]['colors']);
                    });
                  },
                );
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: _buildGradient(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text('Style:'),
                      DropdownButton<GradientType>(
                        value: selectedType,
                        items: GradientType.values.map((type) {
                          return DropdownMenuItem<GradientType>(
                            value: type,
                            child: Text(type.toString().split('.').last),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedType = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Direction:'),
                      IconButton(
                        icon: const Icon(Icons.arrow_left),
                        onPressed: () {
                          setState(() {
                            if (selectedType == GradientType.linear) {
                              begin = _rotateAlignment(begin, -45);
                              end = _rotateAlignment(end, -45);
                            }
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_upward),
                        onPressed: () {
                          setState(() {
                            if (selectedType == GradientType.linear) {
                              begin = _rotateAlignment(begin, 0);
                              end = _rotateAlignment(end, 0);
                            }
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_right),
                        onPressed: () {
                          setState(() {
                            if (selectedType == GradientType.linear) {
                              begin = _rotateAlignment(begin, 45);
                              end = _rotateAlignment(end, 45);
                            }
                          });
                        },
                      ),
                    ],
                  ),
                  const Text('Colors & Stops:'),
                  Row(
                    children: [
                      for (int i = 0; i < selectedColors.length; i++)
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                final Color? picked = await showDialog(
                                  context: context,
                                  builder: (context) => ColorPickerDialog(
                                    initialColor: selectedColors[i],
                                  ),
                                );
                                if (picked != null) {
                                  setState(() {
                                    selectedColors[i] = picked;
                                  });
                                }
                              },
                              child: Container(
                                width: 50,
                                height: 50,
                                color: selectedColors[i],
                              ),
                            ),
                            SizedBox(
                              width: 60,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(labelText: 'Stop ${i + 1}'),
                                onChanged: (value) {
                                  // Handle stop position (0-100)
                                },
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      gradient: _buildGradient(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Upload New Pattern',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () async {
                          final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                          if (image != null) {
                            setState(() {
                              _imagePath = image.path;
                            });
                          }
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                          child: _imagePath == null
                              ? const Center(
                            child: Icon(Icons.upload, size: 40, color: Colors.grey),
                          )
                              : Image.file(
                            File(_imagePath!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UsPolo(
                            selectedGradient: _buildGradient(),
                            uploadedImagePath: _imagePath,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Gradient _buildGradient() {
    switch (selectedType) {
      case GradientType.linear:
        return LinearGradient(
          colors: selectedColors,
          begin: begin,
          end: end,
        );
      case GradientType.radial:
        return RadialGradient(
          colors: selectedColors,
          center: Alignment.center,
          radius: 0.5,
        );
      case GradientType.sweep:
        return SweepGradient(
          colors: selectedColors,
          center: Alignment.center,
        );
      default:
        return LinearGradient(colors: selectedColors);
    }
  }

  AlignmentGeometry _rotateAlignment(AlignmentGeometry alignment, double degrees) {
    final angle = degrees * (math.pi / 180);
    if (alignment is Alignment) {
      final x = alignment.x * math.cos(angle) - alignment.y * math.sin(angle);
      final y = alignment.x * math.sin(angle) + alignment.y * math.cos(angle);
      return Alignment(x, y);
    }
    return alignment;
  }
}

enum GradientType { linear, radial, sweep }

class ColorPickerDialog extends StatelessWidget {
  final Color initialColor;

  const ColorPickerDialog({required this.initialColor});

  @override
  Widget build(BuildContext context) {
    Color selectedColor = initialColor;
    return AlertDialog(
      title: const Text('Pick a Color'),
      content: SingleChildScrollView(
        child: ColorPicker(
          pickerColor: selectedColor,
          onColorChanged: (color) => selectedColor = color,
          showLabel: true,
          pickerAreaHeightPercent: 0.8,
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: const Text('Select'),
          onPressed: () => Navigator.of(context).pop(selectedColor),
        ),
      ],
    );
  }
}

class Forever21Screen extends StatelessWidget {
  final Gradient selectedGradient;
  final String? uploadedImagePath;

  const Forever21Screen({
    required this.selectedGradient,
    this.uploadedImagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forever 21', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                gradient: selectedGradient,
              ),
            ),
            const SizedBox(height: 20),
            if (uploadedImagePath != null) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Image.file(
                  File(uploadedImagePath!),
                  height: 300,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 20),
            ],
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Back to Gradient Generator'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}