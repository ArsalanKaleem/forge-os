import 'package:flutter/material.dart';

/// Gently pulsing placeholder block — the building brick of loading states.
class SkeletonBox extends StatefulWidget {
  const SkeletonBox({
    super.key,
    this.width = double.infinity,
    this.height = 14,
    this.radius = 8,
  });

  final double width;
  final double height;
  final double radius;

  @override
  State<SkeletonBox> createState() => _SkeletonBoxState();
}

class _SkeletonBoxState extends State<SkeletonBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1300),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final base = scheme.surfaceContainerHigh;
    final highlight = scheme.surfaceContainerHighest;

    // Shimmer sweep rather than a simple fade — reads as more premium.
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.radius),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final t = _controller.value;
          return Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.radius),
              gradient: LinearGradient(
                begin: Alignment(-1 - 2 * (1 - t), 0),
                end: Alignment(1 - 2 * (1 - t), 0),
                colors: [base, highlight, base],
                stops: const [0.35, 0.5, 0.65],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Card-shaped skeleton matching [RepoCard] / [IssueCard] proportions.
class SkeletonCard extends StatelessWidget {
  const SkeletonCard({super.key, this.height = 160});
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: const [
                SkeletonBox(width: 34, height: 34, radius: 17),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SkeletonBox(width: 80, height: 9),
                      SizedBox(height: 6),
                      SkeletonBox(width: 150, height: 15),
                    ],
                  ),
                ),
              ]),
              const SizedBox(height: 16),
              const SkeletonBox(height: 11),
              const SizedBox(height: 8),
              const SkeletonBox(width: 220, height: 11),
              const Spacer(),
              Row(children: const [
                SkeletonBox(width: 52, height: 11),
                SizedBox(width: 16),
                SkeletonBox(width: 52, height: 11),
                SizedBox(width: 16),
                SkeletonBox(width: 64, height: 11),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}

/// Grid/list of skeleton cards used while first page loads.
class SkeletonGrid extends StatelessWidget {
  const SkeletonGrid({super.key, this.count = 6});
  final int count;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 440,
        mainAxisExtent: 186,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
      ),
      itemCount: count,
      itemBuilder: (_, __) => const SkeletonCard(),
    );
  }
}