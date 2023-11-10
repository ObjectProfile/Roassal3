"
Performed while mouse is moving over the morph
"
Class {
	#name : 'RSMouseMove',
	#superclass : 'RSAbstractMouseEvent',
	#category : 'Roassal-Event',
	#package : 'Roassal-Event'
}

{ #category : 'accessing' }
RSMouseMove >> fromEvent: aMorphicEvent [
	self positionFromCamera
]
