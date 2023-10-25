"
this field can use a number or a block evaluator, user can select one from a list of options
"
Class {
	#name : 'RSLayoutEvalField',
	#superclass : 'RSLayoutField',
	#category : 'Roassal-LayoutStudio-Fields',
	#package : 'Roassal-LayoutStudio',
	#tag : 'Fields'
}

{ #category : 'accessing' }
RSLayoutEvalField >> transform: aString [
	| point |
	point := self class compiler evaluate: aString.
	point ifNil: [ ^ nil ].
	^ point
]
