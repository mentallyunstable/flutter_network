# Changelog

All notable changes to this project will be documented in this file.

## [1.0.2] - 2023-07-08

### Fixed
- Now `statusCode` and `statusMessage` values printed when `NetworkError` occurred

## [1.0.1] - 2023-06-07

### Added
- Add `networkOptions` field for all http methods in `NetworkService` (it will be used instead of default options instance if provided)
- Add `ResponseNetworkError` test

### Fixed
- Now `NetworkService` properly handles `ResponseNetworkError` and `DioNetworkError`
- Now `NetworkLogger` properly reacts to `LoggerOptions.printOnlyInDebug`
- Now `NetworkLogger` properly prints response data when `ResponseNetworkError` or `DioNetworkError` occurs
- Add more docs, change some old and fix doc links
- Remove unused and commented code
- Update dependencies

## [1.0.0] - 2023-06-05

### Added
- Add `ErrorData` class to represent error response data
- `Result` now has second generic attribute `<T, E extends ErrorData>` (was `<T>`)
- Add error response data decoding for all `NetworkService` request methods
- Add `errorDataFromJson` property for `NetworkOptions` for decoding error response data
- Add `TestErrorData` in `test/models.dart` for testing purposes

### Fixed
- Now `DioNetworkError` response `data` logs properly
- Now `DioNetworkError` test request validates decoded error response data

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