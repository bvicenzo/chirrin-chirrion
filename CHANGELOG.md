# Change Log
All notable changes of the project you will find here.

## [0.4.1] - 2015-07-17
### Changed
 - Unlocked JSON gem version to avoid conflict versions

## [0.4.0] - 2015-06-19
### Changed
 - Redis adaprer: new method #list which returns all registered toggles 
 - ChirrinChirrion: new method #list which returns all registered toggles 

## [0.3.0] - 2015-06-08
### Changed
 - Redis adaprer: methods #activate and #inactivate with beng because they raise exception
 - ChirrinChirrion: methods #chirrin and #chirrion with beng because they raise exception

## [0.2.0] - 2015-03-30
### Changed
- Redis adaper inside of the module ChirrinChirrion::DatabaseAdapters
- Redis adaper changed to manage togles inside a Hash.
- Now is possible to define a description for the toggle, which can let other people know what this toggle does
- Way to register toggles, but keep them inactives.

## [0.1.0] - 2015-03-23
### Changed
- First release of the gem.
- Simple way to add and remove toggles. Toggles in the Redis database are active, and are inactive if there is no toggle in the database.
  methods to check if toggle is active, inactive or give procs to gem defines which proc will be executed when the toggle is active and inactive.
