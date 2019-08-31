Class {
	#name : #PLTSpineDecoration,
	#superclass : #PLTDecoration,
	#category : #'Roassal3-Matplotlib'
}

{ #category : #rendering }
PLTSpineDecoration >> renderIn: canvas [
	| box |
	box := TSBox new color: nil; extent: plt extent; border: TSBorder new.
	box translateTo: (plt extent x / 2) @ (plt extent y negated / 2).
	canvas addShape: box
]
