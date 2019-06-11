"
I am a basic popup for animated content in a view of roassal3
"
Class {
	#name : #RSAnimatedPopup,
	#superclass : #RSPopup,
	#category : #'Roassal3-Interaction'
}

{ #category : #accessing }
RSAnimatedPopup class >> activationEvent [
	^ TSMouseEnter
]

{ #category : #accessing }
RSAnimatedPopup class >> removeEvents [
	^ removeEvents ifNil: [ 
		removeEvents := { TSMouseClick. TSMouseLeave. TSMouseDragging } ]
]

{ #category : #hooks }
RSAnimatedPopup >> translatePopup: popup event: evt [ 
	| p pscale canvasExtent side  |
	p := evt shape position.
	evt shape isFixed
		ifFalse: [ p := evt canvas camera fromSpaceToPixel: p ].
	p := p + (0@(evt shape height + popup height + 10 / 2)).
	canvasExtent := evt shape canvas extent.
	side := popup width / 2.
	p x + side > canvasExtent x
		ifTrue: [ p := (canvasExtent x - side - 5)@ p y ].
	
	popup translateTo: p.
	pscale := TSScale linear range: { p x @ (p y - (popup height / 2) ) . p }.
	evt shape animation 
		duration: 300 milliSeconds; 
		from: 0.05; to: 1;
		easing: TSEasing backOut;
		onStepDo: [ :t | 
			popup matrix 
				loadIdentity;
				translation: (pscale scale: t);
				scaleBy: 1@t.
			popup signalUpdate.
			].
]
