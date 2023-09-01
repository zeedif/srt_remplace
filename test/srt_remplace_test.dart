import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:srt_remplace/srt_remplace.dart';
import 'package:test/test.dart';

void main() async {
  test('test updateSrtFile with nonexistent.txt file', () async {
    // Create temporary files for testing
    final String srtFilePath = path.join(Directory.current.path, 'test.srt');
    final String outputFilePath =
        path.join(Directory.current.path, 'test_output.srt');
    final File srtFile = File(srtFilePath);
    final File outputFile = File(outputFilePath);
    await srtFile.writeAsString(
        '1\n00:00:00,000 --> 00:00:01,000\nSubtitle 1\n\n2\n00:00:01,000 --> 00:00:02,000\nSubtitle 2\n\n');

    // Call the function being tested and expect an error
    expect(
        () async =>
            await updateSrtFile('nonexistent.txt', srtFilePath, outputFilePath),
        throwsA(isA<FileSystemException>()));

    // Clean up temporary files
    await srtFile.delete();
    if (await outputFile.exists()) {
      await outputFile.delete();
    }
  });

  test('test updateSrtFile with nonexistent .srt file', () async {
    // Create temporary files for testing
    final String txtFilePath = path.join(Directory.current.path, 'test.txt');
    final String outputFilePath =
        path.join(Directory.current.path, 'test_output.srt');
    final File txtFile = File(txtFilePath);
    final File outputFile = File(outputFilePath);
    await txtFile.writeAsString('Line 1\nLine 2\nLine 3\n');

    // Call the function being tested and expect an error
    expect(
        () async =>
            await updateSrtFile(txtFilePath, 'nonexistent.srt', outputFilePath),
        throwsA(isA<FileSystemException>()));

    // Clean up temporary files
    await txtFile.delete();
    if (await outputFile.exists()) {
      await outputFile.delete();
    }
  });

  test('test updateSrtFile with null output file', () async {
    // Create temporary files for testing
    final String txtFilePath = path.join(Directory.current.path, 'test.txt');
    final String srtFilePath = path.join(Directory.current.path, 'test.srt');
    final File txtFile = File(txtFilePath);
    final File srtFile = File(srtFilePath);
    await txtFile.writeAsString('Line 1\nLine 2\nLine 3\n');
    await srtFile.writeAsString(
        '1\n00:00:00,000 --> 00:00:01,000\nSubtitle 1\n\n2\n00:00:01,000 --> 00:00:02,000\nSubtitle 2\n\n');

    // Call the function being tested
    await updateSrtFile(txtFilePath, srtFilePath, null);

    // Check that the output file was created and has the correct content
    expect(await srtFile.exists(), true);
    expect(await srtFile.readAsString(),
        '1\n00:00:00,000 --> 00:00:01,000\nLine 1\n\n2\n00:00:01,000 --> 00:00:02,000\nLine 2\n\n');

    // Clean up temporary files
    await txtFile.delete();
    await srtFile.delete();
  });

  test('test updateSrtFile with valid input files', () async {
    // Create temporary files for testing
    final String txtFilePath = path.join(Directory.current.path, 'test.txt');
    final String srtFilePath = path.join(Directory.current.path, 'test.srt');
    final String outputFilePath =
        path.join(Directory.current.path, 'test_output.srt');
    final File txtFile = File(txtFilePath);
    final File srtFile = File(srtFilePath);
    final File outputFile = File(outputFilePath);
    await txtFile.writeAsString('Line 1\nLine 2\nLine 3\n');
    await srtFile.writeAsString(
        '1\n00:00:00,000 --> 00:00:01,000\nSubtitle 1\n\n2\n00:00:01,000 --> 00:00:02,000\nSubtitle 2\n\n');

    // Call the function being tested
    await updateSrtFile(txtFilePath, srtFilePath, outputFilePath);

    // Check that the output file was created and has the correct content
    expect(await outputFile.exists(), true);
    expect(await outputFile.readAsString(),
        '1\n00:00:00,000 --> 00:00:01,000\nLine 1\n\n2\n00:00:01,000 --> 00:00:02,000\nLine 2\n\n');

    // Clean up temporary files
    await txtFile.delete();
    await srtFile.delete();
    await outputFile.delete();
  });
}
