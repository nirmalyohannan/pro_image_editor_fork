// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:pro_image_editor/pro_image_editor.dart';

class WhatsappTextSizeSlider extends StatelessWidget {
  final TextEditorState textEditor;

  const WhatsappTextSizeSlider({
    super.key,
    required this.textEditor,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(
          right: 16,
          bottom: kBottomNavigationBarHeight,
        ),
        width: 16,
        height: min(
            280,
            MediaQuery.of(context).size.height -
                MediaQuery.of(context).viewInsets.bottom -
                kToolbarHeight -
                kBottomNavigationBarHeight -
                MediaQuery.of(context).padding.top),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'A',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            Flexible(
              child: RotatedBox(
                quarterTurns: 1,
                child: SliderTheme(
                  data: SliderThemeData(
                    overlayShape: SliderComponentShape.noThumb,
                  ),
                  child: StatefulBuilder(builder: (context, setState) {
                    return Slider(
                      onChanged: (value) {
                        textEditor.fontScale = 4.5 - value;
                        setState(() {});
                      },
                      min: 0.5,
                      max: 4,
                      value: max(0.5, min(4.5 - textEditor.fontScale, 4)),
                      thumbColor: Colors.white,
                      inactiveColor: Colors.white60,
                      activeColor: Colors.white60,
                    );
                  }),
                ),
              ),
            ),
            const Text(
              'A',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
