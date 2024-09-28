import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toktik/presentation/providers/discover_provider.dart';
import 'package:toktik/presentation/widgets/shared/video_scrollable_view.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Referencia al provider
    final discoverProvider = context.watch<DiscoverProvider>();

    return Scaffold(
        // Usando el provider, extraemos e estado de loaading
        // si esta en true se muestra un loading si no se muestra los videos
        body: discoverProvider.initialLoading
            ? const Center(
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : VideoScrollableView(videos: discoverProvider.videos));
  }
}
