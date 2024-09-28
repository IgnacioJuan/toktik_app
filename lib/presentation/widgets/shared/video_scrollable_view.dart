import 'package:flutter/material.dart';

import 'package:toktik/domain/entities/video_post.dart';
import 'package:toktik/presentation/widgets/shared/video_player/videoButtons.dart';
import 'package:toktik/presentation/widgets/video/fullscreen_player.dart';

class VideoScrollableView extends StatelessWidget {
  final List<VideoPost> videos;

  const VideoScrollableView({super.key, required this.videos});

  @override
  Widget build(BuildContext context) {
    // Se usa builder en el pageView para poder controlar la renderizacion de los hijos
    // En el caso de la app, es necesarioa para hacer carga perezosa de los videos
    //

    return PageView.builder(
      scrollDirection: Axis.vertical,
      // Para que funcione en android
      physics: const BouncingScrollPhysics(),

      itemCount: videos.length,
      itemBuilder: (context, index) {
        final VideoPost videoPost = videos[index];

        return Stack(
          children: [
            // Video Playre + gradiente

            SizedBox.expand(
              child: FullscreenPlayer(
                videoUrl: videoPost.videoUrl,
                caption: videoPost.caption,
              ),
            ),
            // Botones:
            // Trabaja junto al stack para definir la posicion del hijo
            Positioned(
                bottom: 10, right: 10, child: Videobuttons(video: videoPost))
          ],
        );
      },
    );
  }
}
