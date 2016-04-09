-----------------------------------------
[![ImageLayers Badge](https://badge.imagelayers.io/mirabis/docker-mp4automator:0.9.17.svg)](https://imagelayers.io/?images=mirabis/docker-mp4automator:latest) 
[![GitHub issues](https://img.shields.io/github/issues/Mirabis/docker-mp4automator.svg?style=flat-square)](https://github.com/Mirabis/docker-mp4automator/issues)
-----------------------------------------

Table of Contents
=================

* [Components](#components)
* [Running](#running)
* [Updates](#updates)
* [Issues](#issues)
* [Copyright & License](#copyright--license)
* [See Also](#see-also)
-----------------------------------------

Components
===========
| Component        | Details			 |
| ---------------- | ------------------- |
| FFMPEG 3.*	   | Cross-platform solution to record, convert and stream audio and video.    |
| [mp4_automator](https://github.com/mdhiggins/sickbeard_mp4_automator) | MP4 Conversion/Tagging Automation Script. |

Running
===========
```bash
$ docker run --name mp4automator -v /mp4automator/python/files:/config -d mirabis/mp4automator:latest

```
or the docker-compose equivalent.
```yaml
 image: mirabis/mp4automator:latest
  volumes:
   - /mp4automator/python/files:/config

```

Updates
===========
Image is automatically rebuilt when one of the main components repository changes.


Issues
===========
If you have any problems with or questions about this image, please contact me through a [GitHub issue!](/issues).

Copyright & License
===================
to be determined.


See Also
========
* [Docker registry](https://index.docker.io/u/mirabis/mp4automator/) 
* [Blog](https://mirabis.nl/)
* [Twitter](https://twitter.com/imirabis/) 
