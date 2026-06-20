import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';

@Openapi(
  additionalProperties: DioProperties(
    pubName: 'ermeo_api_client',
    pubAuthor: 'Ermeo',
  ),
  inputSpec: InputSpec(path: 'openapi/openapi.yaml'),
  generatorName: Generator.dio,
  runSourceGenOnOutput: true,
  outputDirectory: 'lib/generated/ermeo_api_client',
)
// ignore: unused_element
class _ErmeoOpenApiConfig {}
