"
Similar to number field but I can handle points
"
Class {
	#name : #RSLayoutPointField,
	#superclass : #RSLayoutEvalField,
	#category : #'Roassal3-LayoutStudio-Fields'
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
	point := super transform: aString.
	self assert: point isPoint description: 'You should provide a point'.
	^ point
]
