import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';

@Openapi(
  additionalProperties: DioProperties(
    pubName: 'beneesse_api_client',
    pubAuthor: 'Beneesse',
  ),
  inputSpec: InputSpec(path: 'openapi/openapi.yaml'),
  generatorName: Generator.dio,
  runSourceGenOnOutput: true,
  outputDirectory: 'lib/generated/beneesse_api_client',
)
// ignore: unused_element
class _BeneesseOpenApiConfig {}
