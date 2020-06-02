# Roassal3
[![Build Status](https://travis-ci.org/ObjectProfile/Roassal3.svg?branch=master)](https://travis-ci.org/ObjectProfile/Roassal3)

Roassal3 is an agile visualization engine for Pharo 8 and Pharo 9. Roassal is made to visualize data in an interactive way data.


## Installation on Pharo

### Stable version
Execute the following code snippet in a Playground:

```Smalltalk
Metacello new
    baseline: 'Roassal3';
    repository: 'github://ObjectProfile/Roassal3:v0.9';
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

<img width="250" height="250" alt="portfolio_view" src="https://github.com/ObjectProfile/Roassal3/blob/master/screenshots/chartExample.png">

Another example of chart may be seen using:
```Smalltalk
RSChartExample new example11BarplotCombinedWithLine open
```

You should see:

<img width="250" height="250" alt="portfolio_view" src="https://github.com/ObjectProfile/Roassal3/blob/master/screenshots/chartExample2.png">


Visualization of a complex graph:
```Smalltalk
RSShapeExamples new example25BisBimetricLineOnLargeExample open
```

<img width="250" height="250" alt="portfolio_view" src="https://github.com/ObjectProfile/Roassal3/blob/master/screenshots/complexGraph.png">

An example of animation may be seen using:

```Smalltalk
RSAnimationExamples new example06Atom open
```
You should see an animated version of:

![atom](screenshots/smallAtom.png)

## Documentation
The documentation of Roassal3 is expanding at a sustained pace.

- Tutorials (learning-oriented material centered around practical steps):
    - [Tutorial 01 - Adding Simple Nodes, Edges, and Layout](LesMiserables.md)
    - [Tutorial 02 - Graph Manipulation](GraphTutorial.md)
    - [Tutorial 03 - Inspector Integration](GTInspectorIntegration.md)
    - [Tutorial 04 - Shape Composition](ShapeComposition.md)
    - [Tutorial 05 - Chart](Chart.md)
- How-to guides (problem-oriented material, centered around practical steps):
    - [How to visualize any arbitrary object?](how-to.md#How-to-visualize-any-arbitrary-object)
    - [How to create a chart from a list of numbers?](how-to.md#How-to-create-a-chart-from-a-list-of-numbers)
	- [How can I use animation to execute a block at a regular pace?](how-to.md#How-can-I-use-animation-to-execute-a-block-at-a-regular-pace)
	- [How can I draw a SVG path?](how-to.md#How-can-I-draw-a-SVG-path)
- [Reference Documentation](Reference/reference.md) (detail about the Roassal machinery and key classes)
- FAQ
	- [Where is the classes RTView?](FAQ.md#Where-is-the-classes-RTView)
	- [What about the book Agile Visualization?](FAQ.md#What-about-the-book-Agile-Visualization)
	- [How to export a visualization to PDF or SVG?](FAQ.md#How-to-export-a-visualization-to-PDF-or-SVG)
	
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

