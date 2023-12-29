Extension { #name : 'RSEasingInterpolator' }

{ #category : '*Roassal-Inspector' }
RSEasingInterpolator class >> canvas [
	<script>
	| c shapes selectors masterLabel theme radScale |
	c := RSCanvas new.
	theme := Smalltalk ui theme.
	c color: theme backgroundColor.
	selectors := #(in out inOut).
	masterLabel := RSLabel new
		color: theme textColor;
		fontSize: 30.
	radScale := NSScale linear
		range: { -90. -90 +360 }.
	shapes := { RSLinearInterpolator }, self allSubclasses collect: [ :cls |
		| plots label |
		plots := selectors collect: [ :sel | | i icanvas tanim shape ring ball |
			i := cls new.
			sel value: i.
			icanvas := i canvasForInspector.
			tanim := icanvas animations first.
			tanim repeat.
			c addAnimation: tanim.
			shape := icanvas asShape.
			ring := RSPieSlice new
				externalRadius: shape width * 0.8;
				innerRadius: shape width * 0.75;
				position: shape position;
				alphaAngle: 0;
				betaAngle: 360.
			ball := RSEllipse new
				position: ring position;
				color: Color red;
				size: shape width * 0.1.
			c newAnimation
				duration: tanim duration;
				repeat;
				onStepDo: [ :t | | rad |
					rad := (radScale scale: (i interpolate: t)) degreesToRadians.
					ball position: rad cos @ rad sin * ring middleRadius.
					 ].
			{ ring. shape. ball } asShape
		] as: RSGroup.
		RSVerticalLineLayout new
			gapSize: 200;
			on: plots.
		label := masterLabel copy text: cls name.
		RSLocation new outer; top; center; move: label on: plots.
		plots addFirst: label.
		plots asShape.
	].
	RSHorizontalLineLayout on: shapes.
	c addAll: shapes.
	masterLabel fontSize: 40.
	selectors := selectors collect: [ :sel |
		masterLabel copy
			text: sel;
			rotateByDegrees: -90;
			yourself ].
	selectors with: shapes first children allButFirst do: [ :lbl :box |
		RSLocation new outer; middle; left; offset: -20@0; move: lbl on: box globalEncompassingRectangle ].
	c addAll: selectors.
	c @ RSCanvasController.
	c open
]

{ #category : '*Roassal-Inspector' }
RSEasingInterpolator >> inspectorWithTools: selectors [
	| inspectorCanvas presenter numberField tools |
	inspectorCanvas := super inspectorCanvas.
	presenter := SpPresenter new.

	tools := SpBoxLayout newVertical.
	selectors do: [ :sel |
		numberField := SpNumberInputFieldPresenter new.
		numberField text: (sel value: self) asString.
		numberField whenNumberChangedDo: [ :newValue |
			self perform: sel asMutator with: newValue.
			inspectorCanvas canvas: self canvasForInspector ].
		tools add: sel capitalized asString expand: false.
		tools add: numberField expand: false.
		tools add: ' ' expand: false."gap"
	].

	presenter layout: (SpBoxLayout newHorizontal
		add: inspectorCanvas;
		add: tools withConstraints: [:c| c width: 100; padding: 5 ];
		yourself).
	^ presenter
]
