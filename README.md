# SRT Replace

`SRT Replace` is a Dart command-line application that replaces the subtitles in an SRT file with the corresponding lines from a text file.

## Usage

1. Clone the repository:

   ```
   git clone https://github.com/zeedif/srt_replace.git
   ```

2. Navigate to the project directory:

   ```
   cd srt_replace
   ```

3. Install the dependencies:

   ```
   dart pub get
   ```

4. Run the application:

   ```
   dart run main.dart --input-srt=path/to/input.srt --output-srt=path/to/output.srt --input-txt=path/to/input.txt
   ```

   You can specify the file paths using the following command-line arguments:

   - `--input-srt` or `-i`: The input SRT file path.
   - `--output-srt` or `-o`: The output SRT file path. If not provided, the program will save the updated SRT file to the same path as the input SRT file.
   - `--input-txt` or `-t`: The input text file path.

   The application will prompt you to enter the file paths for the input SRT file and the input text file. Once you provide the file paths, the application will replace the subtitles in the SRT file with the corresponding lines from the text file and save the updated SRT file to the output file path.

## Requirements

- Dart SDK 3.1.0 or higher

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [subtitle](https://pub.dev/packages/subtitle) - A Dart package for parsing and manipulating subtitles.

## Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue if you find a bug or have a feature request.

## Authors

- Zeedif - [GitHub Profile](https://github.com/zeedif)

## Contact

If you have any questions or comments about this project, please feel free to contact me at zeedif@hotmail.com.

## Disclaimer

This project is not affiliated with or endorsed by any third-party software or service mentioned in this README.

