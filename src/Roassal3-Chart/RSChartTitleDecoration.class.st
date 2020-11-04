"
<keyClass>
`RSChartTitleDecoration` is a `RSChartDecoration` that adds a title to a chart.

*Responsibility*: To display a title on top of a chart per default

*Collaborators*: must be added to `RSChart`

*Example*:
```Smalltalk
c := RSChart new.
c addPlot: (RSLinePlot new x: (1 to: 200) y: (1 to: 200) sqrt).
c addDecoration: (RSChartTitleDecoration new title: 'Square root').

""The line above can also be writen as:
c title: 'Square root'.
""
c open
```
"
Class {
	#name : #RSChartTitleDecoration,
	#superclass : #RSAbstractLabelDecoration,
	#category : #'Roassal3-Chart-Decoration'
}

{ #category : #rendering }
RSChartTitleDecoration >> defaultFontSize [
	^ 15
]

{ #category : #rendering }
RSChartTitleDecoration >> initialize [
	super initialize.
	self fontSize: self defaultFontSize.
	self rotationAngle: 0
]

{ #category : #rendering }
RSChartTitleDecoration >> renderIn: canvas [
	| label |
	label := self createLabel.
	canvas add: label.
	RSLocation new
		offset: 0@ -2;
		above; center;
		stick: label on: self spine.
]
