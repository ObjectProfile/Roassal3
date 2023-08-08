"
`RSAbstractBandPlot` is an abstract kind of plot that will show some graphics inside of bands. In this way a band plot have two main properties: the bands width and the bands offset.

**Responsibility:**
- This class abstracts the common behavior and the concept of the bands.

**Collaborators:** 
- **`NSOrdinalScale`:** This class allows rendering each graphic in one band by assigning the `bandWidth` and the `bandOffset`. In this way, each graphic (`RSBoxShape`, `RSViolinPlotShape`)  knows which part of the canvas it needs to fill.

**Public API and Key Messages**

**Instance Variables:**

**Example:**

"
Class {
	#name : #RSAbstractBandPlot,
	#superclass : #RSAbstractPlot,
	#instVars : [
		'bandScale',
		'dataScale',
		'bandWidth',
		'offset',
		'graphics',
		'horizontal'
	],
	#category : #'Roassal3-Chart-Core'
}

{ #category : #rendering }
RSAbstractBandPlot >> bandsOffset: aNumberInRange [
	offset := aNumberInRange
]

{ #category : #rendering }
RSAbstractBandPlot >> bandsWidth [
	^ bandWidth ifNil: [ bandWidth := self defaultBandsWidth ].
]

{ #category : #rendering }
RSAbstractBandPlot >> bandsWidth: aNumber [
	bandWidth := aNumber.
]

{ #category : #rendering }
RSAbstractBandPlot >> computeBandsOffset [
	| bandValues |
	bandValues := horizontal ifFalse: [ xValues ] ifTrue: [ yValues ].
	graphics doWithIndex: [ :graphic :idx |
		graphic bandOffset: (bandScale scale: (bandValues at: idx)) + offset
	].
]

{ #category : #rendering }
RSAbstractBandPlot >> computeBandsWidth [
	graphics do: [ :graphic | graphic bandWidth: self bandsWidth ].
]

{ #category : #accessing }
RSAbstractBandPlot >> createdShapes [
	^ self subclassResponsibility
]

{ #category : #accessing }
RSAbstractBandPlot >> defaultBandsWidth [
	^ bandScale scale: 1
]

{ #category : #'accessing - defaults' }
RSAbstractBandPlot >> defaultShape [
	^ self subclassResponsibility
]

{ #category : #accessing }
RSAbstractBandPlot >> horizontal [
	graphics do: [ :bs | bs horizontal ].
	horizontal := true.
]
