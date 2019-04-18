"
A RSLabeled  adds a label above an element. The label may be particularized using #text: in the default string representation is not sufficient. 

```Smalltalk
	| v es |
	v := RTView new.

	es := RTBox new size: 20; color: Color blue; elementsOn: #('Hello' 'World').
	v addAll: es.
	RTHorizontalLineLayout on: es.

	es do: [ :e |
		e @ (RTLabeled new color: Color red; setAsHighlightable) ]. 
	es @ RTDraggable.
	v
```
"
Class {
	#name : #RSLabeled,
	#superclass : #RSInteraction,
	#instVars : [
		'shape',
		'location'
	],
	#category : #'Roassal3-Interaction'
}

{ #category : #hooks }
RSLabeled >> createLabel: anElement [
	| label v |
	label := shape elementOn: anElement model.
	location stick: label on: anElement.
	v := anElement view.
	v add: label.
	anElement attributes at: #RSLabeled put: label
]

{ #category : #initialization }
RSLabeled >> initialize [ 
	super initialize.
	shape := RSShapeBuilder label.
	location := RSLocate new above.
]

{ #category : #accessing }
RSLabeled >> location [
	^ location
]

{ #category : #hooks }
RSLabeled >> onElement: anElement [
	| block |
	block := [ self createLabel: anElement ]. 
	anElement isInACanvas 
		ifTrue: block
		ifFalse: [ anElement when: TSShapeAddedEvent do: block ].
]

{ #category : #accessing }
RSLabeled >> shape [
	^ shape
]

{ #category : #accessing }
RSLabeled >> shape: aShapeBuilder [
	shape := aShapeBuilder
]
