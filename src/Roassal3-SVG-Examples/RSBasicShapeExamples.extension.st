Extension { #name : #RSBasicShapeExamples }

{ #category : #'*Roassal3-SVG-Examples' }
RSBasicShapeExamples >> example16BasicLinePath [
	<script: 'self new example16BasicLinePath open'>
	| c b1 b2 translate l arrowWidth arrowHeight middle |
	c := RSCanvas new.
	b1 := RSBox new size: 100@100.
	b2 := RSBox new size: 100@100; color: Color blue; position: 100@100.
	c addShape: b1.
	c addShape: b2.

	l := RSSVGPathLine new
		svgPath: [ :aLine |
			[ :canvas | | vector u unit left right left1 right1 a b |
			a := aLine startPoint.
			b := aLine endPoint.
			arrowWidth := 50.
			arrowHeight := 30.
			vector := a-b.
			u := vector normal.
			unit := vector / (vector r max: 1).
			middle := b + (unit* arrowHeight).
			left := middle - (u * arrowWidth / 4).
			right := middle + (u * arrowWidth / 4).
			left1 := middle - (u * arrowWidth / 2).
			right1 := middle + (u * arrowWidth / 2).

			canvas
				absolute;
				moveTo: a;
				lineTo: left;
				lineTo: left1;
				lineTo: b;
				lineTo: right1;
				lineTo: right;
				close.
			 ]
			 ];
		width: 5;
		paint: Color yellow;
		dashArray: { 10. 2 };
		joinMiter;
		startPoint: 0@0;
		endPoint: 100@100.
	c addShape: l.

	translate := [ :evt |
		l
			startPoint: b1 position;
			endPoint: b2 position.
		evt shape translateBy: evt step.
		evt signalUpdate ].
	b1 when: RSMouseDragging do: translate.
	b2 when: RSMouseDragging do: translate.
	^ c
]
