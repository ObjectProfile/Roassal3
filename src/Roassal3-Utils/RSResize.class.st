"
Adjust the size of the Elements.

[ [ [ 
	values := #(35 26 5 18 17 60 36 13 16 28 29 3 8 0 3 2 14 12 13 17 1 9 3 3 4 1 1 1 2 1 1 61).
	v := RSView new.
	n := TSScale category20c.
	shape := RSShapeBuilder box color: n; size: #yourself.
	es := shape elementsOn: values.
	v addAll: es.
	RTResize new elements: es; sameSize.
	RSHorizontalLineLayout new gapSize: 0; on: es.
	
	v @ RSControlsView.
	v open
 ] ] ]
"
Class {
	#name : #RSResize,
	#superclass : #RSAbstractElementHandling,
	#category : #'Roassal3-Utils-PositionAndResize'
}

{ #category : #'accessing - computed' }
RSResize >> biggestElement [
	^ elements inject: elements anyOne into: [ :biggestElement :e | 
			biggestElement extent < e extent
				ifTrue: [ e ] ifFalse: [ biggestElement ] ] 
]

{ #category : #'accessing - computed' }
RSResize >> biggestExtent [
	fixedElement ifNotNil: [ ^ fixedElement extent ].
	^ elements inject: 0 @ 0 into: [ :maxExtent :e | 
			maxExtent max: e extent ] 
]

{ #category : #'accessing - computed' }
RSResize >> highestElement [
	^ elements inject: elements anyOne into: [ :highestElement :e | 
			highestElement extent y < e extent y
				ifTrue: [ e ] ifFalse: [ highestElement ] ] 
]

{ #category : #public }
RSResize >> sameHeight [
	self ifNoFixedElementThen: [ self useHighestElement ].
	elements do: [ :e | e height: self fixedElement height ]
]

{ #category : #public }
RSResize >> sameSize [
	self ifNoFixedElementThen: [ self useBiggestElement ].
	elements do: [ :e | e extent: self fixedElement extent ]
]

{ #category : #public }
RSResize >> sameWidth [
	self ifNoFixedElementThen: [ self useWidestElement ].
	elements do: [ :e | e width: self fixedElement width ]
]

{ #category : #'public - configuration' }
RSResize >> useBiggestElement [
	self fixedElement: self biggestElement
]

{ #category : #'public - configuration' }
RSResize >> useHighestElement [
	self fixedElement: self highestElement 
]

{ #category : #'public - configuration' }
RSResize >> useWidestElement [
	self fixedElement: self widestElement
]

{ #category : #'accessing - computed' }
RSResize >> widestElement [
	^ elements inject: elements anyOne into: [ :widestElement :e | 
			widestElement extent x < e extent x
				ifTrue: [ e ] ifFalse: [ widestElement ] ] 
]
