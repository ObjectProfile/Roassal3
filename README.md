# Roassal
[![CI](https://github.com/pharo-graphics/Roassal/actions/workflows/runTests.yml/badge.svg)](https://github.com/pharo-graphics/Roassal/actions/workflows/runTests.yml)
![Discord](https://img.shields.io/discord/223421264751099906)

[![Pharo 8](https://img.shields.io/badge/Pharo-8.0-%23aac9ff.svg)](https://pharo.org/download)
[![Pharo 9](https://img.shields.io/badge/Pharo-9.0-%23aac9ff.svg)](https://pharo.org/download)
[![Pharo 10](https://img.shields.io/badge/Pharo-10-%23aac9ff.svg)](https://pharo.org/download)
[![Pharo 11](https://img.shields.io/badge/Pharo-11-%23aac9ff.svg)](https://pharo.org/download)
[![Pharo 12](https://img.shields.io/badge/Pharo-12-%23aac9ff.svg)](https://pharo.org/download)

[*Chat with us on #Roassal*](https://discord.gg/QewZMZa)

Old code is here: https://github.com/ObjectProfile/Roassal

Roassal is an agile visualization engine for [Pharo](http://pharo.org). Roassal was created to enable interactive data visualization, it contains a different groups of shapes an lines that you can use to build your projects, also animations, attach points, events, layouts and a basic chart library.
Roassal use cairo graphics as backend, in a future will support new backends.
Roassal allows to user to extent the presentation of any object thanks to the inspector. Also it has integration with [spec](https://github.com/pharo-spec/Spec) and also with morphic world

Sister projects: [RoassalDocumentation](https://github.com/pharo-graphics/RoassalDocumentation), [RoassalExporters](https://github.com/pharo-graphics/RoassalExporters).

## Pharo Installations
Roassal is included from Pharo 9 to 12. This means that you do not need to install anything else. Pharo contains Roassal 0.9.6b.
Two installation flavors are available: stable and latest (a.k.a bleeding-edge).

### Stable version
If you wish to install Roassal in Pharo, then execute the following code snippet in a Playground:

```Smalltalk
Metacello new
    baseline: 'Roassal';
    repository: 'github://pharo-graphics/Roassal';
    load.
```

### Latest version
If you wish to have the lastest release of Roassal, then execute the following code snippet in a Playground, including Mondrian and experimental packages, use:

```Smalltalk
[Metacello new
    baseline: 'Roassal';
    repository: 'github://pharo-graphics/Roassal';
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

<img width="250" height="250" alt="atom" src="https://github.com/pharo-graphics/Roassal/raw/master/images/example03atom.gif?raw=true">

```Smalltalk
RSExamplesBrowser new open
```
You should see an interactive browser with left right buttons to browse:

<img height="350" alt="exampleBrowser" src="https://github.com/pharo-graphics/Roassal/raw/master/images/exampleBrowser.png?raw=true">

```Smalltalk
RSLayoutStudio new open
```
You should see a layout editor browser to choose a layout with the current parameters:

<img height="350" alt="layoutStudio" src="https://github.com/pharo-graphics/Roassal/raw/master/images/layoutStudio.png?raw=true">

## Documentation

Visit the [documentation github page](https://github.com/pharo-graphics/RoassalDocumentation)

A major effort on writing documentation is under way. The wiki pages are yet another source of documentation for Roassal: https://github.com/pharo-graphics/Roassal/wiki

## Roassal as a dependent application
If you wish to set a dependency to Roassal in your application, you simply need to add the following in your baseline:

```Smalltalk
spec baseline: 'Roassal' with: [ spec repository: 'github://pharo-graphics/Roassal/src' ].
```

To depend on a full version of Roassal, you may use:

```Smalltalk
baseline: 'Roassal' with: [ spec repository: 'github://pharo-graphics/Roassal/src'; loads: #('Full') ];
```
_____
## Get in touch
Share your enthusiasm by joining the #Roassal channel, in the Pharo discord server: https://pharo.org/community
_____
## Acknowledgement

Roassal is a community effort, and we are really grateful to a number of people. In no particular order, big thanks to:
Stéphane Ducasse, Martin Días, Pavel Krivanek
