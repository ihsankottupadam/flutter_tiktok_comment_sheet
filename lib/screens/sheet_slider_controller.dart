import 'sheet_slider.dart';

class SheetSliderController {
  SheetSliderState? _state;
  void expand() {
    state.expand();
  }

  void collapse() {
    state.collapse();
  }

  void toggle() {
    state.toggle();
  }

  SheetSliderState get state {
    assert(
      _state != null,
      'Controller not attached to any SheetSlider. Did you forget to pass the controller to the SheetSlider?',
    );
    return _state!;
  }

  set state(SheetSliderState? value) => _state = value;
}
