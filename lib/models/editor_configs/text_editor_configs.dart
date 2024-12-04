// Flutter imports:
import 'package:flutter/widgets.dart';

// Project imports:
import '../layer/layer_background_mode.dart';

/// Configuration options for a text editor.
///
/// `TextEditorConfigs` allows you to define settings for a text editor,
/// including whether the editor is enabled, which text formatting options
/// are available, and the initial font size.
///
/// Example usage:
/// ```dart
/// TextEditorConfigs(
///   enabled: true,
///   canToggleTextAlign: true,
///   canToggleBackgroundMode: true,
///   initFontSize: 24.0,
/// );
/// ```
class TextEditorConfigs {
  /// Indicates whether the text editor is enabled.
  final bool enabled;

  /// Determines if the text alignment options can be toggled.
  final bool canToggleTextAlign;

  /// Determines if the font scale can be change.
  final bool canChangeFontScale;

  /// Determines if the editor show a bottom bar where the user can select
  /// different font styles.
  final bool showSelectFontStyleBottomBar;

  /// Determines if the background mode can be toggled.
  final bool canToggleBackgroundMode;

  /// The initial font size for text.
  final double initFontSize;

  /// The initial text alignment for the layer.
  final TextAlign initialTextAlign;

  /// The initial font scale for text.
  final double initFontScale;

  /// The max font font scale for text.
  final double maxFontScale;

  /// The min font font scale for text.
  final double minFontScale;

  /// The initial background color mode for the layer.
  final LayerBackgroundMode initialBackgroundColorMode;

  /// Allow users to select a different font style
  final List<TextStyle>? customTextStyles;

  /// The minimum scale factor from the layer.
  final double minScale;

  /// The maximum scale factor from the layer.
  final double maxScale;

  /// Whether to show input suggestions as the user types.
  ///
  /// This flag only affects Android. On iOS, suggestions are tied directly to
  /// [autocorrect], so that suggestions are only shown when [autocorrect] is
  /// true. On Android autocorrection and suggestion are controlled separately.
  ///
  /// Defaults to true.
  final bool enableSuggestions;

  /// Whether to enable autocorrection.
  ///
  /// Defaults to true.
  final bool autocorrect;

  /// Creates an instance of TextEditorConfigs with optional settings.
  ///
  /// By default, the text editor is enabled, and most text formatting options
  /// are enabled. The initial font size is set to 24.0.
  const TextEditorConfigs({
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.enabled = true,
    this.showSelectFontStyleBottomBar = false,
    this.canToggleTextAlign = true,
    this.canToggleBackgroundMode = true,
    this.canChangeFontScale = true,
    this.initFontSize = 24.0,
    this.initialTextAlign = TextAlign.center,
    this.initFontScale = 1.0,
    this.maxFontScale = 3.0,
    this.minFontScale = 0.3,
    this.minScale = double.negativeInfinity,
    this.maxScale = double.infinity,
    this.customTextStyles,
    this.initialBackgroundColorMode = LayerBackgroundMode.backgroundAndColor,
  })  : assert(initFontSize > 0, 'initFontSize must be positive'),
        assert(maxScale >= minScale,
            'maxScale must be greater than or equal to minScale');
}
