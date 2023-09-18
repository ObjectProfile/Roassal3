"
Utility class for RSTreeMapLayout
"
Class {
	#name : #RSRectangleTreeMap,
	#superclass : #Rectangle,
	#instVars : [
		'currentSubrectangle',
		'subrectangles',
		'inset'
	],
	#category : #'Roassal3-TreeMap-Rectangle'
}

{ #category : #'instance creation' }
RSRectangleTreeMap class >> fromContainerBounds: aRectangle withInset: anInteger [
	| treeRectangle relativeOrigin relativeCorner |
	treeRectangle := self new.
	treeRectangle inset: anInteger.
	relativeOrigin := aRectangle origin-(aRectangle extent/2).
	relativeCorner := aRectangle corner- (aRectangle extent /2).
	((aRectangle width < (anInteger * 2)) or: [ aRectangle height < (anInteger * 2) ])
		ifTrue: [ treeRectangle origin: relativeOrigin; corner: relativeCorner.]
		ifFalse: [
			treeRectangle origin: relativeOrigin +anInteger;
			corner: relativeCorner -anInteger   ].
	^ treeRectangle
]

{ #category : #adding }
RSRectangleTreeMap >> addSubrectangle: aTreeRectangle [
	self subrectangles add: aTreeRectangle.
	self currentSubrectangle: aTreeRectangle
]

{ #category : #utilities }
RSRectangleTreeMap >> computeHorizontalRemainingSubrectangleFrom: row [

	| areaToLayout remainingSubrectangle currentRect currentOrigin |

	areaToLayout := row inject: 0 into: [ :s :e | s + (e propertyAt: #area) ].

	remainingSubrectangle := self class new.

	currentRect := self currentSubrectangle.
	currentOrigin := currentRect origin.

	remainingSubrectangle origin: ((currentOrigin x + (areaToLayout / currentRect height)) @ currentOrigin y).
	remainingSubrectangle corner: currentRect corner.

	^ remainingSubrectangle
]

{ #category : #utilities }
RSRectangleTreeMap >> computeRemainingSubrectangleFrom: row [
	(self currentSubrectangle isHorizontal)
		ifTrue: [^ self computeHorizontalRemainingSubrectangleFrom: row ]
		ifFalse: [ ^ self computeVerticalRemainingSubrectangleFrom: row ]
]

{ #category : #utilities }
RSRectangleTreeMap >> computeVerticalRemainingSubrectangleFrom: row [

	| areaToLayout remainingSubrectangle currentRect currentOrigin |

	areaToLayout := row inject: 0 into: [ :s :e | s + (e propertyAt: #area) ].

	remainingSubrectangle := RSRectangleTreeMap new.

	currentRect := self currentSubrectangle.
	currentOrigin := currentRect origin.

	remainingSubrectangle origin: ((currentOrigin x) @ ((currentOrigin y) + (areaToLayout / currentRect width))).
	remainingSubrectangle corner: currentRect corner.

	^ remainingSubrectangle
]

{ #category : #accessing }
RSRectangleTreeMap >> corner: aPoint [
	corner := aPoint
]

{ #category : #accessing }
RSRectangleTreeMap >> currentSubrectangle [
	^ currentSubrectangle ifNil: [ currentSubrectangle := self ]
]

{ #category : #accessing }
RSRectangleTreeMap >> currentSubrectangle: aRectangle [
	currentSubrectangle := aRectangle
]

{ #category : #accessing }
RSRectangleTreeMap >> inset [
	^ inset
]

{ #category : #accessing }
RSRectangleTreeMap >> inset: aPoint [
	inset := aPoint
]

{ #category : #testing }
RSRectangleTreeMap >> isHorizontal [
	^ (self width >= self height)
]

{ #category : #accessing }
RSRectangleTreeMap >> origin: aPoint [
	origin := aPoint
]

{ #category : #utilities }
RSRectangleTreeMap >> shortestSide [
	^ self width min: self height
]

{ #category : #accessing }
RSRectangleTreeMap >> subrectangles [
	^ subrectangles ifNil: [subrectangles := OrderedCollection new]
]
