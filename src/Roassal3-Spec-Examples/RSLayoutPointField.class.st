"
Similar to number field but I can handle points
"
Class {
	#name : #RSLayoutPointField,
	#superclass : #RSLayoutField,
	#category : #'Roassal3-Spec-Examples-Layout'
}

{ #category : #accessing }
RSLayoutPointField >> layoutValue [
	| value |
	value := super layoutValue.
	value ifNil: [ ^ 'nil' ].
	^ value x asString , ' @ ', value y asString
]

{ #category : #accessing }
RSLayoutPointField >> transform: aString [
	| point |
	point := self class compiler evaluate: aString.
	point ifNil: [ ^ nil ].
	self assert: point isPoint description: 'You should provide a string'.
	^ point
]
