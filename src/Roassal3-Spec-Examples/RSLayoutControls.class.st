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
RSLayoutControls >> boxLayoutSpace [
	^ 10
]

{ #category : #accessing }
RSLayoutControls >> layoutStudio [
	^ layoutStudio
]

{ #category : #accessing }
RSLayoutControls >> layoutStudio: aSpLayoutStudio [
	layoutStudio := aSpLayoutStudio.
	self updateFields
]

{ #category : #update }
RSLayoutControls >> updateFields [
	| boxLayout |
	boxLayout := SpBoxLayout newVertical.
	boxLayout spacing: self boxLayoutSpace.
	layoutStudio layoutDefinition fields do: [ :each |
		each layoutStudio: layoutStudio.
		each renderIn: boxLayout ].
	self layout: (SpScrollableLayout with: boxLayout)
]
