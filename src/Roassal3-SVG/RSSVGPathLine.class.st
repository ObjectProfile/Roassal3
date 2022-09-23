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

{ #category : #visiting }
RSSVGPathLine >> buildPathOn: visitor [
	visitor buildSVGLinePath: self.
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
	self svgPath: [:line |''].
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
