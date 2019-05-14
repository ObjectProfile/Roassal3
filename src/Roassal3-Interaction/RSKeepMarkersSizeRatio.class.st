"
I am an interaction for edges becacuse I access to markers from edges.

I change the size of the marker allow it to remain in the same size
"
Class {
	#name : #RSKeepMarkersSizeRatio,
	#superclass : #RSInteraction,
	#instVars : [
		'menuBlock'
	],
	#category : #'Roassal3-Interaction'
}

{ #category : #hooks }
RSKeepMarkersSizeRatio >> onElement: anEdge [
	| view markers sizes offsets |
	anEdge isInACanvas ifFalse: [ self error: 'add this edge to a view first' ].
	view := anEdge view.
	markers := anEdge markers select: #notNil.
	sizes := markers collect: [:marker | marker shape extent].
	offsets := markers collect: #offset.
	view when: TSScaleChangedEvent do: [ :evt | | delta |
		delta := 1 / evt newScale.
		markers doWithIndex: [ :marker :index | 
			marker shape extent: delta * (sizes at: index).
			marker offset: delta * (offsets at: index)  ] ].
]
