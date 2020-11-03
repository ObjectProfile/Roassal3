"
<keyClass>
`RSXLabelDecoration` adds a title to the X-axis in a chart.

*Responsibility*: Add a title and allows for its style to be defined (e.g., color, size, rotation, offset)

*Collaborators*: must be added to an `RSChart`

*Example*:
```Smalltalk
x := -3.14 to: 3.14 by: 0.1.
y := x sin.

c := RSChart new.
c addPlot: (RSLinePlot new x: x y: y).
c addDecoration: (RSChartTitleDecoration new title: 'hello'; fontSize: 20).
c addDecoration: (RSXLabelDecoration new title: 'My X Axis'; fontSize: 12).
c addDecoration: (RSYLabelDecoration new title: 'My Y Axis'; fontSize: 15; horizontal).
c open
```
"
Class {
	#name : #RSXLabelDecoration,
	#superclass : #RSAbstractLabelDecoration,
	#category : #'Roassal3-Chart-Decoration'
}

{ #category : #initialization }
RSXLabelDecoration >> initialize [
	super initialize.
	self offset: 5
]

{ #category : #rendering }
RSXLabelDecoration >> renderIn: canvas [
	| label |
	label := self createLabel.
	RSLocation new
		offset: offset;
		below;
		center;
		move: label on: canvas encompassingRectangle.
	canvas add: label.
]
