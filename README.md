<p align="center"><img src="assets/logos/128x128.png">
 <h1 align="center">Winter-Examples</h1>
  <p align="center">
    Winter-Examples provides examples on how to use <a href="https://github.com/ba-st/Winter">Winter</a> to develop some 2D games
    <br>
    <a href="docs/"><strong>Explore the docs »</strong></a>
    <br>
    <br>
    <a href="https://github.com/apiorno/Winter-Examples/issues/new?labels=Type%3A+Defect">Report a defect</a>
    |
    <a href="https://github.com/apiorno/Winter-Examples/issues/new?labels=Type%3A+Feature">Request feature</a>
  </p>
</p>

[![Build Status](https://github.com/apiorno/Winter-Examples/workflows/Build/badge.svg?branch=release-candidate)](https://github.com/apiorno/Winter-Examples/actions?query=workflow%3ABuild)
[![Pharo 7.0](https://img.shields.io/badge/Pharo-7.0-informational)](https://pharo.org)
[![Pharo 9.0](https://img.shields.io/badge/Pharo-9.0-informational)](https://pharo.org)

## Goals
- Present the different components and features of Winter
- Guide on how to correctly use Winter

## License
- The code is licensed under [MIT](LICENSE).
- The documentation is licensed under [CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/).

## Quick Start

- Download the latest [Pharo 32](https://get.pharo.org/) or [64 bits VM](https://get.pharo.org/64/).
- Load the latest playground version with

```smalltalk
Metacello new
	baseline: 'WinterExamples';
	repository: 'github://apiorno/Winter-Examples:release-candidate/source';
	load.
```
- Copy the assets folder from the repo and paste it in your Pharo image directory.

You can now run any of the examples:

- Arkanoid

```smalltalk
Arkanoid start
```

- Spider Invasion

```smalltalk
SpiderInvasion start
```

- Wizard Battle Arena

```smalltalk
WBA start
```

## Installation

To load the project in a Pharo image, or declare it as a dependency of your own project follow this [instructions](docs/Installation.md).

## Contributing

Check the [Contribution Guidelines](CONTRIBUTING.md)
