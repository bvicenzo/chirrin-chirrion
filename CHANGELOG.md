# Change Log
All notable changes of the project you will find here.

## [Unreleased]
### Changed
- Redis adaper changed to manage togles inside a Hash.
- Way to register toggles, but keep them inactives.

## [0.1.0] - 2015-03-23
### Changed
- First release of the gem.
- Simple way to add and remove toggles. Toggles in the Redis database are active, and are inactive if there is no toggle in the database.
  methods to check if toggle is active, inactive or give procs to gem defines which proc will be executed when the toggle is active and inactive.
