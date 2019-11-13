Class {
	#name : #RSVerticalTick,
	#superclass : #RSAbstractTick,
	#category : #'Roassal3-Matplotlib'
}

{ #category : #rendering }
RSVerticalTick >> renderIn: canvas [

	| numberOfTicks scale aTick e1 e2 tickSize |
	numberOfTicks := 5.
	tickSize := 3.

"	scale := 
		TSScale linear
			domain: { 1 . numberOfTicks };
			range: { 0. plt extent x }."
	scale := self createXScale.

	1 to: numberOfTicks do: [ :i |
		e1 := RSBox new size: 1.
		e2 := RSBox new size: 1.
		e1 translateTo: 0 @ 0.
		e2 translateTo: 0 @ 5.
		aTick := RSLine new from: e1; to: e2.
		aTick attachPoint: (RSCenteredAttachPoint new).
		canvas add: e1; add: e2; add: aTick.
		e1 translateTo: (scale scale: i) @ 0.
		e2 translateTo: (scale scale: i) @ tickSize.
		i
		
		 ]
	
]
