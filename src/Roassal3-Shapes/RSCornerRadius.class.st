"
I have information about the corner radius and methods to create it
"
Class {
	#name : #RSCornerRadius,
	#superclass : #RSObject,
	#instVars : [
		'bottomRight',
		'bottomLeft',
		'topRight',
		'topLeft'
	],
	#category : #'Roassal3-Shapes-Border'
}

{ #category : #accessing }
RSCornerRadius >> asBezierBottomLeftPoint: point random: random [

	| cps |
	cps := { 
		       (point + (self bottomLeft @ 0)).
		       (point + (self bottomLeft halved @ 0)).
		       (point - (0 @ self bottomLeft halved)).
		       (point - (0 @ self bottomLeft)) } collect: [ :each | 
		       each + (random next abs * (-1 @ 1)) ].

	cps at: 2 put: (cps second x min: cps first x max: cps last x)
		@ (cps second y min: cps first y max: cps last y).

	cps at: 3 put: (cps third x min: cps second x max: cps last x)
		@ (cps third y min: cps second y max: cps last y).

	^ RSBezier new
		  controlPoints: cps;
		  yourself
]

{ #category : #accessing }
RSCornerRadius >> asBezierBottomRightPoint: point random: random [

	| cps |
	cps := { 
		       (point - (0 @ self bottomRight)).
		       (point - (0 @ self bottomRight halved)).
		       (point - (self bottomRight halved @ 0)).
		       (point - (self bottomRight @ 0)) } collect: [ :each | 
		       each + random next abs ].

	cps at: 2 put: (cps second x min: cps first x max: cps last x)
		@ (cps second y min: cps last y max: cps first y).

	cps at: 3 put: (cps third x min: cps second x max: cps last x)
		@ (cps third y min: cps last y max: cps second y).

	^ RSBezier new
		  controlPoints: cps;
		  yourself
]

{ #category : #accessing }
RSCornerRadius >> asBezierTopLeftPoint: point random: random [

	| cps |
	cps := { 
		       (point + (0 @ self topLeft)).
		       (point + (0 @ self topLeft halved)).
		       (point + (self topLeft halved @ 0)).
		       (point + (self topLeft @ 0)) } collect: [ :each | 
		       each + (random next asPoint abs * -1) ].

	cps at: 2 put: (cps second x min: cps last x max: cps first x)
		@ (cps second y min: cps first y max: cps last y).

	cps at: 3 put: (cps third x min: cps last x max: cps second x)
		@ (cps third y min: cps second y max: cps last y).

	^ RSBezier new
		  controlPoints: cps;
		  yourself
]

{ #category : #accessing }
RSCornerRadius >> asBezierTopRightPoint: point random: random [

	| cps |
	cps := { 
		       (point - (self topRight @ 0)).
		       (point - (self topRight halved @ 0)).
		       (point + (0 @ self topRight halved)).
		       (point + (0 @ self topRight)) } collect: [ :each | 
		       each + (random next asPoint abs * (1 @ -1)) ].

	cps at: 2 put: (cps second x min: cps last x max: cps first x)
		@ (cps second y min: cps last y max: cps first y).

	cps at: 3 put: (cps third x min: cps last x max: cps second x)
		@ (cps third y min: cps last y max: cps second y).

	^ RSBezier new
		  controlPoints: cps;
		  yourself
]

{ #category : #accessing }
RSCornerRadius >> bottom: aNumber [
	bottomLeft := bottomRight := aNumber
]

{ #category : #accessing }
RSCornerRadius >> bottomLeft [
	"Define the bottom left of the radius"
	^ bottomLeft
]

{ #category : #accessing }
RSCornerRadius >> bottomLeft: aNumber [
	bottomLeft := aNumber
]

{ #category : #accessing }
RSCornerRadius >> bottomRight [
	^ bottomRight
]

{ #category : #accessing }
RSCornerRadius >> bottomRight: aNumber [
	"Example of value could be 200"
	bottomRight := aNumber
]

{ #category : #initialization }
RSCornerRadius >> initialize [
	super initialize.
	self radius: 0
]

{ #category : #transforming }
RSCornerRadius >> interpolateTo: other at: t [
	"other is an instance of RSCornerRadius
	t is a float between 0 and 1"
	| |
	^ self class new
		topLeft: (self topLeft interpolateTo: other topLeft at: t);
		topRight: (self topRight interpolateTo: other topRight at: t);
		bottomLeft: (self bottomLeft interpolateTo: other bottomLeft at: t);
		bottomRight: (self bottomRight interpolateTo: other bottomRight at: t);
		yourself
]

{ #category : #accessing }
RSCornerRadius >> left: aNumber [
	topLeft := bottomLeft := aNumber
]

{ #category : #accessing }
RSCornerRadius >> max [
	^ topLeft max: (topRight max: (bottomLeft max: bottomRight))
]

{ #category : #accessing }
RSCornerRadius >> min [
	^ topLeft min: (topRight min: (bottomLeft min: bottomRight))
]

{ #category : #accessing }
RSCornerRadius >> radius: aNumber [
	topLeft := topRight := bottomLeft := bottomRight := aNumber
]

{ #category : #accessing }
RSCornerRadius >> right: aNumber [
	topRight := bottomRight := aNumber
]

{ #category : #transforming }
RSCornerRadius >> snoozed [

	| random |
	random := RandomGaussian new.

	^ self class new
		  topLeft: self topLeft * random next abs;
		  topRight: self topRight * random next abs;
		  bottomRight: self bottomRight * random next abs;
		  bottomLeft: self bottomLeft * random next abs;
		  yourself
]

{ #category : #accessing }
RSCornerRadius >> top: aNumber [
	topLeft := topRight := aNumber
]

{ #category : #accessing }
RSCornerRadius >> topLeft [
	^ topLeft
]

{ #category : #accessing }
RSCornerRadius >> topLeft: aNumber [
	topLeft := aNumber
]

{ #category : #accessing }
RSCornerRadius >> topRight [
	^ topRight
]

{ #category : #accessing }
RSCornerRadius >> topRight: aNumber [
	topRight := aNumber
]
