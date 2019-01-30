Class {
	#name : #TSAthensRenderer,
	#superclass : #TSRenderer,
	#category : #'Roassal3-Trachel'
}

{ #category : #visiting }
TSAthensRenderer >> pathOfBox: box [
	| rectangle path |
	box path ifNotNil: [ ^ box path].
	path := athensCanvas createPath: [ :builder | 
		rectangle := box encompassingRectangle.
		builder
			absolute;
			moveTo: rectangle topLeft;
			lineTo: rectangle topRight;
			lineTo: rectangle bottomRight;
			lineTo: rectangle bottomLeft;
			lineTo: rectangle topLeft;
			closePath ].
	box path: path.
	^ path.
]

{ #category : #visiting }
TSAthensRenderer >> visitBox: box [
	| path |
	path := self pathOfBox: box.
	athensCanvas pathTransform restoreAfter: [ 
		athensCanvas fill 
			setPaint: box color;
			drawShape: path.
		].
]
