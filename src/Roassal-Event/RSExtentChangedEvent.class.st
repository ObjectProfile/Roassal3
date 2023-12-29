"
When a bounding shape uses extent:, width: or height: I will trigger 

Consider the following example:

```
nodes := (1 to: 20) shuffled.

canvas := RSCanvas new.
shapes := RSCircle models: nodes.
shapes size: 30.
canvas addAll: shapes.
RSNormalizer size
    shapes: shapes;
    normalize.

RSFlowLayout on: shapes.
canvas zoomToFit.
canvas when: RSExtentChangedEvent do: [ :event |
    RSFlowLayout new 
        maxWidth: event newExtent;
        on: shapes.
    canvas zoomToFit.
].
canvas open
```
"
Class {
	#name : 'RSExtentChangedEvent',
	#superclass : 'RSShapeEvent',
	#instVars : [
		'oldExtent',
		'newExtent'
	],
	#category : 'Roassal-Event',
	#package : 'Roassal-Event'
}

{ #category : 'accessing' }
RSExtentChangedEvent >> newExtent [
	^ newExtent
]

{ #category : 'accessing' }
RSExtentChangedEvent >> newExtent: aPoint [
	newExtent := aPoint
]

{ #category : 'accessing' }
RSExtentChangedEvent >> oldExtent [
	^ oldExtent
]

{ #category : 'accessing' }
RSExtentChangedEvent >> oldExtent: aPoint [
	oldExtent := aPoint
]

{ #category : 'printing' }
RSExtentChangedEvent >> printOn: aStream [
	aStream <<'newExtent: '.
	newExtent printOn: aStream.
	aStream << ' oldExtent:'.
	oldExtent printOn: aStream
]
