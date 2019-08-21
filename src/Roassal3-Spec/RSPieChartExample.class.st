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
RSPieChartExample >> initializeWidgets [
	|  org |
	droplist := self instantiate: SpLabelledDropList.
	org := RPackage organizer.
	packages := (org packageNames 
		select: [ :s | '*Roassal3*' match: s  ]
		thenCollect: [ :s | org packageNamed: s ]) 
		sorted: [:a :b | a linesOfCode > b linesOfCode ].
	totalSum := packages max: #linesOfCode.
	droplist 
		label: 'Roassal Packages';
		items: packages;
		displayBlock: [:i | i name].
		
	chart := self instantiate: RoassalPresenter.
	pie := self instantiate: RoassalPresenter.
	droplist whenSelectedItemChangedDo: [ :pkg | 
		chart script: [ :view | 
			view when: TSExtentChangedEvent do: [ 
				view edges copy do: #remove.
				view elements copy do: #remove.
				
				self visualizeChart: view package: pkg
				 ]
			 ].
		pie script: [ :view| self visualizePie: view package: pkg ] ].
	droplist dropList selectedIndex: 1.
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
RSPieChartExample >> visualizeChart: view package: pkg [
	| generator result ticks scale bscale  viewRect label box  |
	generator := RSLabelGenerator nice: RSNiceStepSizeGenerator new.
	generator setLooseFlag: true.
	result := generator searchMin: 0 max: totalSum desired: 10.
	ticks := result min to: result max by: result step.
	viewRect := Rectangle
		rsCenter: 0@0
		extent: view extent * 0.9.
	scale := TSScale linear
		domain: {result min. result max};
		range: {viewRect bottom. viewRect top }.
	bscale := TSScale linear
		domain: { 0. totalSum };
		range: { 0. viewRect height }.
	
	label := RSShapeBuilder label
		position: [ :n | 20@(scale scale: n) ];
		text: [:n | n >= 1000
			ifTrue: [ ((n / 1000) printShowingDecimalPlaces: 1) ,'K' ]
			ifFalse: [ n asInteger asString ] ].
	box := RSShapeBuilder box
		color: Color lightGray;
		extent:  [ :n | 20@ (bscale scale: n) ];
		onElement;
		position: [ :e | -10@ ((scale scale: 0) - (e height / 2) )   ].
	view add: (box elementOn: pkg linesOfCode).
	view addAll: (label elementsOn: ticks).
	view add: (RSSingleEdgeBuilder polyline
		controlPoints: (ticks collect: [:p | -10 @ (scale scale: p)]);
		marker: (TSBox new extent: 10@2; color: Color black);
		edge)
]

{ #category : #initialization }
RSPieChartExample >> visualizePie: view package: pkg [
	| b rect max |
	b := RSPieBuilder new.
	b view: view.
	
	b shape 
		interactionDo: [ :i | | popup |
			popup := i popup.
			popup multiline.
			popup label text: [ :cls | cls name, String cr, cls linesOfCode asString, 'LOC' ] ];
		innerRadius: 70;
		externalRadius: 150;
		segmentSpacing: 0.1;
		color: TSScale google20.
	b label.
	b 
		objects: (pkg definedClasses sorted: [:x :y | x linesOfCode < y linesOfCode ]);
		slice: #linesOfCode;
		build.
	view addShape: (TSLabel new
		text: pkg linesOfCode asString,'LOC').
	view @ (RSRotatedPieLabel new pieBuilder: b).
	rect := view encompassingRectangle.
	max := rect origin x abs max: rect corner x.
	view when: TSExtentChangedEvent do: [ 
		view camera 
			zoomToFit: view extent 
			rectangle: (Rectangle rsCenter: 0@0 extent: max * 2@0).
		view signalUpdate ].

]
