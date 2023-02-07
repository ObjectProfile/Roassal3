"
This presenter provides a group of controls based on key methods of layout to perform the edition
"
Class {
	#name : #RSLayoutControls,
	#superclass : #SpPresenter,
	#instVars : [
		'layoutStudio'
	],
	#category : #'Roassal3-Spec-Examples-Layout'
}

{ #category : #layout }
RSLayoutControls class >> defaultLayout [
	^ SpBoxLayout newVertical
]

{ #category : #accessing }
RSLayoutControls >> layoutStudio: aSpLayoutStudio [
	layoutStudio := aSpLayoutStudio
]
