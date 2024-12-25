import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

T? _ambiguate<T>(T? value) => value;

class QuickToastOverlayEntry extends OverlayEntry {

	@override
	// ignore: overridden_fields
	final WidgetBuilder builder;

	QuickToastOverlayEntry({required this.builder,}) : super(builder: builder);

	@override
	void markNeedsBuild() {
		final scheduler = _ambiguate(SchedulerBinding.instance);
		if (scheduler == null) {
			throw StateError('SchedulerBinding.instance is null');
		}

		if (scheduler.schedulerPhase == SchedulerPhase.persistentCallbacks) {
			scheduler.addPostFrameCallback((_) {
				super.markNeedsBuild();
			});
		} else {
			super.markNeedsBuild();
		}
	}
}
