Class {
	#name : 'RSDSMTest',
	#superclass : 'RSTest',
	#category : 'Roassal-Global-Tests-DSM',
	#package : 'Roassal-Global-Tests',
	#tag : 'DSM'
}

{ #category : 'tests' }
RSDSMTest >> testColor [
	| b |

	b := RSDSM new.
	b objectsX: #(1 2 3 4).
	b objectsY: #( 'A' 'B' 'C' ).
	b color: [ :tuple | Color random ].
	b build
]

{ #category : 'tests' }
RSDSMTest >> testDefault [

	| dsm |
	dsm := RSDSM new.
	self assert: dsm numberOfObjects equals: 0
]

{ #category : 'tests' }
RSDSMTest >> testDep [

	| dsm v ts |
	dsm := RSDSM new.
	dsm hideLabels.
	dsm objects: (1 to: 10).
	dsm dependency: [ :aValue | aValue // 2 ].
	dsm build.
	v := dsm canvas.
	self assert: v shapes size equals: 100.

	ts := v shapes collect: #color as: Set.
	self assert: ts size equals: 2
]

{ #category : 'tests' }
RSDSMTest >> testExample01 [
	| dsm |
	dsm := RSDSM new.
	dsm objects: RSShape withAllSubclasses.
	dsm dependency: #dependentClasses.
	dsm build
]

{ #category : 'tests' }
RSDSMTest >> testExample02 [

	| dsm shapes column5 row5 |
	dsm := RSDSM new.
	dsm objects: (1 to: 10).
	dsm dependency: [ :aValue | aValue // 2 ].
	dsm build.

	shapes := dsm shapes.
	self assert: shapes size equals: 100.
	self assert: (dsm shapeAt: 1 @ 1) model equals: 1 -> 1.
	self assert: (dsm shapeAt: 3 @ 1) model equals: 1 -> 3.
	self assert: (dsm shapeAt: 10 @ 10) model equals: 10 -> 10.
	self assert: (dsm shapeAt: 5 @ 2) model equals: 2 -> 5.

	column5 := dsm columnAt: 5.
	self assert: column5 size equals: 10.
	self assert: column5 first model equals: 5 -> 1.

	row5 := dsm rowAt: 5.
	self assert: row5 size equals: 10.
	self assert: row5 first model equals: 1 -> 5.

	column5 first announce: (RSMouseEnter new shape: column5 first)
]

{ #category : 'tests' }
RSDSMTest >> testLabelShapeColor [
	| b shapes |
	b := RSDSM new.
	b objectsX: #(1 2 3 4).
	b objectsY: #( 'A' 'B' 'C' ).
	b build.
	b labelsX do: [ :label |
		label color: (label model even
			ifTrue: [ Color red ]
			ifFalse: [ Color gray ]) ].
	shapes := b labelsX.
	self assert: shapes first model equals: 1.
	self assert: shapes second color equals: Color red
]

{ #category : 'tests' }
RSDSMTest >> testLabelShapeHeight [
	| b |
	b := RSDSM new.
	b objectsX: #(1 2 3 4).
	b objectsY: #( 'A' 'B' 'C' ).
	b build.
	b labels do: [ :l | l fontSize: 30; color: Color blue ].
	self assert: b labelsX first color equals: Color blue
]

{ #category : 'tests' }
RSDSMTest >> testLabelsLeftPosition [
	| b shapes firstColumn |
	b := RSDSM new.
	b objectsX: (1 to: 3).
	b objectsY: #(#a #b #c).
	b dependency: [ :aValue | aValue + 1 ].
	b build.
	shapes := b labelsY.
	self assert: shapes isNotEmpty.
	firstColumn := b columnAt: 1.
	firstColumn with: shapes do: [ :box :label |
		self assert: box position y equals: label position y  ]
]

{ #category : 'tests' }
RSDSMTest >> testLabelsTopPosition [
	| b labels firstRow |
	b := RSDSM new.
	b objectsY: #(#a #b #c).
	b objectsX: (1 to: 3).
	b rotation: 90.
	b shape size: 50.
	b dependency: [ :aValue | aValue + 1 ].
	b build.
	labels := b labelsX.
	self assert: labels isNotEmpty.
	firstRow := b rowAt: 1.
	firstRow with: labels do: [ :box : label |
		| x x1 x2 |
		x := label encompassingRectangle bottomRight x.
		x1 := box encompassingRectangle topLeft x.
		x2 := box encompassingRectangle topRight x.
		self assert: (x between: x1 and: x2)
		 ]
]

{ #category : 'tests' }
RSDSMTest >> testUsingXAndY [
	| b |

	b := RSDSM new.
	b objectsX: #(1 2 3 4).
	b objectsY: #( 'A' 'B' 'C' ).
	b build.

	self assert: b objectsX size equals: 4.
	self assert: b objectsY size equals: 3
]
