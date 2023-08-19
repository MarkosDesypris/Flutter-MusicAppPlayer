// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';

class SeekBarWidget extends StatefulWidget {
  final Duration position;
  final Duration duration;
  final ValueChanged<Duration>? onChanged;
  final ValueChanged<Duration>? onChangedEnd;

  const SeekBarWidget({
    super.key,
    required this.position,
    required this.duration,
    this.onChanged,
    this.onChangedEnd,
  });

  @override
  State<SeekBarWidget> createState() => _SeekBarWidgetState();
}

class _SeekBarWidgetState extends State<SeekBarWidget> {
  double? _dragValue;

  String _formatDuration(Duration? duration) {
    if (duration == null) {
      return '--:--';
    } else {
      String minutes = duration.inMinutes.toString().padLeft(2, '0');
      String seconds =
          duration.inSeconds.remainder(60).toString().padLeft(2, '0');
      return '$minutes:$seconds';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(_formatDuration(widget.position)),
        Expanded(
          child: SliderTheme(
            data: Theme.of(context).sliderTheme.copyWith(
                  trackHeight: 4,
                  thumbShape: const RoundSliderThumbShape(
                    disabledThumbRadius: 4,
                    enabledThumbRadius: 4,
                  ),
                  overlayShape: const RoundSliderOverlayShape(
                    overlayRadius: 10,
                  ),
                  activeTrackColor: Colors.white,
                  inactiveTrackColor: Colors.white.withOpacity(0.2),
                  thumbColor: Colors.white,
                  overlayColor: Colors.white,
                ),
            child: Slider(
              min: 0.0,
              max: widget.duration.inMilliseconds.toDouble(),
              value: min(
                _dragValue ?? widget.position.inMilliseconds.toDouble(),
                widget.duration.inMilliseconds.toDouble(),
              ),
              onChanged: (value) {
                setState(() {
                  _dragValue = value;
                });
                if (widget.onChanged != null) {
                  widget.onChanged!(Duration(milliseconds: value.round()));
                }
              },
              onChangeEnd: (value) {
                if (widget.onChangedEnd != null) {
                  widget.onChangedEnd!(Duration(milliseconds: value.round()));
                }
                _dragValue = null;
              },
            ),
          ),
        ),
        Text(_formatDuration(widget.duration - widget.position)),
      ],
    );
  }
}
