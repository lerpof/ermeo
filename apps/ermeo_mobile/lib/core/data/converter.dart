/// {@template converter}
/// A converter is a class that converts between two types.
/// {@endtemplate}
abstract class Converter<Input, Output> {
  /// Converts an input to an output.
  Output fromInput(Input input);

  /// Converts an output to an input.
  Input toInput(Output output);
}
