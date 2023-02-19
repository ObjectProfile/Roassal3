"
RSVerticalGridLayout places shapes as a grid. Shapes keeps their order, from top to down, and then left to right.

Here is an example

```
c := RSCanvas new.

shapes := RSLabel models: (1 to: 9).
c addAll: shapes.
RSVerticalGridLayout on: shapes.
c @ RSCanvasController
```
"
Class {
	#name : #RSVerticalGridLayout,
	#superclass : #RSAbstractGridLayout,
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #hook }
RSVerticalGridLayout >> doExecute: shapes [
	| pointer lineItemCount lineItemSize maxLastLineWidth originalGapLeft originalGapTop |
	originalGapLeft := 0.
	originalGapTop := 0.

	pointer := originalGapLeft @ originalGapTop.
	lineItemSize := self lineItemsCountBlock rsValue: shapes.
	lineItemCount := 0.
	maxLastLineWidth := 0.

	shapes
		do: [ :aShape |
			translator translateTopLeftOf: aShape to: pointer.
			pointer := pointer x @ (pointer y + aShape height + self gapSize).
			lineItemCount := lineItemCount + 1.
			maxLastLineWidth := maxLastLineWidth max: aShape width.
			lineItemCount >= lineItemSize
				ifTrue: [
					pointer := (pointer x + (self gapSize) + maxLastLineWidth) @ originalGapLeft.

					maxLastLineWidth := 0.
					lineItemCount := 0 ].
			self step ]
]
