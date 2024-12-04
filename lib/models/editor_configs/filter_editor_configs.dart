// Project imports:
import 'package:pro_image_editor/modules/filter_editor/utils/filter_generator/filter_model.dart';

/// Configuration options for a filter editor.
///
/// `FilterEditorConfigs` allows you to define settings for a filter editor,
/// including whether the editor is enabled and a list of filter generators.
///
/// Example usage:
/// ```dart
/// FilterEditorConfigs(
///   enabled: true,
///   filterList: [
///     ColorFilterGenerator.contrast(1.5),
///     ColorFilterGenerator.brightness(0.7),
///   ],
/// );
/// ```
class FilterEditorConfigs {
  /// Indicates whether the filter editor is enabled.
  final bool enabled;

  /// Show also layers in the editor.
  final bool showLayers;

  /// A list of color filter generators to apply to an image.
  final List<FilterModel>? filterList;

  /// Creates an instance of FilterEditorConfigs with optional settings.
  ///
  /// By default, the editor is enabled, and the filter list contains all filters.
  const FilterEditorConfigs({
    this.enabled = true,
    this.showLayers = true,
    this.filterList,
  });
}
