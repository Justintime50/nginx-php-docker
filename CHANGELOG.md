# CHANGELOG\

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
