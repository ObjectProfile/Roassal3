"
RSGridLayout places shapes as a grid. Shapes keeps their order, from left to right.

Here is an example

```
c := RSCanvas new.

shapes := RSLabel models: (1 to: 9).
c addAll: shapes.
RSGridLayout on: shapes.
c @ RSCanvasController
```
"
Class {
	#name : #RSGridLayout,
	#superclass : #RSAbstractGridLayout,
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #hook }
RSGridLayout >> doExecute: shapes [
	| pointer lineItemCount lineItemSize maxLastLineHeight originalGapLeft originalGapTop |
	originalGapLeft := 0.
	originalGapTop := 0.

	pointer := originalGapLeft @ originalGapTop.
	lineItemSize := self lineItemsCountBlock rsValue: shapes.
	lineItemCount := 0.
	maxLastLineHeight := 0.

	shapes
		do: [ :element |
			translator translateTopLeftOf: element to: pointer.
			pointer := (pointer x + element width + self gapSize) @ pointer y.
			lineItemCount := lineItemCount + 1.
			maxLastLineHeight := maxLastLineHeight max: element height.
			lineItemCount >= lineItemSize
				ifTrue: [
					pointer := originalGapLeft @ (pointer y + (self gapSize) + maxLastLineHeight).

					maxLastLineHeight := 0.
					lineItemCount := 0 ].
			self step ]
]
