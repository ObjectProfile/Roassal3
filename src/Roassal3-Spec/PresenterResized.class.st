"
event used to notify a change of the extent
"
Class {
	#name : #PresenterResized,
	#superclass : #Announcement,
	#instVars : [
		'extent'
	],
	#category : #'Roassal3-Spec-Events'
}

{ #category : #accessing }
PresenterResized >> extent [
	^ extent
]

{ #category : #accessing }
PresenterResized >> extent: anObject [
	extent := anObject
]
