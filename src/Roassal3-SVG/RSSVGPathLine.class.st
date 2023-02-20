"
I represent path a complex line from one point to another with an svg path.

Here an example:
```
RSBasicShapeExamples new example16BasicLinePath inspect
```

- `svgPath:`. Use a block with one argument, this block should return a String
```
svgLine := RSSVGPathLine new.
svgLine svgPath: [:line | 'M0 0 L200 100L400 0 Z' ].
svgLine color: Color blue.
svgLine borderColor: Color black.
canvas := RSCanvas new.
canvas add: svgLine.
canvas
```
this block is executed each time you need to redraw the line. As you can see this string is hardcoded, the idea is to use the `line` to create the string with the svg path commands.

But this is only a basic way to draw a custom line. If you will need an special line then you should create a subclass of `RSAbstractLine` then add a methods in `RSAthensRenderer` using the visitor pattern.
"
Class {
	#name : #RSSVGPathLine,
	#superclass : #RSAbstractDualLine,
	#instVars : [
		'svgPath'
	],
	#category : #'Roassal3-SVG-Shapes'
}

{ #category : #examples }
RSSVGPathLine class >> exampleArc [
	| canvas line |
	canvas := RSCanvas new.
	line := self new.
	line borderColor: Color black.
	line paint: Color lightGray.
	line svgPath: [ :theLine | [ :pathBuilder |
		| radius center startAngle deltaAngle |
		radius := 60.
		startAngle := 45 degreesToRadians.
		deltaAngle := 90 degreesToRadians.
		center := 0@0.
		pathBuilder
			moveTo: (startAngle cos @ startAngle sin) * radius + center;
			arcCenterX: center x
			centerY: center y
			radius: radius
			startAngle: startAngle
			endAngle: startAngle + deltaAngle
		 ] ].
	canvas add: line.
	canvas open
]

{ #category : #examples }
RSSVGPathLine class >> exampleBasic [
	| line a b |
	line := self new.
	a := RSCircle new
		radius: 5;
		color: 'blue';
		draggable;
		yourself.
	b := RSEllipse new
		radius: 5 ;
		color: 'red';
		draggable;
		position: 100@100;
		yourself.

	line from: a; to: b.
	line svgPath: [ :aLine | | from to |
		from := aLine from position.
		to := aLine to position.
		'M ', from x asString, ' ', from y asString,
		'L ', to x asString, ' ', to y asString,
		'L' , from x asString, ' ', to y asString, ' Z'
		 ].

	line color: Color green; borderColor: Color black.

	RSCanvas new
		addAll: { a. b. line };
		open
]

{ #category : #visiting }
RSSVGPathLine >> buildPathOn: visitor [
	visitor buildSVGLinePath: self
]

{ #category : #accessing }
RSSVGPathLine >> color [
	^ self paint
]

{ #category : #accessing }
RSSVGPathLine >> color: aColor [
	self paint: aColor
]

{ #category : #initialization }
RSSVGPathLine >> initialize [
	super initialize.
	self svgPath: [:line |'']
]

{ #category : #accessing }
RSSVGPathLine >> svgPath [
	^svgPath
]

{ #category : #accessing }
RSSVGPathLine >> svgPath: aBlock [
	"aBlock return a string and recives 1 argument, the svg line"
	svgPath := aBlock
]
