"
A layout that packs elements according to their bounding box. Check #gap and #preferredAngle.

Here is an example:
```
numberOfBoxes := 900.
r := Random seed: 42.
shapes := RSGroup new.
numberOfBoxes timesRepeat: [ 
	shapes add: (RSBox new width: (r nextInt: 40); height: (r nextInt: 40)) ].

c := RSCanvas new.
c addAll: shapes.
RSRectanglePackLayout new useProgressBar; on: shapes.
c @ RSCanvasController
```

Another example:
```
nodes := (1 to: 20) asArray shuffleBy: (Random seed: 42).

canvas := RSCanvas new.
shapes := RSCircle models: nodes.
shapes size: 30.
canvas addAll: shapes.
RSNormalizer size
    shapes: shapes;
    normalize.

RSRectanglePackLayout on: shapes.
canvas zoomToFit.
canvas open
```
"
Class {
	#name : #RSRectanglePackLayout,
	#superclass : #RSLayout,
	#instVars : [
		'freeSpace',
		'gap',
		'padding',
		'bounds',
		'preferredAngle',
		'shouldUseProgressBar'
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

	maxSpace := elements
		inject: 0@0
		into: [ :sum :el | sum + el extent ].

	padding := maxSpace / elements size * gap / 2.
	maxSpace :=(1 + gap) * maxSpace.

	freeSpace := Set with: (0@0 corner: maxSpace).

	sortedElements := SortedCollection sortBlock:  [ :larger :smaller |
		larger  encompassingRectangle halfPerimeter >
		smaller encompassingRectangle halfPerimeter ].
	sortedElements addAll: elements.

	sortedElements size <= 2 ifTrue: [
		^ RSHorizontalLineLayout on: sortedElements ].

	self shouldUseProgressBar
		ifTrue: [
			sortedElements
				do: [ :element | self packIn: element ]
				displayingProgress: 'Laying out elements' ]
		ifFalse: [
			sortedElements
				do: [ :element | self packIn: element ] ]
]

{ #category : #'public - configuration' }
RSRectanglePackLayout >> doNotUseProgressBar [
	shouldUseProgressBar := false
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
	"Answer the gap between elements, defined as ''percentage'' of average size. For example, 0.2 means 20%."
	^ gap
]

{ #category : #accessing }
RSRectanglePackLayout >> gap: aFloat [
	gap := aFloat
]

{ #category : #initialization }
RSRectanglePackLayout >> initialize [
	super initialize.
	self doNotUseProgressBar.
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
	"Answer the angle (in radians) that the pack algorithm will use to distribute (layout) the elements. For example, setting value of '(2@1) angle', the elements will tend to be distributed horizontally."
	^ preferredAngle
]

{ #category : #accessing }
RSRectanglePackLayout >> preferredAngle: angleInRadians [
	preferredAngle := angleInRadians
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

{ #category : #testing }
RSRectanglePackLayout >> shouldUseProgressBar [
	^ shouldUseProgressBar
]

{ #category : #'public - configuration' }
RSRectanglePackLayout >> useProgressBar [
	"Public method. Make the layout use a progress bar"
	shouldUseProgressBar := true
]
