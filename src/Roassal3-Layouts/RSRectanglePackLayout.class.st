"
A layout that packs rectangles in as small space as possible (at least it tries to)

"
Class {
	#name : #RSRectanglePackLayout,
	#superclass : #RSLayout,
	#instVars : [
		'freeSpace',
		'gap',
		'padding',
		'bounds',
		'preferredAngle'
	],
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #'space-calculation' }
RSRectanglePackLayout >> bestSpaceFor: anElement [
	| elementsPadedBox suitableSpaces |
	
	elementsPadedBox := anElement encompassingRectangle extendBy: padding * 2.
	
	suitableSpaces := freeSpace select: [ :space |
		elementsPadedBox width <= space width and:
			[ elementsPadedBox height <= space height ] ].
	
	^ suitableSpaces
		fold: [ :best :current |
			| bestExt currentExt | 
			((currentExt := self extentByInserting: elementsPadedBox into: current) <
			(bestExt := self extentByInserting: elementsPadedBox into: best) or: [ 
				currentExt = bestExt and: [
					current halfPerimeter < best halfPerimeter ] ])
						ifTrue: [ current ]
						ifFalse: [ best ] ]
]

{ #category : #accessing }
RSRectanglePackLayout >> boundingBox [
	^ bounds
]

{ #category : #hook }
RSRectanglePackLayout >> doExecute: elements [
	| sortedElements maxSpace |
	bounds := 0@0.
	
	maxSpace := elements inject: 0@0 into: [ :sum :el |
			sum + el extent ].
		
	padding := maxSpace / elements size * gap / 2.
	maxSpace :=(1 + gap) * maxSpace.
	
	freeSpace := Set new.
	freeSpace add: (0@0 corner: maxSpace ).
	
	sortedElements := SortedCollection sortBlock:  [ :larger :smaller |
		larger  encompassingRectangle halfPerimeter >
		smaller encompassingRectangle halfPerimeter ].
	sortedElements addAll: elements.
	
	sortedElements size <= 2 ifTrue: [ 
		RSHorizontalLineLayout on: sortedElements.
		^ self
	].
	sortedElements
		do: [ :element | self packIn: element ]
		displayingProgress: 'Laying out elements'
]

{ #category : #'space-calculation' }
RSRectanglePackLayout >> extentByInserting: aRectangle into: aSpace [
	| futureCorner preferredAngleInDegrees |
	futureCorner := aSpace origin + aRectangle extent.
	 
	preferredAngleInDegrees := preferredAngle radiansToDegrees.
	
	^ (((futureCorner max: bounds) degrees - preferredAngleInDegrees) abs / preferredAngleInDegrees + 1) 

]

{ #category : #accessing }
RSRectanglePackLayout >> gap [
	"gap between elements defined as ''percentage'' of average size. 0.2 means 20%"
	^ gap
]

{ #category : #accessing }
RSRectanglePackLayout >> gap: anObject [
	gap := anObject
]

{ #category : #'initialize-release' }
RSRectanglePackLayout >> initialize [
	super initialize.
	gap := 0.2.
	preferredAngle := Float pi / 4. "Squared"
]

{ #category : #execution }
RSRectanglePackLayout >> packIn: anElement [
	translator translateTopLeftOf: anElement to: (self bestSpaceFor: anElement) origin + padding.
	bounds := bounds max: anElement encompassingRectangle bottomRight + padding.
	
	self recalculateFreeSpacesWith: anElement
]

{ #category : #accessing }
RSRectanglePackLayout >> preferredAngle [
	^ preferredAngle
]

{ #category : #accessing }
RSRectanglePackLayout >> preferredAngle: anObject [
	preferredAngle := anObject
]

{ #category : #'space-calculation' }
RSRectanglePackLayout >> recalculateFreeSpacesWith: anElement [
	| rectangle |
	rectangle := anElement encompassingRectangle expandBy: padding.
	freeSpace := freeSpace inject: Set new into: [ :set :space |
		 set
			addAll: (space areasOverlapingOutside: rectangle); 
			yourself ].
		
	"remove subspaces"
	freeSpace := freeSpace reject: [ :subspace | 
		freeSpace anySatisfy: [ :space |
			space ~~ subspace and: [ 
				space containsRect: subspace ] ] ]
	
]
