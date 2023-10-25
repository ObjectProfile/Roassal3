Extension { #name : 'RSHorizontalLineLayout' }

{ #category : '*Roassal-Class-Examples' }
RSHorizontalLineLayout class >> example1 [
	| c |
	c := self canvasExample.
	self new
		alignMiddle;
		gapSize: 30;
		on: c nodes.
	^ c open
]

{ #category : '*Roassal-Class-Examples' }
RSHorizontalLineLayout class >> exampleLabel [
	| c |
	c := RSCanvas new.
	c addAll: (#(This is very important) collect: [ :string | | label |
		label := RSLabel new
			text: string;
			color: Color black;
			yourself.
		string == #This
			ifTrue: [ label bold; color: Color blue; fontSize: 20 ].
		string == #important
			ifTrue: [ label bold; color: Color red; fontSize: 30 ].
		label
		] ).
	c @ RSCanvasController.
	self new
		alignLabel;
		gapSize: 3;
		on: c nodes.
	^ c open
]
