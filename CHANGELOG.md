# Unreleased

# Stable Releases

## 1.0.0 &ndash; ???

# Alpha Releases

## 0.9.0 &ndash; 2023-02-11
- Swap gem name to shorter uuidx
- Main documentation written
- Add type signatures
- Add monotonic batch support to simple API.

## 0.8.0 &ndash; 2023-02-10
- Add simple Uuid generation API
- Generator classes are now lock-free
- Remove UUID value type

## 0.7.0 &ndash; 2023-02-10
- Generator APIs now return opaque string values for UUIDs
- Add faster UUID v4 implementation

## 0.6.0 &ndash; 2023-02-04
- Convert generator modules to classes
- Fix clock ID references in UUID v7
- Pass tests on all supported versions of Ruby

## 0.5.0 &ndash; 2023-01-31
- Threading safety for clock sequence in UUID v6
- Clock drift detection in UUID v6

## 0.4.0 &ndash; 2023-01-26
- Add clock resolution verification methods
- UUID v6 and v7 are now thread-safe

## 0.3.0 &ndash; 2023-01-25
- New, faster design of UUID generator modules
- Removal of old implementations

## 0.2.0 &ndash; 2023-01-22
- UUID v6, v7, and v8 implemented quickly
- Some performance optimization done

## 0.1.0 &ndash; 2023-01-18
- Initial release without design considerations
