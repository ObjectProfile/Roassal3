"
I am a basic example of roassal with spec
"
Class {
	#name : 'RSPieChartExample',
	#superclass : 'SpPresenter',
	#instVars : [
		'pie',
		'chart',
		'droplist',
		'packages',
		'totalSum'
	],
	#category : 'Roassal-Spec-Examples-Basic',
	#package : 'Roassal-Spec-Examples',
	#tag : 'Basic'
}

{ #category : 'layout' }
RSPieChartExample class >> defaultLayout [
	<spec: #default>
	^ SpBoxLayout newVertical
		add: #droplist withConstraints: [ :c | c height: self toolbarHeight ];
		add: (SpBoxLayout newHorizontal
			add: #chart withConstraints: [:c | c width: 70];
			add: #pie;
			yourself);
		yourself
]

{ #category : 'initialization' }
RSPieChartExample >> initializePresenters [

	| org selectedItem |
	droplist := self instantiate: SpDropListPresenter.
	org := RPackage organizer.
	packages := (org packageNames
		             select: [ :s | '*Roassal*' match: s ]
		             thenCollect: [ :s | org packageNamed: s ]) sorted: [
		            :a
		            :b | a linesOfCode > b linesOfCode ].
	totalSum := packages max: #linesOfCode.
	droplist
		items: packages;
		display: [ :i | i name ].
	chart := self newRoassal.
	pie := self newRoassal.
	selectedItem := packages first.
	chart script: [ :aCanvas |
		aCanvas
			when: RSExtentChangedEvent
			do: [
				aCanvas edges copy do: #remove.
				aCanvas nodes copy do: #remove.
				self visualizeChart: aCanvas package: selectedItem ]
			for: self ].
	pie script: [ :view | self visualizePie: view package: selectedItem ].

	droplist whenSelectedItemChangedDo: [ :pkg |
		selectedItem := pkg.
		chart refresh.
		pie refresh ]
]

{ #category : 'initialization' }
RSPieChartExample >> initializeWindow: aWindow [
	aWindow
		title: 'Roassal packages';
		initialExtent: 800@500;
		centered
]

{ #category : 'running' }
RSPieChartExample >> run [
	<script: 'self new asWindow open'>
]

{ #category : 'initialization' }
RSPieChartExample >> visualizeChart: canvas package: pkg [
	| generator result ticks scale bscale canvasRect box |
	generator := NSNiceLinearTicksGenerator new.
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

{ #category : 'initialization' }
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
		objects:
			(pkg definedClasses sorted: [ :x :y |
					 x linesOfCode < y linesOfCode ]);
		slice: #linesOfCode;
		build.
	RSRotatedPieLabelDecorator on: b.
	b shapes @ (RSPopup text: [ :cls |
		 cls name , String cr , cls linesOfCode asString , 'LOC' ]).
	canvas addShape: (RSLabel new text: pkg linesOfCode asString , 'LOC').
	rect := canvas encompassingRectangle.
	max := rect origin x abs max: rect corner x.
	canvas
		when: RSExtentChangedEvent
		do: [
			canvas camera
				zoomToFit: canvas extent
				rectangle: (Rectangle floatCenter: 0 @ 0 extent: max * 2 @ 0).
			canvas signalUpdate ]
		for: self
]
