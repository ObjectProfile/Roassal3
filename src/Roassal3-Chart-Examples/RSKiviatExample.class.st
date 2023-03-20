"
examples from RSKiviat
"
Class {
	#name : #RSKiviatExample,
	#superclass : #RSAbstractExamples,
	#category : #'Roassal3-Chart-Examples'
}

{ #category : #examples }
RSKiviatExample >> data [
	^ {
		        #( 'Sulfate' 'Nitrate' 'EC' 'OC1' 'OC2' 'OC3' 'OP' 'CO' 'O3' ).
		        {
			        'Basecase'.
			        {
				        { 0.88. 0.01. 0.03. 0.03. 0.00. 0.06. 0.01. 0.00. 0.00 }.
				        { 0.07. 0.95. 0.04. 0.05. 0.00. 0.02. 0.01. 0.00. 0.00 }.
				        { 0.01. 0.02. 0.85. 0.19. 0.05. 0.10. 0.00. 0.00. 0.00 }.
				        { 0.02. 0.01. 0.07. 0.01. 0.21. 0.12. 0.98. 0.00. 0.00 }.
				        { 0.01. 0.01. 0.02. 0.71. 0.74. 0.70. 0.00. 0.00. 0.00 } } }.
		        {
			        'With CO'.
			        {
				        { 0.88. 0.02. 0.02. 0.02. 0.00. 0.05. 0.00. 0.05. 0.00 }.
				        { 0.08. 0.94. 0.04. 0.02. 0.00. 0.01. 0.12. 0.04. 0.00 }.
				        { 0.01. 0.01. 0.79. 0.10. 0.00. 0.05. 0.00. 0.31. 0.00 }.
				        { 0.00. 0.02. 0.03. 0.38. 0.31. 0.31. 0.00. 0.59. 0.00 }.
				        { 0.02. 0.02. 0.11. 0.47. 0.69. 0.58. 0.88. 0.00. 0.00 } } }.
		        {
			        'With O3'.
			        {
				        { 0.89. 0.01. 0.07. 0.00. 0.00. 0.05. 0.00. 0.00. 0.03 }.
				        { 0.07. 0.95. 0.05. 0.04. 0.00. 0.02. 0.12. 0.00. 0.00 }.
				        { 0.01. 0.02. 0.86. 0.27. 0.16. 0.19. 0.00. 0.00. 0.00 }.
				        { 0.01. 0.03. 0.00. 0.32. 0.29. 0.27. 0.00. 0.00. 0.95 }.
				        { 0.02. 0.00. 0.03. 0.37. 0.56. 0.47. 0.87. 0.00. 0.00 } } }.
		        {
			        'CO & O3'.
			        {
				        { 0.87. 0.01. 0.08. 0.00. 0.00. 0.04. 0.00. 0.00. 0.01 }.
				        { 0.09. 0.95. 0.02. 0.03. 0.00. 0.01. 0.13. 0.06. 0.00 }.
				        { 0.01. 0.02. 0.71. 0.24. 0.13. 0.16. 0.00. 0.50. 0.00 }.
				        { 0.01. 0.03. 0.00. 0.28. 0.24. 0.23. 0.00. 0.44. 0.88 }.
				        { 0.02. 0.00. 0.18. 0.45. 0.64. 0.55. 0.86. 0.00. 0.16 } } } }
]

{ #category : #examples }
RSKiviatExample >> example01Basic [
	<script: 'self new example01Basic open'>
	| kiviat |
	kiviat := RSKiviat new.
	kiviat addRow: #(1 5 2 2 3).
	kiviat axisNames: #('processing cost' 'mechanical properties' 'chemical stability'
           'thermal stability' 'device integration').

	^ kiviat
]

{ #category : #examples }
RSKiviatExample >> example02PolygonBackground [
	<script: 'self new example02PolygonBackground open'>
	| kiviat |
	kiviat := RSKiviat new.
	kiviat addRow: #(1 5 2 2 3).

	kiviat axisNames: #('processing cost' 'mechanical properties' 'chemical stability'
           'thermal stability' 'device integration').
	kiviat usePolygon.
	^ kiviat
]

{ #category : #examples }
RSKiviatExample >> example03WithBorder [
	<script: 'self new example03WithBorder open'>
	| kiviat |
	kiviat := RSKiviat new.
	kiviat addRow: #(1 5 2 2 3).

	kiviat axisNames: #('processing cost' 'mechanical properties' 'chemical stability'
           'thermal stability' 'device integration').
	kiviat usePolygonBorder.
	kiviat useDots.
	^ kiviat
]

{ #category : #examples }
RSKiviatExample >> example04Restaurant [
	<script: 'self new example04Restaurant open'>
	| kiviat |
	kiviat := RSKiviat new.
	kiviat
		addRow: #(4 4 5 4 3);
		addRow: #(5 5 4 5 2);
		addRow: #(3 4 5 3 5).

	kiviat axisNames: #('Food Quality' 'Food Variety' 'Service Quality' 'Ambience' 'Affordability').
	kiviat usePolygonBorder.
	kiviat useDots.
	kiviat noPolygonFillColor.
	^ kiviat
]

{ #category : #examples }
RSKiviatExample >> example05RestaurantAnimation [
	<script: 'self new example05RestaurantAnimation open'>
	| kiviat shapes canvas animatedPolygon animations title |
	kiviat := self example04Restaurant.
	kiviat usePolygonFillColor.
	kiviat noDots.
	kiviat build.
	shapes := kiviat polygonShapes.
	shapes do: #remove.
	canvas := kiviat canvas.
	canvas add: (animatedPolygon := RSPolygon new withBorder).
	canvas add: (title := RSLabel new
		text: 'Restaurant: 1';
		fontSize: 15;
		color: 'black';
		position: 0@ -250).
	animations := shapes collectWithIndex: [:fromShape :index |
		| k toShape |
		k := index + 1.
		k > shapes size ifTrue: [ k := 1 ].
		toShape := shapes at: k.

		canvas transitionAnimation
			duration: 3 seconds;
			easing: RSEasingInterpolator expIn;
			when: RSAnimationEndEvent do: [ :evt | title text: 'Restaurant: ', k asString ];
			onStepDo: [ :t |
				animatedPolygon
					privatePoints: (fromShape points with: toShape points
						collect: [ :p1 :p2 | p1 interpolateTo: p2 at: t ]);
					resetPath;
					color: (fromShape color interpolateTo: toShape color at: t);
					position: (fromShape position interpolateTo: toShape position at: t).
				animatedPolygon border
					color: (fromShape border color interpolateTo: toShape border color at: t).
				canvas signalUpdate ] ].
	(canvas animationFrom: animations) repeat.
	^ kiviat canvas
]

{ #category : #examples }
RSKiviatExample >> example06Chemistry [
	<script: 'self new example06Chemistry open'>
	| data axisNames canvas kiviat lb |
	data := self data.
	axisNames := data first.
	data := data allButFirst.
	canvas := RSCanvas new.
	canvas addAll: (data collect: [ :each | | name |
		name := each first.
		kiviat := RSKiviat new.
		kiviat addRows: each second.
		kiviat axisNames: axisNames.
		kiviat radius: 100.
		kiviat usePolygonBorder.
		kiviat asShapeFor: name.
		 ]).
	canvas nodes @ (RSLabeled new
		shapeBuilder: [:model |
			RSLabel new
				color: 'black';
				fontSize: 12;
				text: model;
				yourself]).
	RSGridLayout new gapSize: 20; on: canvas nodes.
	lb := RSLegend new.
	lb container: canvas.
	kiviat values doWithIndex: [ :array :index |
		lb text: 'Factor ',index asString withBoxColor: (kiviat palette scale: array).
	].
	lb legendDo: [ :s | s scaleBy: 0.5; withBorder; padding: 10 ].
	lb location inner top.
	lb build.
	canvas @ RSCanvasController.

	^ canvas
]
