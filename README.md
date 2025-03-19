# DEPRECATED

The project has been frozen since the announcement of [composer 2](https://blog.packagist.com/composer-2-0-is-now-available/), which solved several problems, but still did not cover all users, especially in China. A few weeks ago, it adopted a [global CDN model](https://bunny.net/network/) and will [shutdown all legacy version 1](https://blog.packagist.com/shutting-down-packagist-org-support-for-composer-1-x/), which makes this mirror unnecessary. This includes Brazil, China and other countries where performance was still not good enough. This is a good move and I recommend that all existing mirrors start shutting down their domains. I will open a PR to remove the Packagist mirror page. Thank you to the community and everyone who helped the project.

[![Build Status](https://goo.gl/u9wbBD)](https://hub.docker.com/r/webysther/packagist-mirror/)
[![Docker pulls](https://goo.gl/Jb5Cq4)](https://hub.docker.com/r/webysther/packagist-mirror/)
[![Minimum PHP Version](https://img.shields.io/badge/php-%3E%3D%207.2-8892BF.svg?style=flat-square&maxAge=3600)](https://php.net/)
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2FWebysther%2Fpackagist-mirror-docker.svg?type=shield)](https://app.fossa.io/projects/git%2Bgithub.com%2FWebysther%2Fpackagist-mirror-docker?ref=badge_shield)
[![Software License](https://goo.gl/FU2Kw1)](LICENSE)
[![Mentioned in Awesome composer](https://awesome.re/mentioned-badge.svg)](https://github.com/jakoch/awesome-composer#packagist-mirrors)

# Docker for [Packagist Mirror](https://github.com/Webysther/packagist-mirror)

This project allows you to easily create and update a [mirror of the packagist](https://github.com/Webysther/packagist-mirror) having as dependency only the docker.
It is possible to completely [customize the mirror](https://github.com/Webysther/packagist-mirror/blob/master/.env.example) only by using environment variable and thereby create an institutional mirror or for a particular country without any problem.

We use [webysther/composer-debian](https://hub.docker.com/r/webysther/composer-debian) as alternative to [official composer on docker hub](https://hub.docker.com/_/composer) because the alpine version has issues with I/O.

## Usage

Schedule in case of restart or another problem, the first execution create a mirror:

```bash
* * * * * root docker run --name mirror --rm -v /var/www/html:/public -e MAINTAINER_REPO='mymirror.com' webysther/packagist-mirror
```

Synchronized continuously:
```bash
*    *  * * * root docker run --name mirror --rm --device-read-bps /dev/xvda:600kb --device-write-bps /dev/xvda:600kb -e SLEEP=0 -v /var/www/html:/public webysther/packagist-mirror

```
Sample used inside packagist.com.br (update docker composer every day):
```bash
# Every minute
*    *  * * * root docker run --name mirror --rm --device-read-bps /dev/xvda:600kb --device-write-bps /dev/xvda:600kb -e SLEEP=0 -v /var/www/html:/public webysther/packagist-mirror

# Every 1:00 AM
0    1  * * * root docker pull webysther/packagist-mirror 

# Every 2:30 AM
30   2  * * * root service docker restart
```

You can add more mirrors with additional URL's separated by comma:

```bash
-e DATA_MIRROR='https://packagist.jp,https://packagist.com.br'
```

Main mirror is used to get providers and fallback in case of error on data mirror, you can also change them:

```bash
-e MAIN_MIRROR='https://packagist.com.br'
```

You also can change parallel connections for every mirror:

```bash
-e MAX_CONNECTIONS=10
```

All enviroment options stay on `.env` file.


## License
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2FWebysther%2Fpackagist-mirror-docker.svg?type=large)](https://app.fossa.io/projects/git%2Bgithub.com%2FWebysther%2Fpackagist-mirror-docker?ref=badge_large)
