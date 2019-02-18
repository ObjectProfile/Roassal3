"
I can create a visual components in a athensCanvas surface.
"
Class {
	#name : #TSAthensRenderer,
	#superclass : #TSRenderer,
	#category : #'Roassal3-Trachel-Trachel'
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
TSAthensRenderer >> pathOfEllipse: ellipse [
	| extent path halfWidth halfHeight |
	ellipse path ifNotNil: [ ^ ellipse path ].
	extent := ellipse extent.
	halfWidth := extent x / 2 asFloat.
	halfHeight := extent y / 2 asFloat.
	path := athensCanvas createPath: [ :builder | 
		builder
			absolute;
			moveTo: 0@0;
			relative;
			moveTo: halfWidth negated @ 0;
			curveVia: 0 @ (halfHeight negated * 0.55)
				and: (0.45 * halfWidth) @ halfHeight negated
				to: halfWidth @ halfHeight negated;
			curveVia: (halfWidth * 0.55) @ 0
				and: halfWidth @ (0.45 * halfHeight)
				to: halfWidth @ halfHeight;
			curveVia: 0 @ (halfHeight * 0.55)
				and: (0.45 * halfWidth negated) @ halfHeight
				to: halfWidth negated @ halfHeight;
			curveVia: (halfWidth negated * 0.55) @ 0
				and: halfWidth negated @ (halfHeight negated * 0.45)
				to: halfWidth negated @ halfHeight negated ].
	ellipse path: path.
	^ path
]

{ #category : #visiting }
TSAthensRenderer >> visitBorder: border [
	| stroke |
	stroke := athensCanvas setStrokePaint: border color.
	stroke width: border width asFloat.
	border style ifNil: [ ^ self ].
	border style applyOn: stroke.
		.
]

{ #category : #visiting }
TSAthensRenderer >> visitBorderIfNecessary: shape [
	shape border ifNil: [ ^ self ].
	shape border width <= 0 ifTrue: [ ^ self ].
	athensCanvas setShape: shape path.
	shape border accept: self.
	athensCanvas draw.
]

{ #category : #visiting }
TSAthensRenderer >> visitBox: box [
	| path |
	path := self pathOfBox: box.
	athensCanvas pathTransform restoreAfter: [ 
		athensCanvas 
			setPaint: box color;
			drawShape: path.
		].
]

{ #category : #visiting }
TSAthensRenderer >> visitEllipse: ellipse [
	| path |
	path := self pathOfEllipse: ellipse.
	athensCanvas pathTransform restoreAfter: [ 
		athensCanvas pathTransform
			multiplyBy: ellipse matrix asFloatTransform.
		athensCanvas 
			setPaint: ellipse color;
			drawShape: path.
		self visitBorderIfNecessary: ellipse.
		].
	
]

{ #category : #visiting }
TSAthensRenderer >> visitGroup: group [
	athensCanvas pathTransform restoreAfter: [ 
		athensCanvas pathTransform 
			translateBy: group position";
			translateBy: (rectangle extent / 4) negated".
		group children do: [ :child |
			child accept: self ].
		].
]

{ #category : #visiting }
TSAthensRenderer >> visitLabel: label [
	athensCanvas pathTransform restoreAfter: [ 
		athensCanvas pathTransform
			multiplyBy: label matrix asFloatTransform;
			translateBy: ((label textWidth / -2) @ (label textHeight / 2)) asFloatPoint;
			translateBy: (0 @ label descent negated) asFloatPoint.
		athensCanvas 
			setPaint: label color;
			setFont: label font;
			drawString: label text.
		].
]
