import '../../project_export/project_export.dart';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({super.key, required this.onPickImage});

  final void Function(File selectedImage) onPickImage;

  @override
  State<ImagePickerWidget> createState() => _ImageFickerState();
}

class _ImageFickerState extends State<ImagePickerWidget> {
  File? _pickedImageFile;


  void _pickImage() async {
     final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 50 , maxWidth: 150);

     if(pickedImage == null) {
       return;
     }
     setState(() {
       _pickedImageFile = File(pickedImage.path);
     });

     widget.onPickImage(_pickedImageFile!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          foregroundImage: _pickedImageFile != null ? FileImage(_pickedImageFile!) : null,
        ),
        const SizedBox(
          height: 5,
        ),
        TextButton.icon(
          onPressed: _pickImage,
          icon: const Icon(Icons.image),
          label: Text(
            'Add image',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
