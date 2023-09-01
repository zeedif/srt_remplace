import 'dart:io';
import 'package:subtitle/subtitle.dart';

Future<void> updateSrtFile(
    String txtPath, String srtPathInput, String? srtPathOutput) async {
  // Check if file paths are provided
  if (srtPathInput.isEmpty || txtPath.isEmpty) {
    throw FileSystemException('Please provide the input file paths.');
  }

  if (!txtPath.endsWith('.txt')) {
    throw FileSystemException('The input file must be a .txt file.');
  }

  if (!srtPathInput.endsWith('.srt')) {
    throw FileSystemException('The input file must be a .srt file.');
  }

  if (srtPathOutput != null && !srtPathOutput.endsWith('.srt')) {
    throw FileSystemException('The output file must be a .srt file.');
  }

  // Open files
  final File srtFileInput = File(srtPathInput);
  final File srtFileOutput = File(srtPathOutput ?? srtPathInput);
  final File txtFile = File(txtPath);

  if (!txtFile.existsSync()) {
    throw FileSystemException('The input .txt file does not exist.');
  }

  if (!srtFileInput.existsSync()) {
    throw FileSystemException('The input .srt file does not exist.');
  }

  // Read file contents
  final List<String> txtLines = await txtFile.readAsLines();
  SubtitleObject object = SubtitleObject(
    data: await srtFileInput.readAsString(),
    type: SubtitleType.vtt,
  );
  final SubtitleParser parser = SubtitleParser(object);
  final List<Subtitle> subtitles = parser.parsing();

  // Replace subtitles
  StringBuffer newSrtContent = StringBuffer();
  for (Subtitle subtitle in subtitles) {
    newSrtContent.writeln(subtitle.index);
    newSrtContent.writeln(
        '${formatDuration(subtitle.start)} --> ${formatDuration(subtitle.end)}');
    final int txtIndex = subtitle.index - 1;
    final String updatedData = txtIndex >= 0 && txtIndex < txtLines.length
        ? txtLines[txtIndex]
        : subtitle.data;
    newSrtContent.writeln(updatedData);
    newSrtContent.writeln(); // Add an empty line between subtitles
  }

  // Write the updated content to the output .srt file
  srtFileOutput.existsSync() ? null : srtFileOutput.createSync();
  srtFileOutput.writeAsStringSync(newSrtContent.toString());

  print('The .srt file has been updated successfully.');
}

String formatDuration(Duration duration) {
  final hours = duration.inHours.toString().padLeft(2, '0');
  final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
  final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
  final milliseconds =
      (duration.inMilliseconds % 1000).toString().padLeft(3, '0');
  return '$hours:$minutes:$seconds,$milliseconds';
}
