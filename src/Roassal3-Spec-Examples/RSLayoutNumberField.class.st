"
This is a number field and allows to modify a value of the layout
"
Class {
	#name : #RSLayoutNumberField,
	#superclass : #RSLayoutField,
	#category : #'Roassal3-Spec-Examples-Layout'
}

{ #category : #accessing }
RSLayoutNumberField >> transform: aString [
	^ aString asNumber
]
