Extension { #name : #RSEasingInterpolator }

{ #category : #'*Roassal3-Inspector' }
RSEasingInterpolator class >> canvas [
	<script>
	| c shapes selectors masterLabel |
	c := RSCanvas new.
	selectors := #(in out inOut).
	masterLabel := RSLabel new fontSize: 30.
	shapes := { RSLinearInterpolator }, self allSubclasses collect: [ :cls |
		| plots label |
		plots := selectors collect: [ :sel | | i icanvas tanim |
			i := cls new.
			sel value: i.
			icanvas := i canvasForInspector.
			tanim := icanvas animations first.
			tanim repeat.
			c addAnimation: tanim.
			icanvas asShape.
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
	c open.
]
