"
TODO
"
Class {
	#name : #RSLinePlot,
	#superclass : #RSAbstractPlot,
	#traits : 'RSTLine',
	#classTraits : 'RSTLine classTrait',
	#instVars : [
		'line',
		'format',
		'ylabel',
		'xlabel'
	],
	#category : #'Roassal3-Chart-Plots'
}

{ #category : #'instance creation' }
RSLinePlot class >> y: aCollection [
	| linePlot |
	linePlot := self new.
	linePlot y: aCollection.
	^ linePlot
]

{ #category : #building }
RSLinePlot >> buildChart [

	| chartPlot marker markerChar |
	chartPlot := RSChart new.
	chartPlot add: self.

	chartPlot
		add: RSHorizontalTick new;
		add: RSVerticalTick new;
		ylabel: self ylabel;
		xlabel: self xlabel;
		extent: 250 @ 200;
		padding: 15 @ 10.
	^ chartPlot
]

{ #category : #accessing }
RSLinePlot >> createdShapes [
	^ { line }
]

{ #category : #initialization }
RSLinePlot >> defaultShape [
	^ RSPolyline new color: nil
]

{ #category : #'public - shape' }
RSLinePlot >> format: aString [
	"Format lines of the LinePlot.
	Receive a string shortcut to define line and marker styles.

	For markers use
	'o' - circle
	'^' - arrow
	's' - square
	'p' - pentagon
	'h' - hexagon
	'+' - plus
	'd' - diamond
	'*' - star

	For stroke styles use:
	'--' dashed line.
	'-.' dashed line with small line then point
	'.' dashed line with points
	
	For colors use:
	'r' red
	'g' green
	'b' blue
	'c' cyan
	'm' magenta
	'y' yellow
	'k' black
	'w white'
	
	There is no order of marker, stroke or color specification.
	'r.o'
	'.or'
	'o.r'
		
	Example:
```
| p |
p := (RSLinePlot y: #(1 2 3 4)) format: 'or--'.
p open.
````
	 "
	formatString := aString.
	self shape format: formatString.
]

{ #category : #testing }
RSLinePlot >> isLinePlot [
	^ true
]

{ #category : #accessing }
RSLinePlot >> line [
	^ line
]

{ #category : #constants }
RSLinePlot >> marker [
	^ self shape markers at: 1
]

{ #category : #'instance creation' }
RSLinePlot >> open [
	^ self buildChart open
]

{ #category : #rendering }
RSLinePlot >> renderIn: canvas [
	| controlPoints |
	self checkAssertion.
	controlPoints := OrderedCollection new.
	(1 to: xValues size) do: [ :i |
			| xt yt |
			xt := xValues at: i.
			yt := yValues at: i.
			(self isPointWellDefined: xt @ yt)
				ifTrue: [ controlPoints add: (self scalePoint: xt @ yt) ] ].
	canvas add: (line := self shape copy
		color: self computeColor;
		controlPoints: controlPoints;
		yourself)
]

{ #category : #accessing }
RSLinePlot >> xlabel [
	^ xlabel
]

{ #category : #decoration }
RSLinePlot >> xlabel: aString [
	xlabel := aString
]

{ #category : #accessing }
RSLinePlot >> ylabel [
	^ ylabel
]

{ #category : #decoration }
RSLinePlot >> ylabel: aString [
	ylabel := aString
]
