Class {
	#name : #RSDSMTest,
	#superclass : #TSTest,
	#category : #'Roassal3-DSM'
}

{ #category : #tests }
RSDSMTest >> testDefault [

	| dsm |
	dsm := RSDSM new.
	self assert: dsm numberOfObjects equals: 0
]

{ #category : #tests }
RSDSMTest >> testDep [

	| dsm v ts |
	dsm := RSDSM new.
	dsm doNotShowLabels.
	dsm objects: (1 to: 10).
	dsm dependency: [ :aValue | aValue // 2 ].
	dsm build.
	v := dsm view.
	self assert: v shapes size equals: 100.
	
	ts := v elements collect: #color as: Set.
	self assert: ts size equals: 2 

]

{ #category : #tests }
RSDSMTest >> testExample01 [

	| dsm |
	dsm := RSDSM new.
	dsm objects: TSShape withAllSubclasses.
	dsm dependency: #dependentClasses.
	dsm build
]

{ #category : #tests }
RSDSMTest >> testExample02 [

	| dsm es column5 row5 |
	dsm := RSDSM new.
	dsm objects: (1 to: 10).
	dsm dependency: [ :aValue | aValue // 2 ].
	dsm build.
	
	es := dsm elements.
	self assert: es size equals: 100.
	self assert: (dsm elementAt: 1 @ 1) model equals: 1 -> 1.
	self assert: (dsm elementAt: 3 @ 1) model equals: 1 -> 3.
	self assert: (dsm elementAt: 10 @ 10) model equals: 10 -> 10.
	self assert: (dsm elementAt: 5 @ 2) model equals: 2 -> 5.
	
	column5 := dsm columnAt: 5.
	self assert: column5 size equals: 10.
	self assert: column5 first model equals: 1 -> 5.
	
	row5 := dsm rowAt: 5.
	self assert: row5 size equals: 10.
	self assert: row5 first model equals: 5 -> 1.
	
	column5 first announce: (TSMouseEnter new shape: column5 first trachelShape)
]

{ #category : #tests }
RSDSMTest >> testHightlightElements [
	| b elements |
	b := RSDSM new.
	b objects: (1 to: 3).
	b dependency: [ :aValue | aValue + 1 ].
	b shape color: Color blue.
	b build.
	b highlightElements.
	elements := b view elements select: [ :e| e trachelShape class = TSBox ].
	self assert: elements first color equals: (Color blue).
	b unhighlightElements.
	self assert: elements first color equals: (Color blue).
		
	
]

{ #category : #tests }
RSDSMTest >> testLabelShapeColor [
	| b elements |
	b := RSDSM new.
	b objectsX: #(1 2 3 4).
	b objectsY: #( 'A' 'B' 'C' ).
	b labelShapeX 
		color: [ :n | n even ifTrue: [ Color red ] ifFalse: [ Color veryVeryLightGray ] ].
	b build.
	elements := b view elements select: [ :e | 
		e trachelShape class = TSLabel and: [ e model isKindOf: Number ] ].
	self assert: elements first model equals: 1.
	self assert: elements second color equals: Color red
		
	
]

{ #category : #tests }
RSDSMTest >> testLabelShapeHeight [
	| b elements |
	b := RSDSM new.
	b objectsX: #(1 2 3 4).
	b objectsY: #( 'A' 'B' 'C' ).
	b labelShapesDo: [ :l| l height: 30; color: Color blue ].
	b build.
	elements := b view elements select: [ :e | 
		e trachelShape class = TSLabel ].
	self assert: elements first color equals: Color blue.
	"self assert: elements first height > TSLabel defaultFontSize."
]

{ #category : #tests }
RSDSMTest >> testLabelsTopPosition [
	| b elements firstRow|
	b := RSDSM new.
	b objectsY: (1 to: 3).
	b objectsX: #(#a #b #c).
	b dependency: [ :aValue | aValue + 1 ].
	b build.
	elements := b view elements select: [ :e | 
		e trachelShape class = TSLabel and: [ e model isString ] ]. 
	firstRow := b rowAt: 1.
	firstRow doWithIndex: [ :e :i | 
		self assert: e position x equals: (elements at: i) position x ].
]

{ #category : #tests }
RSDSMTest >> testUsingXAndY [
	| b |

	b := RSDSM new.
	b objectsX: #(1 2 3 4).
	b objectsY: #( 'A' 'B' 'C' ).
	b build.
	
	self assert: b objectsX size equals: 4.
	self assert: b objectsY size equals: 3.
]
