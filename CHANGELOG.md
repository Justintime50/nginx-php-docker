# CHANGELOG

## 24 (2024-11-09)

- Run PHP-FPM over a Unix sockeet instead of TCP since Nginx and PHP-FPM run inside the same container
- Enable Gzip
- Bump file upload size from 5mb to 10mb

## 23 (2024-11-25)

- Fix invalid comment in `opcache.ini` file

## 22 (2024-11-25)

- Right sizes the PHP-FPM workers for systems with 3-4 cores (previously there were too many workers which simply idled)

## 21 (2024-11-25)

- Adds PHP 8.4 support
- Tunes PHP-FPM workers for greater throughput

## 20 (2024-10-18)

- Adds `bcmath` php extension to image

## 19 (2024-05-07)

- Corrects access log formatter to include forwarded IP address in addition to remote address
- Drop support for PHP 7.4 and 8.0

## 18 (2023-11-28)

- Adds PHP 8.3 support

## 17 (2023-09-04)

- Bumps PHP minor versions used under the hood (necessary for PHP 8.2.9+ for PHP VCR segfault corrections)

## 16 (2023-08-06)

- Logging
  - Logs Nginx `access/error` messages to `stdout/stderr` in addition to file
  - No longer logs `php-fpm` to `stdout`
- Improves security
  - Adds `X-Frame-Options` and `X-Content-Type-Options` headers
  - Drops support for `TLS 1.1`
- Defaults from PHP 7.4 to PHP 8.2 when no flag is passed so `latest` matches expectations better

## 15 (2023-05-28)

- Overhauls `msmtp` configuration to work with `Mailtrap` instead of `Mailcatcher` out of the box, adjusts default, corrects log file permissions, and enables PHP to use `msmtp` out of the box

## 14 (2023-01-04)

- Adds NPM to the container

## 13 (2022-12-31)

- Fixes an inline comment throwing errors for opcache.ini output on image startup

## 12 (2022-12-31)

- Adds PHP 8.2 support
- Bumps image and build dependencies

## 11 (2022-04-24)

- Corrects port exposure back to ports 80 and 443 as intended externally

## 10 (2022-04-23)

- Container now runs as `www-data` instead of `root` dramatically increasing security
- Container now exposes ports `8080` and `8443` instead of `80` and `443`

## 9 (2021-11-30)

- Adds PHP 8.1 support

## 8 (2021-10-12)

- Adds build architectures for linux/amd64 (eg: Intel), linux/arm/v7 (eg: Raspberry Pi), linux/arm64 (eg: M1 Macs)

## 7 (2021-07-23)

- Changes nginx config path from `/etc/nginx/conf.d/*.conf` to `/etc/nginx/http.d/*.conf` as this was altered in Alpine 3.14/15
- Pins dependencies to their major versions
- Changes default location from `/var/www/html` to `/var/www/html/public`, this will allow Laravel applications to use the same nginx config without the need to change anything.
- Changes nginx landing page to PHP Info
- Improved OPcache performance by allowing more memory
- Remove build cache when finished to reduce image size
- Moved opcache config from the Dockerfile to a separate `ini` file, enabled JIT compiling
- Expire static asset caching after 30 days in nginx config
- Deny access to non-site or public assets in nginx config
- Turns off nginx version info on publicly accessible pages
- Due to Docker autobuilds becoming a paid service, the `latest` tag will now be built via GitHub Actions on any push to the main branch.
- Updates various pieces of documentation

## 6 (2021-02-27)

- Removes `server_name` from nginx.conf as it's not needed

## 5 (2021-02-08)

- Adds `Composer` to the image out of the box
- Set explicit shell

## 4 (2021-02-06)

- Dropped support for PHP 7.0 - 7.3 due to GD changes that cannot build properly under those versions
- Switched from Travis CI to GitHub Actions
- Adopted new release workflow where each change simply iterates the version number since we provide images for various PHP versions

## 3 (2020-12-08)

- Added PHP 8.0 support
- Updated documentation

## 2 (2020)

- Added backwards support for PHP 7.0 and 7.1

## 1 (2020)

- Initial release
