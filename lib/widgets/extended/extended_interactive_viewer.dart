import 'package:flutter/widgets.dart';

/// A widget that provides interactive viewing capabilities with zoom and pan functionality.
///
/// The [ExtendedInteractiveViewer] wraps a given child widget and allows users to
/// interact with it through zooming and panning. The interactivity can be enabled
/// or disabled, and the zoom levels can be controlled with [minScale] and [maxScale].
///
/// Example usage:
/// ```dart
/// ExtendedInteractiveViewer(
///   editorIsZoomable: true,
///   enableInteraction: true,
///   minScale: 0.5,
///   maxScale: 3.0,
///   child: YourWidget(),
/// );
/// ```
///
/// The [ExtendedInteractiveViewer] requires the following parameters:
/// - [child]: The widget to be displayed and interacted with.
/// - [editorIsZoomable]: A boolean indicating whether zoom functionality is enabled.
/// - [minScale]: The minimum scale factor for zooming.
/// - [maxScale]: The maximum scale factor for zooming.
///
/// Optionally, you can control the interactivity using [enableInteraction].
class ExtendedInteractiveViewer extends StatefulWidget {
  /// The child widget to be displayed and interacted with.
  final Widget child;

  /// Indicates whether the editor supports zoom functionality.
  ///
  /// When set to `true`, the editor allows users to zoom in and out. If set to
  /// `false`, the content remains at a fixed scale.
  final bool editorIsZoomable;

  /// Indicates whether user interactions such as panning and zooming are enabled.
  ///
  /// Default value is `true`.
  final bool enableInteraction;

  /// The minimum scale factor for zooming.
  ///
  /// This determines the lowest level of zoom that can be applied to the child
  /// widget, ensuring content remains usable.
  final double minScale;

  /// The maximum scale factor for zooming.
  ///
  /// This determines the highest level of zoom that can be applied to the child
  /// widget.
  final double maxScale;

  /// Called when the user ends a pan or scale gesture on the widget.
  ///
  /// At the time this is called, the [TransformationController] will have
  /// already been updated to reflect the change caused by the interaction,
  /// though a pan may cause an inertia animation after this is called as well.
  ///
  /// {@template flutter.widgets.InteractiveViewer.onInteractionEnd}
  /// Will be called even if the interaction is disabled with [panEnabled] or
  /// [scaleEnabled] for both touch gestures and mouse interactions.
  ///
  /// A [GestureDetector] wrapping the InteractiveViewer will not respond to
  /// [GestureDetector.onScaleStart], [GestureDetector.onScaleUpdate], and
  /// [GestureDetector.onScaleEnd]. Use [onInteractionStart],
  /// [onInteractionUpdate], and [onInteractionEnd] to respond to those
  /// gestures.
  /// {@endtemplate}
  ///
  /// See also:
  ///
  ///  * [onInteractionStart], which handles the start of the same interaction.
  ///  * [onInteractionUpdate], which handles an update to the same interaction.
  final GestureScaleEndCallback? onInteractionEnd;

  /// Called when the user begins a pan or scale gesture on the widget.
  ///
  /// At the time this is called, the [TransformationController] will not have
  /// changed due to this interaction.
  ///
  /// {@macro flutter.widgets.InteractiveViewer.onInteractionEnd}
  ///
  /// The coordinates provided in the details' `focalPoint` and
  /// `localFocalPoint` are normal Flutter event coordinates, not
  /// InteractiveViewer scene coordinates. See
  /// [TransformationController.toScene] for how to convert these coordinates to
  /// scene coordinates relative to the child.
  ///
  /// See also:
  ///
  ///  * [onInteractionUpdate], which handles an update to the same interaction.
  ///  * [onInteractionEnd], which handles the end of the same interaction.
  final GestureScaleStartCallback? onInteractionStart;

  /// Called when the user updates a pan or scale gesture on the widget.
  ///
  /// At the time this is called, the [TransformationController] will have
  /// already been updated to reflect the change caused by the interaction, if
  /// the interaction caused the matrix to change.
  ///
  /// {@macro flutter.widgets.InteractiveViewer.onInteractionEnd}
  ///
  /// The coordinates provided in the details' `focalPoint` and
  /// `localFocalPoint` are normal Flutter event coordinates, not
  /// InteractiveViewer scene coordinates. See
  /// [TransformationController.toScene] for how to convert these coordinates to
  /// scene coordinates relative to the child.
  ///
  /// See also:
  ///
  ///  * [onInteractionStart], which handles the start of the same interaction.
  ///  * [onInteractionEnd], which handles the end of the same interaction.
  final GestureScaleUpdateCallback? onInteractionUpdate;

  /// Creates an [ExtendedInteractiveViewer] with the given parameters.
  const ExtendedInteractiveViewer({
    super.key,
    required this.child,
    this.enableInteraction = true,
    required this.editorIsZoomable,
    required this.minScale,
    required this.maxScale,
    required this.onInteractionStart,
    required this.onInteractionUpdate,
    required this.onInteractionEnd,
  });

  @override
  State<ExtendedInteractiveViewer> createState() =>
      ExtendedInteractiveViewerState();
}

/// The state for [ExtendedInteractiveViewer], managing the interactivity state.
class ExtendedInteractiveViewerState extends State<ExtendedInteractiveViewer> {
  late TransformationController _transformCtrl;
  late bool _enableInteraction;

  @override
  void initState() {
    _transformCtrl = TransformationController();
    _enableInteraction = widget.enableInteraction;
    super.initState();
  }

  /// Sets the interaction state to the given value and updates the UI accordingly.
  void setEnableInteraction(bool value) {
    if (_enableInteraction != value) {
      _enableInteraction = value;
      setState(() {});
    }
  }

  double get scaleFactor {
    return _transformCtrl.value.getMaxScaleOnAxis();
  }

  Offset get offset {
    return Offset(
      _transformCtrl.value.getTranslation().x,
      _transformCtrl.value.getTranslation().y,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.editorIsZoomable) return widget.child;

    /// If we disable the interaction we need to return it as Transform widget
    /// that the InteractiveViewer will not absorb the scale events.
    if (!_enableInteraction) {
      return Transform(
        transform: _transformCtrl.value,
        child: widget.child,
      );
    }

    return InteractiveViewer(
      transformationController: _transformCtrl,
      panEnabled: _enableInteraction,
      scaleEnabled: _enableInteraction,
      minScale: widget.minScale,
      maxScale: widget.maxScale,
      onInteractionStart: widget.onInteractionStart,
      onInteractionUpdate: widget.onInteractionUpdate,
      onInteractionEnd: widget.onInteractionEnd,
      child: widget.child,
    );
  }
}
