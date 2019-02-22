import 'dart:async';
import 'package:flutter_bloc_stream_demo/event_type.dart';

class Bloc {
  // counter conterá o valor atual
  int _counter = 0;

  final _counterStreamController = StreamController<int>();
  final _countEventController = StreamController<EventType>();

  // O prefixo 'in'representa os valores de entrada e o prefixo 'out' representa os valores de saída.
  // Qualquer entrada passará pelo _streamInCounter e toda saída passará pelo streamOutCounter
  StreamSink<int> get _streamInCounter => _counterStreamController.sink;
  Stream<int> get streamOutCounter => _counterStreamController.stream;

  // Utilizado para adicionar novos eventos ao Stream
  StreamSink<EventType> get streamInEvent => _countEventController.sink;

  Bloc() {
    // Todo item adicionado ao Stream passará pelo método _eventListener
    _countEventController.stream.listen(_eventListener);
  }

  void _eventListener(EventType e) {
    switch (e) {
      case EventType.Increment:
        _counter++;
        break;
      case EventType.Decrement:
        _counter--;
        break;
    }

    // Adiciona ao Stream (in) do contador um novo valor
    _streamInCounter.add(_counter);
  }

  void dispose() {
    _counterStreamController.close();
    _countEventController.close();
  }
}
