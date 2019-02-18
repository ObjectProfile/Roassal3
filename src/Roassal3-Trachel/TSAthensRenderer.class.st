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
	| rectangle path halfWidth halfHeight |
	ellipse path ifNotNil: [ ^ ellipse path ].
	rectangle := ellipse encompassingRectangle.
	halfWidth := rectangle width / 2 asFloat.
	halfHeight := rectangle height / 2 asFloat.
	path := athensCanvas createPath: [ :builder | 
		builder
			absolute;
			moveTo: ellipse position;
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
		athensCanvas 
			setPaint: ellipse color;
			drawShape: path.
		].
]

{ #category : #visiting }
TSAthensRenderer >> visitGroup: group [
	| rectangle |
	rectangle := group encompassingRectangle.
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
