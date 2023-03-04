import 'dart:async';

///Create enumeration or abstract class to separately identify actions or events
enum CounterActions { increment, decrement, reset }

class CounterBloc {
  int counter = 0;

  /// Controller used to handle state stream.
  final StreamController<int> _stateStreamController = StreamController<int>();

  ///Used for input state property (Made private because user not directly interact with it)
  StreamSink<int> get _counterSink => _stateStreamController.sink;

  ///Used for output state property
  Stream<int> get counterStream => _stateStreamController.stream;

  /// Controller used to handle event stream.
  final StreamController<CounterActions> _eventStreamController =
      StreamController<CounterActions>();

  ///Used for input event property
  StreamSink<CounterActions> get eventSink => _eventStreamController.sink;

  ///Used for output event property
  Stream<CounterActions> get _eventStream => _eventStreamController.stream;

  ///Listen to event while creating class instance inside constructor

  CounterBloc() {
    counter = 0;
    _eventStream.listen((event) {
      if (event == CounterActions.increment) {
        counter++;
      } else if (event == CounterActions.decrement) {
        counter--;
      } else if (event == CounterActions.reset) {
        counter = 0;
      }
      _counterSink.add(counter);
    });
  }

  ///CLose all stream controllers to avoid memory leak
  void dispose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }
}
