# Changelog

## v6 (2021-02-27)

* Removes `server_name` from nginx.conf as it's not needed

## v5 (2021-02-08)

* Adds `Composer` to the image out of the box
* Set explicit shell

## v4 (2021-02-06)

* Dropped support for PHP 7.0 - 7.3 due to GD changes that cannot build properly under those versions
* Switched from Travis CI to GitHub Actions
* Adopted new release workflow where each change simply iterates the version number since we provide images for various PHP versions

## v3 (2020-12-08)

* Added PHP 8.0 support
* Updated documentation

## v2 (2020)

* Added backwards support for PHP 7.0 and 7.1

## v1 (2020)

* Initial release
