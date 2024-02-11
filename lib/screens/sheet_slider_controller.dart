import 'package:commet_sheet/screens/sheet_slider.dart';

class SliderSheetController {
  SliderSheetState? _state;
  void expand() {
    state.expand();
  }

  void collapse() {
    state.collapse();
  }

  void toggle() {
    state.toggle();
  }

  bool get isExpanded => state.isExpanded;

  SliderSheetState get state {
    assert(
      _state != null,
      'Controller not attached to any SheetSlider. Did you forget to pass the controller to the SheetSlider?',
    );
    return _state!;
  }

  set state(SliderSheetState? value) => _state = value;
}
