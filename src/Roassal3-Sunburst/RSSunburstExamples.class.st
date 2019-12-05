"
I have basic examples for sunburst
"
Class {
	#name : #RSSunburstExamples,
	#superclass : #RSAbstractExamples,
	#category : #'Roassal3-Sunburst'
}

{ #category : #examples }
RSSunburstExamples >> example01Basic [
	<script: 'self new example01Basic open'>
	| sb |
	sb := RSSunburstBuilder new.
	sb explore: String using: #subclasses.
	sb build.
	sb canvas @ RSCanvasController.
	^ sb canvas
]

{ #category : #examples }
RSSunburstExamples >> example02MultipleRoots [
	<script: 'self new example02MultipleRoots open'>
	| sb |
	sb := RSSunburstBuilder new.
	sb sliceShape 
		withBorder;
		segmentSpacing: 1.
	sb from: { String. RSEvent. RSShape } using:  #subclasses.
	sb build.
	sb canvas @ RSCanvasController.
	^ sb canvas
]

{ #category : #examples }
RSSunburstExamples >> example03ConstantStrategy [
	<script: 'self new example03ConstantStrategy open'>
	| sb |
	sb := RSSunburstBuilder new.
	sb constantWidthStrategy arcWidth: 25.
	sb explore: String using:  #subclasses.
	sb build.
	sb canvas @ RSCanvasController.
	^ sb canvas
]
