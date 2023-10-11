Class {
	#name : 'RSOSMTest',
	#superclass : 'RSTest',
	#category : 'Roassal3-OpenStreetMap',
	#package : 'Roassal3-OpenStreetMap'
}

{ #category : 'tests' }
RSOSMTest >> testOpen [
	| b window |
	b := RSOSMBuilder new.
	window := b open.
	self assert: window isDisplayed.
	window delete.
]

{ #category : 'tests' }
RSOSMTest >> testRender [
	| b |
	b := RSOSMBuilder new.
	b build.
	b canvas createMorph drawOnMockCanvas
]

{ #category : 'tests' }
RSOSMTest >> testStartEnd [
	| osm canvas |
	osm := RSOSMShape new.
	canvas := RSCanvas new.
	canvas addShape: osm.
	canvas extent: 500@500.
	canvas camera scale: 1.
	osm updateOsmZoomLevel.

	self assert: osm start equals: 63@63
]
