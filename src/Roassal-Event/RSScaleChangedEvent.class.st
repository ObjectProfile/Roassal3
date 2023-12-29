"
When canvas changes the scale value of the TSCamera
"
Class {
	#name : 'RSScaleChangedEvent',
	#superclass : 'RSCanvasEvent',
	#instVars : [
		'oldScale',
		'newScale'
	],
	#category : 'Roassal-Event',
	#package : 'Roassal-Event'
}

{ #category : 'accessing' }
RSScaleChangedEvent >> newScale [
	^ newScale
]

{ #category : 'accessing' }
RSScaleChangedEvent >> newScale: aNumber [
	newScale := aNumber
]

{ #category : 'accessing' }
RSScaleChangedEvent >> oldScale [
	^ oldScale
]

{ #category : 'accessing' }
RSScaleChangedEvent >> oldScale: aNumber [
	oldScale := aNumber
]
