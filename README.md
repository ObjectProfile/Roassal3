# Roassal3
# Attention
<img width="400" alt="image" src="https://github.com/ObjectProfile/Roassal3/assets/10532890/c92f4033-954f-4e29-a13d-d90ab23dffcd">

WE ARE MOVING
- Roassal3 => https://github.com/pharo-graphics/Roassal
- Roassal3Exporters => https://github.com/pharo-graphics/RoassalExporters
- Roassal3Documentation => https://github.com/pharo-graphics/RoassalDocumentation
  
New repositories:
- RoassalLayouts =>  https://github.com/pharo-graphics/RoassalLayouts

Roassal is part of pharo thats why we want to keep it as part of the pharo ecosystem, thats why we are moving and this repository will be frozen.

[![CI](https://github.com/ObjectProfile/Roassal3/actions/workflows/runTests.yml/badge.svg)](https://github.com/ObjectProfile/Roassal3/actions/workflows/runTests.yml)
![Discord](https://img.shields.io/discord/223421264751099906)
[![Coverage](https://raw.githubusercontent.com/ObjectProfile/Roassal3/master/ci_data/coverageBadge.svg)](https://github.com/ObjectProfile/Roassal3/blob/master/ci_data/coverage.png)

[![Pharo 8](https://img.shields.io/badge/Pharo-8.0-%23aac9ff.svg)](https://pharo.org/download)
[![Pharo 9](https://img.shields.io/badge/Pharo-9.0-%23aac9ff.svg)](https://pharo.org/download)
[![Pharo 10](https://img.shields.io/badge/Pharo-10-%23aac9ff.svg)](https://pharo.org/download)
[![Pharo 11](https://img.shields.io/badge/Pharo-11-%23aac9ff.svg)](https://pharo.org/download)
[![Pharo 12](https://img.shields.io/badge/Pharo-12-%23aac9ff.svg)](https://pharo.org/download)

[*Chat with us on #Roassal*](https://discord.gg/QewZMZa)

[*Visualize the test coverage of Roassal3*](https://github.com/ObjectProfile/Roassal3/blob/master/ci_data/coverage.png)

<!-- [![SmalltalkCI](https://github.com/ObjectProfile/Roassal3/actions/workflows/main.yml/badge.svg)](https://github.com/ObjectProfile/Roassal3/actions/workflows/main.yml) -->

<!-- [![Coverage Status](https://coveralls.io/repos/github/ObjectProfile/Roassal3/badge.svg?branch=master)](https://coveralls.io/github/ObjectProfile/Roassal3?branch=master) -->

Roassal3 is an agile visualization engine for [Pharo](http://pharo.org). Roassal was created to enable interactive data visualization, it contains a different groups of shapes an lines that you can use to build your projects, also animations, attach points, events, layouts and a basic chart library.
Roassal use cairo graphics as backend, in a future will support new backends.
Roassal allows to user to extent the presentation of any object thanks to the inspector. Also it has integration with [spec](https://github.com/pharo-spec/Spec) and also with morphic world

Sister projects: [Roassal3Documentation](https://github.com/ObjectProfile/Roassal3Documentation), [Roassal3Exporters](https://github.com/ObjectProfile/Roassal3Exporters).

## Pharo Installations
Roassal3 is included from Pharo 9 to 12. This means that you do not need to install anything else. Pharo contains Roassal 0.9.6b.
Two installation flavors are available: stable and latest (a.k.a bleeding-edge).

### Stable version
If you wish to install Roassal in Pharo, then execute the following code snippet in a Playground:

```Smalltalk
Metacello new
    baseline: 'Roassal3';
    repository: 'github://ObjectProfile/Roassal3:v1.01';
    load.
```

### Latest version
If you wish to have the lastest release of Roassal, then execute the following code snippet in a Playground, including Mondrian and experimental packages, use:

```Smalltalk
[Metacello new
    baseline: 'Roassal3';
    repository: 'github://ObjectProfile/Roassal3';
    load: 'Full' ] on: MCMergeOrLoadWarning do: [:warning | warning load ]
```

### Quick examples
In order to run the following examples they must be loaded by installing the full (bleeding edge) version of Roassal.

Once loaded, you can execute this in a playground:

```Smalltalk
RSChartExample new example01Markers open
```

You should see:

<img width="250" height="250" alt="portfolio_view" src="https://user-images.githubusercontent.com/10532890/84400888-9afc6180-abd0-11ea-8258-4bbcbee7bd15.png">


An example animation may be seen using:

```Smalltalk
RSAnimationExamples new example03Atom open
```
You should see:

<img width="250" height="250" alt="atom" src="https://github.com/ObjectProfile/Roassal3/raw/master/images/example03atom.gif?raw=true">

```Smalltalk
RSExamplesBrowser new open
```
You should see an interactive browser with left right buttons to browse:

<img height="350" alt="exampleBrowser" src="https://github.com/ObjectProfile/Roassal3/raw/master/images/exampleBrowser.png?raw=true">

```Smalltalk
RSLayoutStudio new open
```
You should see a layout editor browser to choose a layout with the current parameters:

<img height="350" alt="layoutStudio" src="https://github.com/ObjectProfile/Roassal3/raw/master/images/layoutStudio.png?raw=true">

## Documentation

Visit the [documentation github page](https://github.com/ObjectProfile/Roassal3Documentation)

A major effort on writing documentation is under way. The wiki pages are yet another source of documentation for Roassal3: https://github.com/ObjectProfile/Roassal3/wiki

## Roassal3 as a dependent application
If you wish to set a dependency to Roassal3 in your application, you simply need to add the following in your baseline:

```Smalltalk
spec baseline: 'Roassal3' with: [ spec repository: 'github://ObjectProfile/Roassal3/src' ].
```

To depend on a full version of Roassal3, you may use:

```Smalltalk
baseline: 'Roassal3' with: [ spec repository: 'github://ObjectProfile/Roassal3/src'; loads: #('Full') ];
```
_____
## Get in touch
Share your enthusiasm by joining the #Roassal channel, in the Pharo discord server: https://pharo.org/community

Roassal3 is free and open source, but backed by Object Profile. Commercial support offerings are available, including training and custom consultancy services. Check [RoassalPro](https://github.com/ObjectProfile/Roassal3Documentation/blob/6bbc6a4cb36914e1f79b3a038c32984673a1384f/documentation/RoassalPro.md) for more information.
_____
## Acknowledgement

Roassal3 is a community effort, and we are really grateful to a number of people. In no particular order, big thanks to:
Stéphane Ducasse, Martin Días, Pavel Krivanek
