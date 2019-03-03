"
I can create a visual components in a athensCanvas surface.
"
Class {
	#name : #TSAthensRenderer,
	#superclass : #TSRenderer,
	#category : #'Roassal3-Trachel-Core'
}

{ #category : #paint }
TSAthensRenderer >> paintForBitmap: shape [
	| paint |
	^ CairoBackendCache soleInstance 
		at: shape form
		ifAbsentPut: [ 
			paint := (AthensCairoPatternSurfacePaint 
				createForSurface: (AthensCairoSurface 
				fromForm: shape form)).
			paint origin: (shape form extent /2) negated.
			paint  ]
]

{ #category : #'visiting - helpers' }
TSAthensRenderer >> pathOfBox: box [
	| rectangle path simple corner |
	box path ifNotNil: [ ^ box path].
	rectangle  := box baseRectangle.
	simple := [ :b | 
		b
			absolute;
			moveTo: rectangle topLeft;
			lineTo: rectangle topRight;
			lineTo: rectangle bottomRight;
			lineTo: rectangle bottomLeft;
			lineTo: rectangle topLeft;
			closePath ].
	corner := [ :b |
		| c |
		c := box cornerRadius.
		b 
				absolute;
				moveTo: rectangle topLeft + (c topLeft@0);
				lineTo: rectangle topRight - (c topRight@0);
				cwArcTo: rectangle topRight + (0@c topRight) angle: Float halfPi;
				lineTo: rectangle bottomRight- (0 @ c bottomRight);
				cwArcTo: rectangle bottomRight - (c bottomRight @ 0) angle: Float halfPi;
				lineTo: rectangle bottomLeft + (c bottomLeft @ 0);
				cwArcTo: rectangle bottomLeft - (0@ c bottomLeft) angle: Float halfPi;
				lineTo: rectangle topLeft + (0@ c topLeft);
				cwArcTo: rectangle topLeft + (c topLeft@0) angle: Float halfPi;
				closePath
		 ].
	path := athensCanvas createPath: [ :builder |
		(box hasCornerRadius 
			ifTrue: [ corner]
			ifFalse: [ simple] ) value: builder
		].
	box path: path.
	^ path.
]

{ #category : #'visiting - helpers' }
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

{ #category : #'visiting - helpers' }
TSAthensRenderer >> pathOfLine: line [
	| path |
	line path ifNotNil: [ ^ line path ].
	path := athensCanvas createPath: [ :builder | 
		builder
			absolute;
			moveTo: line startPoint;
			lineTo: line endPoint ].
	line path: path.
	^ path.
]

{ #category : #'visiting - helpers' }
TSAthensRenderer >> pathOfSVGPathLine: line [
	| path string |
	line path ifNotNil: [ ^ line path ].
	string := line svgPath value: line startPoint value: line endPoint.
	path := athensCanvas createPath: [ :builder | 
		| pathCommands converter |
		converter := ASPathConverter new stream: string readStream.
		pathCommands := converter convertPathData.
		pathCommands
			do: [ :each | builder perform: each first withArguments: each second ]].
	line path: path.
	^ path.
]

{ #category : #visiting }
TSAthensRenderer >> visitBorder: border [
	| stroke style |
	stroke := athensCanvas setStrokePaint: border paint.
	stroke width: border width asFloat.
	style := border style.
	style ifNil: [ ^ self ].
	style dashArray 
		ifNotNil: [ :a | stroke dashes: a offset: style dashOffset ].
	style capStyle
		ifNotNil: [:s | stroke perform: s].
	style joinStyle
		ifNotNil: [:s | stroke perform: s].
	
]

{ #category : #'visiting - helpers' }
TSAthensRenderer >> visitBorderIfNecessary: shape [
	shape border ifNil: [ ^ self ].
	shape border width <= 0 ifTrue: [ ^ self ].
	athensCanvas setShape: shape path.
	shape border accept: self.
	athensCanvas draw.
]

{ #category : #visiting }
TSAthensRenderer >> visitBoundingShape: shape [
	| path paint |
	path := shape pathFor: self.
	athensCanvas pathTransform restoreAfter: [ 
		athensCanvas pathTransform
			multiplyBy: shape matrix asFloatTransform.
		paint := shape paintOn: self.
		paint ifNotNil: [ 
			athensCanvas 
				setPaint: paint;
				drawShape: path ].
		self visitBorderIfNecessary: shape.
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
			setPaint: label paint;
			setFont: label font;
			drawString: label text.
		].
]

{ #category : #visiting }
TSAthensRenderer >> visitLine: line [
	athensCanvas pathTransform restoreAfter: [ 
		line pathFor: self.
		self visitBorderIfNecessary: line.
		].
]
