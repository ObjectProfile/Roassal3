# Roassal3
[![Build Status](https://travis-ci.org/ObjectProfile/Roassal3.svg?branch=master)](https://travis-ci.org/ObjectProfile/Roassal3)

Roassal3 is an agile visualization engine for [Pharo 8 and Pharo 9](http://pharo.org). Roassal was created to enable interactive data visualization. Sister projects: [Roassal3Documentation](https://github.com/ObjectProfile/Roassal3Documentation), [Roassal3Exporters](https://github.com/ObjectProfile/Roassal3Exporters)


## Pharo Installations
Roassal3 is included in Pharo 9. This means that you do not need to install anything else. Pharo 9 contains Roassal 0.9.4. 
Two instalation flavors are available: stable and latest (a.k.a bleeding-edge).

### Stable version
If you wish to install Roassal in Pharo 8, then execute the following code snippet in a Playground:

```Smalltalk
Metacello new
    baseline: 'Roassal3';
    repository: 'github://ObjectProfile/Roassal3:v0.9.4';
    load.
```

### Latest version
If you wish to have the lastest release of Roassal, then execute the following code snippet in a Playground:
```Smalltalk
Metacello new
    baseline: 'Roassal3';
    repository: 'github://ObjectProfile/Roassal3';
    load.
```

In order to suppress warnings you may prefer:
```Smalltalk
[Metacello new
    baseline: 'Roassal3';
    repository: 'github://ObjectProfile/Roassal3';
    load ] on: MCMergeOrLoadWarning do: [:warning | warning load ]
```   

### Quick examples
In order to run the following examples they must be loaded by installing the full (bleeding edge) version of Roassal.

Once loaded, you can execute this in a playground:

```Smalltalk
RSChartExample new example01Markers open
```

You should see:

f<img width="250" height="250" alt="portfolio_view" src="https://user-images.githubusercontent.com/10532890/84400888-9afc6180-abd0-11ea-8258-4bbcbee7bd15.png">

Another chart example may be seen using:
```Smalltalk
RSChartExample new example11BarplotCombinedWithLine open
```

You should see:

<img width="250" height="250" alt="portfolio_view" src="https://user-images.githubusercontent.com/10532890/84400958-b4051280-abd0-11ea-86e5-6b7e59c8a4fa.png">


Visualization of a complex graph:
```Smalltalk
RSShapeExamples new example25BisBimetricLineOnLargeExample open
```

<img width="250" height="250" alt="portfolio_view" src="https://user-images.githubusercontent.com/10532890/84401030-c7b07900-abd0-11ea-81f3-70e09dc163f4.png">

An example animation may be seen using:

```Smalltalk
RSAnimationExamples new example03Atom open
```
You should see:

<img width="250" height="250" alt="atom" src="https://github.com/ObjectProfile/Roassal3/raw/master/images/example03atom.gif?raw=true">

## Documentation

Visit the [documentation github page](https://github.com/ObjectProfile/Roassal3Documentation)

A major effort on writing documentation is under way. The wiki pages are yet another source of documentation for Roassal3: https://github.com/ObjectProfile/Roassal3/wiki


## Roassal3 as a dependent application
If you wish to set a dependency to Roassal3 in your application, you simply need to add the following in your baseline:

```Smalltalk
spec baseline: 'Roassal3' with: [ spec repository: 'github://ObjectProfile/Roassal3/src' ].
```
_____
## Get in touch
Share your enthusiasm by joining the #Roassal channel, in the Pharo discord server: https://pharo.org/community

_____
## Acknowledgement

Roassal3 is a community effort, and we are really grateful to a number of people. In no particular order, big thanks to:
Stéphane Ducasse, Martin Días, Pavel Krivanek

