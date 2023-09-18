"
just a demo
"
Class {
	#name : #RSXmasTree,
	#superclass : #Object,
	#instVars : [
		'branchPositionFactor',
		'branchLenghtFactor',
		'candidateIndex',
		'amplitude',
		'phaseFactor',
		'twigs',
		'dt',
		'freq',
		'period',
		'time',
		'treeSize',
		'map'
	],
	#category : #'Roassal3-Experimental-Xmas2019'
}

{ #category : #initialization }
RSXmasTree >> initialize [
	super initialize.

	branchLenghtFactor := 0.3.
	branchPositionFactor := 0.3.
	dt := 0.025.
	time := 0.
	self initializeBraches
]

{ #category : #initialization }
RSXmasTree >> initializeBraches [
	| frontiers r growth candList |
	candidateIndex := Array new:3.
	amplitude := Array new:3.
	phaseFactor := Array new: 3.
	frontiers := OrderedCollection new.
	frontiers add: (RSXmasFrontier new
		position: 250@ 500;
		velocity: 0@ -500;
		yourself).
	twigs := OrderedCollection new.
	twigs add: (RSXmasBranch new
		addPosition: frontiers first position;
		addThickness: frontiers first thickness;
		addBaseIndex: 1@1;
		yourself).
	map := OrderedCollection new.
	map add: (1 @ twigs first positions size).

	r := SharedRandom globalGenerator.
	growth := false.
	[ growth ] whileFalse: [
		| growthSum |
		growthSum := 0.
		frontiers copy doWithIndex: [ :f :index|
			f update: branchPositionFactor.
			f finished
				ifTrue: [ growthSum := growthSum + 1 ]
				ifFalse: [ | twig |
					twig := twigs at: index.
					twig
						addPosition: f position;
						addThickness: f thickness.
					map add: index @ (twig positions size).
					r next < branchLenghtFactor ifTrue: [
						f thickness: f thickness * 0.65.
						twig setLastThickness: f thickness.
						f thickness > branchPositionFactor ifTrue: [
							frontiers add: (RSXmasFrontier new
								position: f position;
								velocity: f velocity;
								thickness: f thickness;
								finished: f finished;
								yourself).
							twigs add: (RSXmasBranch new
								addPosition: f position;
								addThickness: f thickness;
								addBaseIndex: index @ ((twigs at: index) positions size);
								yourself).
							index = 1 ifFalse: [
								twigs last baseIndex addAll: twig baseIndex
								 ].
							].
					]
				].
			growth := growthSum = frontiers size.
		].
	].

	treeSize := map size.
	candList := twigs collect: [ :t | t positions size ].

	twigs first
		isCandidate: true;
		dTheta: (Array new: twigs first positions size).
	candList at: 1 put: -1.

	candidateIndex at: 1 put: 1.

	2 to: 3 do: [ :i | | temp foo |
		temp := candList max.
		foo := candList indexOf: temp.
		candidateIndex at: i put: foo.
		(twigs at: foo)
			isCandidate: true;
			dTheta: (Array new: (twigs at: foo) positions size).
		candList at: foo put: -1
		 ].

	amplitude at: 1 put: (r rsNext: 0.006 and: 0.012).
	phaseFactor at: 1 put: (r rsNext: 0.6 and: 1.2).
	freq := r rsNext: 0.5 and: 0.8.
	period := 1 / freq.
	2 to: 3 do: [ :i |
		amplitude at: i put: (amplitude at: i -1) * (r rsNext: 0.9 and: 1.4).
		phaseFactor at: i put: (phaseFactor at: i-1)*(r rsNext: 0.9 and: 1.4) ]
]

{ #category : #public }
RSXmasTree >> renderIn: canvas [
	| color |
	color := (Color r: 80 g: 0 b: 50 range: 255) alpha: 0.4.
	color := Color green alpha: 0.4.
	2 to: treeSize do: [ :index | | t mi |
		mi := map at: index.
		t := twigs at: mi x.
		canvas add: (RSLine new
			isFixed: true;
			width: (t thickness at: mi y);
			color: color;
			startPoint: (t positions at: mi y - 1);
			endPoint: (t positions at: mi y )).
		].
	color := Color white alpha: 0.4.
	twigs do: [ :t |
		canvas add: (RSEllipse new
			isFixed: true;
			position: t positions last;
			color: color;
			size: 12)
		 ]
]

{ #category : #public }
RSXmasTree >> swing [
	1 to: 3 do: [ :i | | t |
		t := twigs at: (candidateIndex at: i).
		1 to: t positions size do: [:j |
			t dTheta at: j put: (amplitude at: i) * dt * Float twoPi * freq *
				(Float twoPi * freq * time - ((phaseFactor at: i) * Float pi * j / t positions size)) cos.
			 ].
		].
	twigs doWithIndex: [ :twig :index |
		twig isCandidate ifTrue: [
			2 to: twig positions size do: [ :id  |
				twig
					branchRotate: id
					theta: (twig dTheta at: id)
					position: twig positions first ] ].
		twig baseIndex do: [ :bi | | t |
			t := twigs at: bi x.
			(t isCandidate not or: [ index = 1 ]) ifFalse: [
				(index = 1 ifTrue: [ 1 ] ifFalse: [ 2 ]) to: twig positions size do: [:k |
					twig
						branchRotate: k
						theta: (t dTheta at: bi y)
						position: t positions first
					].
				 ].
			 ].
		 ].
	time := time + dt.
	time >= period ifTrue: [ time := time - period ]
]

{ #category : #public }
RSXmasTree >> updateCanvas: canvas [

	2 to: treeSize do: [ :index | | t mi |
		mi := map at: index.
		t := twigs at: mi x.
		(canvas edges at: index -1)
			startPoint: (t positions at: mi y - 1);
			endPoint: (t positions at: mi y ).
		].
	twigs doWithIndex: [ :t :index |
		(canvas nodes at: index) position: t positions last ]
]
