import 'package:flutter/material.dart';

import '../quick_toast.dart';
import './overlay_entry.dart';


class QuickToastLoading extends StatefulWidget {
    final Widget? child;

    const QuickToastLoading({super.key, required this.child, })  : assert(child != null);
    
    @override
    State<StatefulWidget> createState() =>  _QuickToastLoadingState();

}

class _QuickToastLoadingState extends State<QuickToastLoading> {

    late QuickToastOverlayEntry _overlayEntry;

    @override
    void initState() {
    super.initState();
        _overlayEntry = QuickToastOverlayEntry(
            builder: (BuildContext context) => QuickToast.instance.w ?? Container(),
        );
        QuickToast.instance.overlayEntry = _overlayEntry;
    }

    @override
    Widget build(BuildContext context) {
        return Material(
            child: Overlay(
                initialEntries: [
                    QuickToastOverlayEntry(
                        builder: (BuildContext context) {
                            if (widget.child != null) {
                                return widget.child!;
                            } else {
                                return Container();
                            }
                        },
                    ),
                    _overlayEntry,
                ],
            ),
        );
    }
}
