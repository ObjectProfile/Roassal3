Extension { #name : 'RSLocation' }

{ #category : '*Roassal-Class-Examples' }
RSLocation class >> example1 [
	| canvas box1 box2 label |
	canvas := RSCanvas new.

	box1 := RSBox new size: 50; color: Color gray translucent.
	box2 := RSBox new size: 30; color: Color gray translucent.
	box1 @ RSDraggable.
	box2 @ RSDraggable.
	canvas add: box1; add: box2.

	box1 translateBy: 150 @ -40.

	label := RSLabel new text: 'Move the mouse above me'.
	canvas add: label.
	self new
		above;
		stick: label on: box1.
	^ canvas open
]

{ #category : '*Roassal-Class-Examples' }
RSLocation class >> example2 [
	| canvas group baseShape redShape |
	canvas := RSCanvas new.

	group := RSGroup new.
	group add: (RSLabel new text: 'Base shape, drag me').
	baseShape := group asShape adjustToChildren.
	baseShape color: #lightBlue.
	baseShape @ RSDraggable.
	canvas add: baseShape.

	redShape := RSBox new extent: 60 @ 30; color: #red.
	canvas add: redShape.

	self new
		bottom;
		outer;
		right;
		offset: 20@0;
		stick: redShape on: baseShape.
	"Try changing stick:on: by move:on. Replacing bottom by top"
	^ canvas open
]
