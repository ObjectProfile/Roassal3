"
I am a basic popup for animated content in a view of roassal3
"
Class {
	#name : #RSAnimatedPopup,
	#superclass : #RSPopup,
	#category : #'Roassal3-Interaction-Popup'
}

{ #category : #accessing }
RSAnimatedPopup class >> activationEvent [
	^ RSMouseEnter
]

{ #category : #accessing }
RSAnimatedPopup class >> removeEvents [
	^ removeEvents ifNil: [ 
		removeEvents := { RSMouseClick. RSMouseLeave. RSMouseDragging } ]
]

{ #category : #hooks }
RSAnimatedPopup >> translatePopup: popup event: evt [ 
	| p pscale canvasExtent side scale |
	p := evt shape positionInCanvas.
	evt shape isFixed
		ifFalse: [ p := evt canvas camera fromSpaceToPixel: p ].
	popup translateTo: 0@0.
	p := p + (0@(evt shape height + popup height + 10 / 2)).
	canvasExtent := evt shape canvas extent.
	side := popup width / 2.
	p x + side > canvasExtent x
		ifTrue: [ p := (canvasExtent x - side - 5)@ p y ].
	
	popup translateTo: p.
	
	"animation part"
	pscale := NSScale linear range: { p x @ (p y - (popup height / 2) ) . p }.
	scale := popup matrix sx @ popup matrix sy.
	evt shape newAnimation 
		duration: 300 milliSeconds; 
		from: 0.05; to: 1;
		easing: RSEasingInterpolation backOut;
		onStepDo: [ :t | 
			popup matrix 
				loadIdentity;
				translation: (pscale scale: t);
				scaleBy: (1@t) * scale.
			popup signalUpdate.
			].
]
