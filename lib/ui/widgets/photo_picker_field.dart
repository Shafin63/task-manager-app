import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoPickerField extends StatelessWidget {
  const PhotoPickerField({super.key, required this.onTap, this.selectedPhoto});

  final VoidCallback onTap;
  final XFile? selectedPhoto;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          spacing: 20,
          children: [
            Container(
              width: 80,
              height: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                color: Colors.black54,
              ),
              alignment: Alignment.center,
              child: Text("Photo", style: TextStyle(color: Colors.white)),
            ),
            Expanded(
              child: Text(
                selectedPhoto == null
                    ? "No Photo Selected"
                    : selectedPhoto!.name,
                maxLines: 1,
                style: TextStyle(overflow: TextOverflow.ellipsis),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
