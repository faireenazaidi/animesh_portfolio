import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

// ignore: avoid_web_libraries_in_flutter
import 'dart:ui_web' as ui_web;
// ignore: avoid_web_libraries_in_flutter, deprecated_member_use
import 'dart:html' as html;

class UniversalVideoAvatar extends StatefulWidget {
  final double width;
  final double height;

  const UniversalVideoAvatar({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  State<UniversalVideoAvatar> createState() => _UniversalVideoAvatarState();
}

class _UniversalVideoAvatarState extends State<UniversalVideoAvatar> {
  static final String _viewId = 'avatar-video-view-${DateTime.now().millisecondsSinceEpoch}';
  static bool _registered = false;
  VideoPlayerController? _mobileController;
  bool _isMobileInitialized = false;

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      if (!_registered) {
        ui_web.platformViewRegistry.registerViewFactory(_viewId, (int viewId) {
          final video = html.VideoElement()
            ..autoplay = true
            ..loop = true
            ..muted = true
            ..src = 'avatar.mp4'
            ..style.width = '100%'
            ..style.height = '100%'
            ..style.objectFit = 'contain'
            ..style.background = 'transparent'
            ..style.backgroundColor = 'transparent'
            ..style.border = 'none'
            ..style.outline = 'none'
            ..style.pointerEvents = 'none';

          video.setAttribute('playsinline', 'true');
          video.setAttribute('webkit-playsinline', 'true');
          video.setAttribute('muted', 'true');
          video.setAttribute('autoplay', 'true');
          video.setAttribute('loop', 'true');

          // Smooth bottom fade using standard CSS mask
          video.style.setProperty('-webkit-mask-image',
              'linear-gradient(to bottom, rgba(0,0,0,1) 80%, rgba(0,0,0,0) 100%)');
          video.style.setProperty('mask-image',
              'linear-gradient(to bottom, rgba(0,0,0,1) 80%, rgba(0,0,0,0) 100%)');

          // Fallback if avatar.mp4 directly needs assets/ prefix
          video.onError.listen((_) {
            if (!video.src.contains('assets/')) {
              video.src = 'assets/avatar.mp4';
              video.load();
              video.play();
            }
          });

          video.load();
          video.play().catchError((_) {
            // Autoplay policy handled with muted
          });

          return video;
        });
        _registered = true;
      }
    } else {
      try {
        _mobileController = VideoPlayerController.asset('assets/avatar.mp4')
          ..initialize().then((_) {
            _mobileController?.setLooping(true);
            _mobileController?.setVolume(0.0);
            _mobileController?.play();
            if (mounted) {
              setState(() {
                _isMobileInitialized = true;
              });
            }
          }).catchError((_) {});
      } catch (_) {}
    }
  }

  @override
  void dispose() {
    _mobileController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return SizedBox(
        width: widget.width,
        height: widget.height,
        child: HtmlElementView(
          viewType: _viewId,
        ),
      );
    }

    if (_isMobileInitialized && _mobileController != null) {
      return SizedBox(
        width: widget.width,
        height: widget.height,
        child: FittedBox(
          fit: BoxFit.contain,
          child: SizedBox(
            width: _mobileController!.value.size.width,
            height: _mobileController!.value.size.height,
            child: VideoPlayer(_mobileController!),
          ),
        ),
      );
    }

    return SizedBox(
      width: widget.width,
      height: widget.height,
    );
  }
}
