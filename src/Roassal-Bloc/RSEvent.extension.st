Extension { #name : #RSEvent }

{ #category : #'*Roassal-Bloc' }
RSEvent class >> newFromBlEvent: aBlEvent canvas: roassalCanvas [
	^ self new
		position: (self roassalPositionFor: aBlEvent roassalCanvas: roassalCanvas);
		canvas: roassalCanvas;
		yourself.
]

{ #category : #'*Roassal-Bloc' }
RSEvent class >> roassalPositionFor: aBlEvent roassalCanvas: roassalCanvas [
	"Answer the position of the event translated to a RSCanvas space position as callbacks expect it (where '0@0' is the center of the canvas)."

	| positionOfCanvasInSpace positionOfEventInCanvas |
	positionOfCanvasInSpace := roassalCanvas host canvasElement positionInSpace.
	positionOfEventInCanvas := aBlEvent position - positionOfCanvasInSpace.
	^ roassalCanvas camera fromPixelToSpace: positionOfEventInCanvas

]
