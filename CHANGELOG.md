# Changelog

All notable changes to this project will be documented in this file.

## [0.0.2] - 2023-03-23

### Added
- Add unit tests for invalid requests (WIP)

### Fixed
- change validateStatus field for dio instance creation so DioError will be thrown when status code < 200 && > 300

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