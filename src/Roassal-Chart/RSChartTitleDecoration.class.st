"
<keyClass>
`RSChartTitleDecoration` is a `RSAbstractChartDecoration` that adds a title to a chart.

*Responsibility*: To display a title on top of a chart per default

*Collaborators*: must be added to `RSChart`

*Example*:
```Smalltalk
p := RSLinePlot new x: (1 to: 200) y: (1 to: 200) sqrt.
p addDecoration: (RSChartTitleDecoration new title: 'Square root').

""The line above can also be writen as:
p title: 'Square root'.
""
p open
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

{ #category : #initialization }
RSChartTitleDecoration >> isTitle [

	^ true
]
