import 'package:flutter/material.dart';
import 'package:toktik/presentation/widgets/video/video_background.dart';
import 'package:video_player/video_player.dart';

class FullscreenPlayer extends StatefulWidget {
  final String videoUrl;
  final String caption;

  const FullscreenPlayer(
      {super.key, required this.videoUrl, required this.caption});

  @override
  State<FullscreenPlayer> createState() => _FullscreenPlayerState();
}

class _FullscreenPlayerState extends State<FullscreenPlayer> {
  late VideoPlayerController controller;

  // El stateful widget si tiene un ciclo de vida
  // Primero se inicializa
  @override
  void initState() {
    // Inicializacion comprimida de las propiedades .. para no hacer un controller.
    controller = VideoPlayerController.asset(widget.videoUrl)
      ..setVolume(0)
      ..setLooping(true)
      ..play();

    super.initState();
  }

  //Luego se destruye, simpre se respeta este ciclo
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // para acceder a las propiedades del statefulWidget
    // se instancia con widget.
    return FutureBuilder(
      future: controller.initialize(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          );
        }
        return GestureDetector(
          // Detector de gestos
          onTap: () {
            // Detectamos el tap en la pantalla
            if (controller.value.isPlaying) {
              controller.pause();
              return;
            }
            controller.play();
          },
          child: AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: Stack(children: [
              VideoPlayer(controller),

              // Gradiente
              const VideoBackground(stops: [0.8, 1.0]),
              // Texto
              Positioned(
                  bottom: 50,
                  left: 20,
                  child: _VideoCaption(caption: widget.caption)),
            ]),
          ),
        );
      },
    );
  }
}

class _VideoCaption extends StatelessWidget {
  final String caption;
  const _VideoCaption({required this.caption});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    return SizedBox(
        width: size.width * 0.6,
        child: Text(
          caption,
          maxLines: 2,
          style: titleStyle,
        ));
  }
}
