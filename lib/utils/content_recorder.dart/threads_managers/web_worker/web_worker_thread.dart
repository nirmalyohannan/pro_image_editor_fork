// ignore_for_file: avoid_web_libraries_in_flutter

// Dart imports:
import 'dart:async';
import 'dart:html' as html;

// Flutter imports:
import 'package:flutter/rendering.dart';

// Project imports:
import 'package:pro_image_editor/models/multi_threading/thread_request_model.dart';
import 'package:pro_image_editor/models/multi_threading/thread_response_model.dart';
import 'package:pro_image_editor/utils/content_recorder.dart/threads_managers/threads/thread.dart';

class WebWorkerThread extends Thread {
  final String _workerUrl =
      'assets/packages/pro_image_editor/lib/web/web_worker.dart.js';

  late final html.Worker worker;

  WebWorkerThread({
    required super.onMessage,
  });

  @override
  void init() {
    try {
      if (html.Worker.supported) {
        worker = html.Worker(_workerUrl);
        worker.onMessage.listen((event) {
          var data = event.data;
          if (data?['id'] != null) {
            activeTasks--;
            onMessage(ThreadResponse(
              bytes: data['bytes'],
              id: data['id'],
            ));
          }
        });
        readyState.complete(true);
        isReady = true;
      } else {
        debugPrint('Your browser doesn\'t support web workers.');
        readyState.complete(false);
      }
    } catch (e) {
      if (readyState.isCompleted) readyState = Completer();
      readyState.complete(false);
    }
  }

  @override
  void send(ThreadRequest data) {
    activeTasks++;

    worker.postMessage({
      'mode': data is ImageConvertThreadRequest ? 'convert' : 'encode',
      'id': data.id,
      'generateOnlyImageBounds': data is ImageConvertThreadRequest
          ? data.generateOnlyImageBounds
          : null,
      'outputFormat': data.outputFormat.name,
      'jpegChroma': data.jpegChroma.name,
      'pngFilter': data.pngFilter.name,
      'jpegQuality': data.jpegQuality,
      'pngLevel': data.pngLevel,
      'singleFrame': data.singleFrame,
      'image': {
        'buffer': data.image.buffer,
        'width': data.image.width,
        'height': data.image.height,
        'textData': data.image.textData,
        'frameDuration': data.image.frameDuration,
        'frameIndex': data.image.frameIndex,
        'loopCount': data.image.loopCount,
        'numChannels': data.image.numChannels,
        'rowStride': data.image.rowStride,
        'frameType': data.image.frameType.name,
        'format': data.image.format.name,
        // 'exif': data.image.exif,
        // 'palette': data.image.palette,
        // 'backgroundColor': data.image.backgroundColor,
      }
    });
  }

  @override
  void destroyActiveTasks(String ignoreTaskId) async {
    worker.postMessage({
      'mode': 'destroyActiveTasks',
      'ignoreTaskId': ignoreTaskId,
    });
  }

  @override
  void destroy() {
    worker.postMessage({'mode': 'kill'});
    worker.terminate();
  }
}
