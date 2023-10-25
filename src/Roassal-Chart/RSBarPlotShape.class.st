Class {
	#name : 'RSBarPlotShape',
	#superclass : 'RSAbstractBandPlotShape',
	#instVars : [
		'data',
		'bar'
	],
	#category : 'Roassal-Chart-Plots',
	#package : 'Roassal-Chart',
	#tag : 'Plots'
}

{ #category : 'accessing' }
RSBarPlotShape class >> data: aValue [
	^ (self new) data: aValue
]

{ #category : 'shapes' }
RSBarPlotShape >> createBar [
	| barPoints |

	barPoints := {
		(bandOffset-(bandWidth/2)) @ (dataScale scale: 0)."bottom left"
		(bandOffset+(bandWidth/2)) @ (dataScale scale: 0)."bottom right"
		(bandOffset+(bandWidth/2)) @ (dataScale scale: data)."top right"
		(bandOffset-(bandWidth/2)) @ (dataScale scale: data)."top left"
	} asOrderedCollection.

	bar points: barPoints
]

{ #category : 'shapes' }
RSBarPlotShape >> createShapesAndLines [
	| shapes |
	self createBar.
	bar color: color.
	shapes := OrderedCollection withAll: { bar. }.
	^ shapes
]

{ #category : 'accessing' }
RSBarPlotShape >> data: aValue [
	data := aValue
]

{ #category : 'shapes' }
RSBarPlotShape >> defaultBar [
	^ RSPolygon new
		color: color;
		border: (RSBorder new color: Color black; joinRound)
]

{ #category : 'initialization' }
RSBarPlotShape >> initialize [
	super initialize.
	bar := self defaultBar.
	horizontal := false.
	shouldShowBand := self defaultShouldShowBand
]

{ #category : 'rendering' }
RSBarPlotShape >> maxDataValue [
	^ data
]

{ #category : 'rendering' }
RSBarPlotShape >> minDataValue [
	| minValue |
	minValue := 0.
	data < 0 ifTrue: [ minValue := data ].
	^ minValue
]

{ #category : 'rendering' }
RSBarPlotShape >> renderIn: canvas [
	self addChildrenToComposite.
	canvas add: self
]
