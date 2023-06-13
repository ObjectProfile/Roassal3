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

{ #category : #initialization }
RSChartTitleDecoration >> initialize [
	super initialize.
	self fontSize: 15.
	location
		offset: 0@ -2;
		above; center
]
