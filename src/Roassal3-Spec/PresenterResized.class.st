Class {
	#name : #PresenterResized,
	#superclass : #Announcement,
	#instVars : [
		'extent'
	],
	#category : #'Roassal3-Spec'
}

{ #category : #accessing }
PresenterResized >> extent [
	^ extent
]

{ #category : #accessing }
PresenterResized >> extent: anObject [
	extent := anObject
]
