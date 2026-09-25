import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// Animated constellation background: drifting nodes connected by faint lines,
/// with a subtle parallax response to the pointer.
class ParticleBackground extends StatefulWidget {
  const ParticleBackground({super.key, this.count = 55});
  final int count;

  @override
  State<ParticleBackground> createState() => _ParticleBackgroundState();
}

class _ParticleBackgroundState extends State<ParticleBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final List<_Particle> _particles = [];
  final _rng = math.Random(42);
  Offset _pointer = Offset.zero;

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.count; i++) {
      _particles.add(_Particle(
        pos: Offset(_rng.nextDouble(), _rng.nextDouble()),
        vel: Offset((_rng.nextDouble() - .5) * .0006, (_rng.nextDouble() - .5) * .0006),
        radius: 1 + _rng.nextDouble() * 1.8,
      ));
    }
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1))
      ..addListener(_tick)
      ..repeat();
  }

  void _tick() {
    for (final p in _particles) {
      var next = p.pos + p.vel;
      var vel = p.vel;
      if (next.dx < 0 || next.dx > 1) vel = Offset(-vel.dx, vel.dy);
      if (next.dy < 0 || next.dy > 1) vel = Offset(vel.dx, -vel.dy);
      p.vel = vel;
      p.pos = Offset(next.dx.clamp(0, 1), next.dy.clamp(0, 1));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      opaque: false,
      onHover: (e) => _pointer = e.localPosition,
      child: RepaintBoundary(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (_, __) => CustomPaint(
            painter: _ParticlePainter(_particles, _pointer),
            size: Size.infinite,
          ),
        ),
      ),
    );
  }
}

class _Particle {
  _Particle({required this.pos, required this.vel, required this.radius});
  Offset pos;
  Offset vel;
  final double radius;
}

class _ParticlePainter extends CustomPainter {
  _ParticlePainter(this.particles, this.pointer);
  final List<_Particle> particles;
  final Offset pointer;

  @override
  void paint(Canvas canvas, Size size) {
    final dot = Paint()..color = AppColors.primary.withValues(alpha: .55);
    final line = Paint()..strokeWidth = 1;
    const linkDist = 140.0;

    final pts = particles.map((p) {
      final base = Offset(p.pos.dx * size.width, p.pos.dy * size.height);
      final dx = (pointer.dx - base.dx) / size.width;
      final dy = (pointer.dy - base.dy) / size.height;
      return base - Offset(dx * 12, dy * 12);
    }).toList();

    for (var i = 0; i < pts.length; i++) {
      for (var j = i + 1; j < pts.length; j++) {
        final d = (pts[i] - pts[j]).distance;
        if (d < linkDist) {
          line.color = AppColors.secondary.withValues(alpha: (1 - d / linkDist) * .18);
          canvas.drawLine(pts[i], pts[j], line);
        }
      }
    }
    for (var i = 0; i < pts.length; i++) {
      canvas.drawCircle(pts[i], particles[i].radius, dot);
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter old) => true;
}
