import 'package:flutter/material.dart';

class FABOption {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  FABOption({required this.icon, required this.label, required this.onTap});
}

class ExpandableFAB extends StatefulWidget {
  final List<FABOption> options;
  const ExpandableFAB({required this.options, super.key});

  @override
  State<ExpandableFAB> createState() => _ExpandableFABState();
}

class _ExpandableFABState extends State<ExpandableFAB>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _expanded = !_expanded;
      if (_expanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        ...List.generate(widget.options.length, (i) {
          final option = widget.options[i];
          return AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            right: 0,
            bottom: 70.0 * (i + 1) * (_expanded ? 1 : 0),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 250),
              opacity: _expanded ? 1 : 0,
              child: Tooltip(
                message: option.label,
                child: FloatingActionButton(
                  heroTag: option.label,
                  mini: true,
                  backgroundColor: Colors.black,
                  onPressed: () {
                    _toggle();
                    option.onTap();
                  },
                  child: Icon(option.icon, color: Colors.white),
                ),
              ),
            ),
          );
        }),
        FloatingActionButton(
          backgroundColor: const Color(0xFF00BF6D),
          onPressed: _toggle,
          child: AnimatedRotation(
            turns: _expanded ? 0.125 : 0,
            duration: const Duration(milliseconds: 250),
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
