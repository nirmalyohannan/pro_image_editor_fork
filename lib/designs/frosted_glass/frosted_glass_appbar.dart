// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:pro_image_editor/designs/frosted_glass/frosted_glass.dart';
import 'package:pro_image_editor/designs/frosted_glass/frosted_glass_effect.dart';
import 'package:pro_image_editor/pro_image_editor.dart';

class FrostedGlassActionBar extends StatefulWidget {
  /// The configuration for the image editor.
  final ProImageEditorState editor;

  final Function() openStickerEditor;

  const FrostedGlassActionBar({
    super.key,
    required this.editor,
    required this.openStickerEditor,
  });

  @override
  State<FrostedGlassActionBar> createState() => _FrostedGlassActionBarState();
}

class _FrostedGlassActionBarState extends State<FrostedGlassActionBar> {
  final Color _foregroundColor = const Color(0xFFFFFFFF);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Hero(
                    tag: 'frosted-glass-close-btn',
                    child: FrostedGlassEffect(
                      child: IconButton(
                        tooltip: widget.editor.configs.i18n.cancel,
                        onPressed: widget.editor.closeEditor,
                        icon: Icon(widget.editor.configs.icons.closeEditor),
                        color: _foregroundColor,
                      ),
                    ),
                  ),
                  Hero(
                    tag: 'frosted-glass-top-center-bar',
                    child: FrostedGlassEffect(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      child: Row(
                        children: [
                          IconButton(
                            tooltip: widget.editor.configs.i18n.undo,
                            onPressed: widget.editor.undoAction,
                            icon: Icon(
                              widget.editor.configs.icons.undoAction,
                              color: widget.editor.canUndo
                                  ? _foregroundColor
                                  : _foregroundColor.withAlpha(80),
                            ),
                          ),
                          const SizedBox(width: 3),
                          IconButton(
                            tooltip: widget.editor.configs.i18n.redo,
                            onPressed: widget.editor.redoAction,
                            icon: Icon(
                              widget.editor.configs.icons.redoAction,
                              color: widget.editor.canRedo
                                  ? _foregroundColor
                                  : _foregroundColor.withAlpha(80),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Hero(
                    tag: 'frosted-glass-done-btn',
                    child: FrostedGlassEffect(
                      child: IconButton(
                        tooltip: widget.editor.configs.i18n.done,
                        onPressed: widget.editor.doneEditing,
                        icon: Icon(
                          widget.editor.configs.icons.doneIcon,
                          color: _foregroundColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (!widget.editor.isSubEditorOpen)
            Align(
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(
                key: const PageStorageKey('frosted_glass_main_bottombar'),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 24,
                ),
                scrollDirection: Axis.horizontal,
                child: FrostedGlassEffect(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 3,
                  ),
                  child: Wrap(
                    spacing: 12,
                    alignment: WrapAlignment.center,
                    children: [
                      if (widget.editor.configs.paintEditorConfigs.enabled)
                        IconButton(
                          tooltip: widget.editor.configs.i18n.paintEditor
                              .bottomNavigationBarText,
                          onPressed: widget.editor.openPaintingEditor,
                          icon: Icon(widget.editor.configs.icons.paintingEditor
                              .bottomNavBar),
                        ),
                      if (widget.editor.configs.textEditorConfigs.enabled)
                        IconButton(
                          tooltip: widget.editor.configs.i18n.textEditor
                              .bottomNavigationBarText,
                          onPressed: () => widget.editor.openTextEditor(
                            duration: const Duration(milliseconds: 150),
                          ),
                          icon: Icon(widget
                              .editor.configs.icons.textEditor.bottomNavBar),
                        ),
                      if (widget.editor.configs.cropRotateEditorConfigs.enabled)
                        IconButton(
                          tooltip: widget.editor.configs.i18n.cropRotateEditor
                              .bottomNavigationBarText,
                          onPressed: widget.editor.openCropRotateEditor,
                          icon: Icon(widget.editor.configs.icons
                              .cropRotateEditor.bottomNavBar),
                        ),
                      if (widget.editor.configs.filterEditorConfigs.enabled)
                        IconButton(
                          tooltip: widget.editor.configs.i18n.filterEditor
                              .bottomNavigationBarText,
                          onPressed: widget.editor.openFilterEditor,
                          icon: Icon(widget
                              .editor.configs.icons.filterEditor.bottomNavBar),
                        ),
                      if (widget.editor.configs.blurEditorConfigs.enabled)
                        IconButton(
                          tooltip: widget.editor.configs.i18n.blurEditor
                              .bottomNavigationBarText,
                          onPressed: widget.editor.openBlurEditor,
                          icon: Icon(widget
                              .editor.configs.icons.blurEditor.bottomNavBar),
                        ),
                      if (widget.editor.configs.stickerEditorConfigs?.enabled ==
                              true ||
                          widget.editor.configs.emojiEditorConfigs.enabled)
                        IconButton(
                          key: const ValueKey(
                              'whatsapp-open-sticker-editor-btn'),
                          tooltip: widget.editor.configs.i18n.stickerEditor
                              .bottomNavigationBarText,
                          onPressed: widget.openStickerEditor,
                          icon: Icon(widget
                              .editor.configs.icons.stickerEditor.bottomNavBar),
                        ),
                    ],
                  ),
                ),
              ),
            )
          /*  AnimatedSwitcher(
                  duration: const Duration(milliseconds: 150),
                  transitionBuilder: (child, animation) => ScaleTransition(
                    scale: animation,
                    child: FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                  ),
                  child: widget.editor.canUndo
                      ?IconButton(
                          tooltip: widget.editor.configs.i18n.undo,
                          onPressed: widget.editor.undoAction,
                          icon: Icon(widget.editor.configs.icons.undoAction),
                         
                        )
                      : const SizedBox.shrink(),
                ),
             */
        ],
      ),
    );
  }
}
