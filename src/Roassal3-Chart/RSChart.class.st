Class {
	#name : #RSChart,
	#superclass : #RSAbstractContainerBuilder,
	#category : #'Roassal3-Chart-Core'
}

{ #category : #accessing }
RSChart >> title [

	^ title
]

{ #category : #accessing }
RSChart >> title: aTitle [
	"Set the title of a chart. For example:

```Smalltalk
c := RSChart new.
c addPlot: (RSLinePlot new x: (1 to: 200) y: (1 to: 200) sqrt).
c title: 'Square root'.
c
```
	"

	title := aTitle.
	^ self addDecoration: (RSChartTitleDecoration new title: aTitle)
]
