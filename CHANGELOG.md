# Changelog

## v7 (2021-07-23)

* Changes nginx config path from `/etc/nginx/conf.d/*.conf` to `/etc/nginx/http.d/*.conf` as this was altered in Alpine 3.14/15
* Pins dependencies to their major versions
* Changes nginx landing page to PHP Info
* Improved OPcache performance by allowing more memory
* Remove build cache when finished to reduce image size
* Moved opcache config from the Dockerfile to a separate `ini` file, enabled JIT compiling
* Expire static asset caching after 30 days in nginx config
* Deny access to non-site or public assets in nginx config
* Turns off nginx version info on publicly accessible pages
* Due to Docker autobuilds becoming a paid service, the `latest` tag will now be built via GitHub Actions on any push to the main branch.

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
