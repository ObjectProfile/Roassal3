# Roassal3
[![Build Status](https://travis-ci.org/ObjectProfile/Roassal3.svg?branch=master)](https://travis-ci.org/ObjectProfile/Roassal3)

Roassal3 is an agile visualization engine for Pharo 8 and Pharo 9. Roassal is made to visualize data in an interactive way data. Sister projects: [Roassal3Documentation](https://github.com/ObjectProfile/Roassal3Documentation), [Roassal3Exporters](https://github.com/ObjectProfile/Roassal3Exporters)


## Installation on Pharo

### Stable version
Execute the following code snippet in a Playground:

```Smalltalk
Metacello new
    baseline: 'Roassal3';
    repository: 'github://ObjectProfile/Roassal3:v0.9.1';
    load.
```

### Latest version

Execute the following code snippet in a Playground:
```Smalltalk
Metacello new
    baseline: 'Roassal3';
    repository: 'github://ObjectProfile/Roassal3';
    load.
```

### Quick examples
Once loaded, you can execute in a playground:

```Smalltalk
RSChartExample new example01Markers open
```

You should see:

<img width="250" height="250" alt="portfolio_view" src="https://user-images.githubusercontent.com/10532890/84400888-9afc6180-abd0-11ea-8258-4bbcbee7bd15.png">

Another example of chart may be seen using:
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

An example of animation may be seen using:

```Smalltalk
RSAnimationExamples new example06Atom open
```
You should see an animated version of:

![atom](https://user-images.githubusercontent.com/10532890/84400054-91262e80-abcf-11ea-8cd6-d659d8b3bde3.png)

## Documentation

Visit the [documentation github page](https://github.com/ObjectProfile/Roassal3Documentation)

A major effort on writing documentation is under construction. The wiki pages is yet another source of documentation for Roassal3: https://github.com/ObjectProfile/Roassal3/wiki


## Roassal3 as a dependent application
If you wish to set a dependency to Roassal3 in your application, you simply need to add in your baseline:

```Smalltalk
spec baseline: 'Roassal3' with: [ spec repository: 'github://ObjectProfile/Roassal3/src' ].
```
_____
## Get in touch
Share your happiness by joining the #Roassal channel, in the Pharo discord server: https://pharo.org/community

_____
## Acknowledgement

Roassal3 is a community effort, and we are really grateful to a number of people. In no particular order, big thanks to:
Stéphane Ducasse, Martin Días, Pavel Krivanek
