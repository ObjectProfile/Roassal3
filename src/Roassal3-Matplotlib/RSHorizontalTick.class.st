Class {
	#name : #RSHorizontalTick,
	#superclass : #RSAbstractTick,
	#category : #'Roassal3-Matplotlib'
}

{ #category : #rendering }
RSHorizontalTick >> renderIn: canvas [

	| scale aTick e1 e2 lbl |
	scale := self createXScale.
	(chart minValueX to: chart maxValueX count: numberOfTicks) do: [ :i |
		e1 := RSBox new size: 1.
		e2 := RSBox new size: 1.
		aTick := RSLine new from: e1; to: e2.
		aTick attachPoint: (RSCenteredAttachPoint new).
		canvas add: e1; add: e2; add: aTick.
		e1 translateTo: (scale scale: i) @ 0.
		e2 translateTo: (scale scale: i) @ self tickSize.
		
		shouldHaveLabels ifTrue: [ 
			lbl := self createLabelFor: i.
			canvas add: lbl.
			RSLocation new below; move: lbl on: e2
			 ]
		 ]
	
]
