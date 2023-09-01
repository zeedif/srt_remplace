import 'package:args/args.dart';
import 'package:srt_remplace/srt_remplace.dart' as srt_remplace;

void main(List<String> arguments) async {
  // Define the command-line arguments
  final parser = ArgParser()
    ..addOption('input-srt', abbr: 'i', help: 'Input SRT file path')
    ..addOption('output-srt', abbr: 'o', help: 'Output SRT file path')
    ..addOption('input-txt', abbr: 't', help: 'Input text file path');

  // Parse the command-line arguments
  final args = parser.parse(arguments);

  // Get the file paths from the command-line arguments
  final String? srtPathInput = args['input-srt'];
  final String? srtPathOutput = args['output-srt'];
  final String? txtPath = args['input-txt'];

  // Check if file paths are provided
  if (srtPathInput == null || txtPath == null) {
    print('Please provide the file paths.');
    return;
  }

  // Call the function
  await srt_remplace.updateSrtFile(txtPath, srtPathInput, srtPathOutput);
}
