"
I am a basic example of roassal with spec
"
Class {
	#name : #RSPieChartExample,
	#superclass : #SpPresenter,
	#instVars : [
		'pie',
		'chart',
		'droplist',
		'packages',
		'totalSum'
	],
	#category : #'Roassal3-Spec-Examples'
}

{ #category : #specs }
RSPieChartExample class >> defaultSpec [ 
	<spec: #default>
	^ SpBoxLayout newVertical
		add: #droplist withConstraints: [ :c | c height: self toolbarHeight ];
		add: (SpBoxLayout newHorizontal 
			add: #chart withConstraints: [:c | c width: 70];
			add: #pie;
			yourself);
		yourself
]

{ #category : #accessing }
RSPieChartExample >> chart [
	^ chart
]

{ #category : #accessing }
RSPieChartExample >> droplist [
	^ droplist
]

{ #category : #initialization }
RSPieChartExample >> initializePresenters [
	| org |
	droplist := self instantiate: SpLabelledDropList.
	org := RPackage organizer.
	packages := (org packageNames
		select: [ :s | '*Roassal3*' match: s ]
		thenCollect: [ :s | org packageNamed: s ])
		sorted: [ :a :b | a linesOfCode > b linesOfCode ].
	totalSum := packages max: #linesOfCode.
	droplist
		label: 'Roassal Packages';
		items: packages;
		display: [ :i | i name ].
	chart := self instantiate: SpRoassalPresenter.
	pie := self instantiate: SpRoassalPresenter.
	droplist whenSelectedItemChangedDo: [ :pkg | 
		chart script: [ :aCanvas | 
			aCanvas
				when: RSExtentChangedEvent
				do: [ aCanvas edges copy do: #remove.
					aCanvas nodes copy do: #remove.
					self visualizeChart: aCanvas package: pkg ] ].
		pie script: [ :view | self visualizePie: view package: pkg ] ].
	droplist dropList selectIndex: 1
]

{ #category : #initialization }
RSPieChartExample >> initializeWindow: w [
	w 
		title: 'Roassal packages';
		initialExtent: 800@500;
		centered
]

{ #category : #accessing }
RSPieChartExample >> pie [
	^ pie
]

{ #category : #running }
RSPieChartExample >> run [
	<script: 'self new openWithSpec'>
]

{ #category : #initialization }
RSPieChartExample >> visualizeChart: canvas package: pkg [
	| generator result ticks scale bscale canvasRect box |
	generator := RSLabelGenerator new.
	generator setLooseFlag: true.
	result := generator searchMin: 0 max: totalSum desired: 10.
	ticks := result min to: result max by: result step.
	canvasRect := Rectangle
		floatCenter: 0@0
		extent: canvas extent * 0.9.
	scale := NSScale linear
		domain: {result min. result max};
		range: {canvasRect bottom. canvasRect top }.
	bscale := NSScale linear
		domain: { 0. totalSum };
		range: { 0. canvasRect height }.
	
	box := RSBox new
		color: Color lightGray;
		extent: 20@ (bscale scale: pkg linesOfCode);
		yourself.
	box position: -10 @ ((scale scale: 0) - (box height /2 )).
	canvas add: box.
	canvas addAll: (ticks collect:[:t | 
		RSLabel new
			position: 20@ (scale scale: t);
			text: (t >= 1000
				ifTrue: [ ((t / 1000) printShowingDecimalPlaces: 1) ,'K' ]
				ifFalse: [ t asInteger asString ]);
			yourself ]).
	
	canvas add: (RSPolyline new
		controlPoints: (ticks collect: [:p | -10 @ (scale scale: p)]);
		marker: (RSBox new extent: 10@2; color: Color black);
		yourself)
]

{ #category : #initialization }
RSPieChartExample >> visualizePie: canvas package: pkg [
	| b rect max |
	b := RSPie new.
	b container: canvas.
	
	b sliceShape
		innerRadius: 70;
		externalRadius: 150;
		segmentSpacing: 0.1.
	b sliceColor: NSScale google20.
	b 
		objects: (pkg definedClasses sorted: [:x :y | x linesOfCode < y linesOfCode ]);
		slice: #linesOfCode;
		build.
	RSRotatedPieLabelDecoration on: b.
	b shapes @ (RSPopup text: [ :cls | 
		cls name, String cr, cls linesOfCode asString, 'LOC' ] ).
	canvas addShape: (RSLabel new
		text: pkg linesOfCode asString,'LOC').
	rect := canvas encompassingRectangle.
	max := rect origin x abs max: rect corner x.
	canvas when: RSExtentChangedEvent do: [ 
		canvas camera 
			zoomToFit: canvas extent 
			rectangle: (Rectangle floatCenter: 0@0 extent: max * 2@0).
		canvas signalUpdate ].

]
