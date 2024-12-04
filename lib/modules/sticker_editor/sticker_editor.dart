// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:pro_image_editor/pro_image_editor.dart';
import '../../mixins/converted_configs.dart';
import '../../mixins/editor_configs_mixin.dart';

/// The `StickerEditor` class is responsible for creating a widget that allows users to select emojis.
///
/// This widget provides an EmojiPicker that allows users to choose emojis, which are then returned
/// as `EmojiLayerData` containing the selected emoji text.
class StickerEditor extends StatefulWidget with SimpleConfigsAccess {
  @override
  final ProImageEditorConfigs configs;

  @override
  final ProImageEditorCallbacks callbacks;

  final ScrollController scrollController;

  /// Creates an `StickerEditor` widget.
  const StickerEditor({
    super.key,
    required this.configs,
    this.callbacks = const ProImageEditorCallbacks(),
    required this.scrollController,
  });

  @override
  createState() => StickerEditorState();
}

/// The state class for the `StickerEditor` widget.
class StickerEditorState extends State<StickerEditor>
    with ImageEditorConvertedConfigs, SimpleConfigsAccessState {
  /// Closes the editor without applying changes.
  void close() {
    Navigator.pop(context);
  }

  @override
  void initState() {
    callbacks.stickerEditorCallbacks?.onInit?.call();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      callbacks.stickerEditorCallbacks?.onAfterViewInit?.call();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.configs.stickerEditorConfigs!
        .buildStickers(setLayer, widget.scrollController);
  }

  void setLayer(Widget sticker) {
    Navigator.of(context).pop(
      StickerLayerData(sticker: sticker),
    );
  }
}
