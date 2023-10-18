"
I am an example
"
Class {
	#name : 'RSPunchCardBuilder',
	#superclass : 'RSBuilder',
	#instVars : [
		'objects',
		'metrics',
		'size'
	],
	#category : 'Roassal-Builders-Example',
	#package : 'Roassal-Builders',
	#tag : 'Example'
}

{ #category : 'accessing' }
RSPunchCardBuilder >> addMetric: aRoassalValue name: name [
	metrics at: name put: aRoassalValue
]

{ #category : 'accessing' }
RSPunchCardBuilder >> boxSize [
	^ size
]

{ #category : 'accessing' }
RSPunchCardBuilder >> boxSize: aNumber [
	size := aNumber
]

{ #category : 'accessing - defaults' }
RSPunchCardBuilder >> defaultContainer [
	^ RSCanvas new @ RSCanvasController
]

{ #category : 'initialization' }
RSPunchCardBuilder >> initialize [
	super initialize.
	metrics := OrderedDictionary new.
	self boxSize: 10
]

{ #category : 'hooks' }
RSPunchCardBuilder >> labelFor: obj [
	^ RSLabel new
		text: obj;
		scaleBy: 0.2;
		yourself
]

{ #category : 'accessing' }
RSPunchCardBuilder >> metrics [
	^ metrics
]

{ #category : 'accessing' }
RSPunchCardBuilder >> objects [
	^ objects
]

{ #category : 'accessing' }
RSPunchCardBuilder >> objects: aCollection [
	objects := aCollection
]

{ #category : 'hooks' }
RSPunchCardBuilder >> renderDots: aCanvas [
	| base |
	base := RSEllipse new popup.
	objects
		doWithIndex: [ :cls :x |
			metrics keys
				doWithIndex: [ :k :y |
					| metric res |
					metric := metrics at: k.
					res := metric rsValue: cls.
					aCanvas
						add:
							(base copy
								model: res;
								position: x @ y * size;
								size: (res + 1) ln + 1;
								announcer: base announcer) ] ]
]

{ #category : 'rendering' }
RSPunchCardBuilder >> renderIn: aCanvas [

	self
		renderDots: aCanvas;
		renderXAxis: aCanvas;
		renderYAxis: aCanvas
]

{ #category : 'hooks' }
RSPunchCardBuilder >> renderXAxis: aCanvas [

	| labels |
	labels := objects collectWithIndex: [ :cls :x |
		          | label |
		          label := (self labelFor: cls) rotateByDegrees: -90.
		          label position: x @ 0 * size.
		          label ].
	RSAlignment new
		shapes: labels;
		bottom.
	aCanvas addAll: labels
]

{ #category : 'hooks' }
RSPunchCardBuilder >> renderYAxis: aCanvas [

	| labels |
	labels := metrics keys collectWithIndex: [ :k :i |
		          (self labelFor: k)
			          position: 0 @ i * size;
			          yourself ].
	RSAlignment new
		shapes: labels;
		right.
	aCanvas addAll: labels
]
