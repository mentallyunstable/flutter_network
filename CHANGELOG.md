# Changelog

All notable changes to this project will be documented in this file.

## [1.0.0] - 2023-06-05

### Added
- Add `ErrorData` class to represent error response data 
- `Result` now has second generic attribute `<T, E extends ErrorData>` (was `<T>`)
- Add error response data decoding for all `NetworkService` request methods
- Add `errorDataFromJson` property for `NetworkOptions` for decoding error response data
- Add `TestErrorData` in `test/models.dart` for testing purposes

### Fixed
- `DioNetworkError` response `data` now logs properly
- `DioNetworkError` test request now validates decoded error response data

## [0.0.2] - 2023-03-23

### Added
- Add unit tests for invalid requests (WIP)

### Fixed
- Change validateStatus field for dio instance creation so DioError will be thrown when status code < 200 && > 300

### Changed
- Improve logs structure for `NetworkLogger`
- Improve valid requests unit tests

## [0.0.1] - 2023-02-23

### Added
- `NetworkService`
- `NetworkLogger`
- `NetworkOptions` and `NetworkLoggerOptions`
- Unit tests for instances creation and valid requests

[0.0.1]: https://github.com/mentallyunstable/flutter_network/commits/v0.0.1