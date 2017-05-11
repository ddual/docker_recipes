<!-- TOC depthFrom:1 depthTo:6 withLinks:1 updateOnSave:1 orderedList:0 -->

- [Docker Recipes](#docker-recipes)
	- [Overview](#overview)
	- [Recipes](#recipes)
		- [Fedora with an X Window System](#fedora-with-an-x-window-system)
			- [To Build and Run](#to-build-and-run)
		- [Alpine Linux with a JRE](#alpine-linux-with-a-jre)
			- [To Build and Run](#to-build-and-run)

<!-- /TOC -->

# Docker Recipes

## Overview

Just a collection of more interesting recipes.

## Recipes

### Fedora with an X Window System

I use this on the very odd occasion, when I want a Linux container that has a full Desktop Environment, so that I can test/check something in isolation. There's [a few ideas out there](http://stackoverflow.com/questions/16296753/can-you-run-gui-apps-in-a-docker-container) on the best way to do this. I used `Xvfb` and `VNC`, as I wanted something that didn't depend on XQuartz in the Mac.

If you're on a Mac/OS X/Mac OS, don't bother installing a specific **VNC** client, just open **Screen Sharing**, and _Connect To_ `localhost:5901`. The password will be `letmein`, which you can change in the Dockerfile.

Also, the Desktop Environment I'm using is **xfce**. You can change the package `@xfce-desktop-environment` in the Dockerfile to be your favourite. I had issues with Gnome, but KDE worked first shot.

#### To Build and Run

```bash
$ docker build -t you/fedora-gui .
$ docker run -it --rm -v $HOME/wherever/docker_swap:/docker_swap -p 0.0.0.0:5901:5901 you/fedora-gui
```

---

### Alpine Linux with a JRE

This is just a minimal stripped down linux base image, that includes JRE.

#### To Build and Run

```bash
$ docker build -t you/alpine-min .
$ docker run -u 0 -it --rm -v $HOME/wherever/docker_swap:/docker_swap -P you/alpine-min
```

I am running an `sshd` in the container (bit weird I know). You can expose the port when you `docker run`, or if you have used `-P` as in the example above, you can find out the port that `ssh` has been exposed out to via `$ docker ps` or `$ docker port containerName 22`, and then you can ssh in with `ssh developer@localhost -p 32774` (using 32774 as an example).

For a while I was installing the Openshift Origin Client, just to try out the _'Next Gen'_ platform but I'm not sure if this still works, so I have commented this out (it was awesome btw)!
