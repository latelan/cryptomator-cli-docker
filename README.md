# cryptomator-cli-docker

[![Build Status](https://github.com/latelan/cryptomator-cli-docker/actions/workflows/docker-build.yml/badge.svg)](https://github.com/latelan/cryptomator-cli-docker/actions/workflows/docker-build.yml)

> Docker image for running [Cryptomator CLI](https://github.com/cryptomator/cli)

## Project Overview

This project creates a Docker image for the [cryptomator/cli](https://github.com/cryptomator/cli) tool, allowing you to use Cryptomator’s command-line functionalities within a containerized environment. With this image, you can encrypt/decrypt files and integrate secure encryption operations into your automated workflows.

**Note:**
- The upstream [cryptomator/cli](https://github.com/cryptomator/cli) source code and its binaries are distributed under the [GPLv3 license](https://github.com/cryptomator/cli/blob/develop/LICENSE.txt).
- The Docker build scripts, CI configuration files, and all custom wrapping code in this repository are original and released under the MIT License.
- Since the Docker image includes GPLv3 software, ensure that your usage complies with the GPLv3 requirements as well as the MIT License for the custom components.

## Pulling the Image

The Docker image is hosted on Docker Hub and is automatically built and tagged based on the upstream release version.

Pull the image by specifying the tag (e.g., `latest` or a specific version):

```bash
docker pull latelan/cryptomator-cli-docker:<tag>
