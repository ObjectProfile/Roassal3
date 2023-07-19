Class {
	#name : #RSOSMTest,
	#superclass : #RSTest,
	#category : #'Roassal3-OpenStreetMap'
}

{ #category : #tests }
RSOSMTest >> testOpen [
	| b window |
	b := RSOSMBuilder new.
	window := b open.
	self assert: window isDisplayed.
	window delete.
]

{ #category : #tests }
RSOSMTest >> testRender [
	| b |
	b := RSOSMBuilder new.
	b build.
	b canvas createMorph drawOnMockCanvas
]
