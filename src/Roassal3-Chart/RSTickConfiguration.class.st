"
<keyClass>
`RSTickConfiguration` describes a configuration for a vertical or horizontal tick. Note that the same configuration can be shared for the two tick objects.

*Responsibility*: maintain the different configurable attributes for vertical or horizontal tickis.

*Collaborators*: used by `RSAbstractTick`

*Variables*:
- `numberOfTicks`: number of ticks the tick decoration should have
- `shouldHaveLabels`: a boolean indicating whether a the tick should have labels or not
- `labelConversion`: one arg block to transform a value. E.g., `[ :p | 'V', p asString ]`
- `shouldUseNiceLabel`: a boolean indicating whether the tick should use the nice tick label generator (e.g., `RSNiceLabel`)
- `labelRotation`: rotation degree of the label
- `fontSize`: size of the label font
- `tickSize`: size of the tick, in pixels

*Example*:
```Smalltalk
classes := RSObject withAllSubclasses.
x := classes collect: [ :c | c numberOfMethods ].
y := classes collect: [ :c | c linesOfCode ].

c := RSChart new.

d := RSScatterPlot new.
d color: Color blue translucent.
d x: x y: y.
c addPlot: d.

tickConfiguration := RSTickConfiguration new
		numberOfTicks: 5;
		fontSize: 5;
		labelRotation: 0;
		shouldHaveLabels: true;
		shouldUseNiceLabel: true;
		labelConversion: [ :value | value ] ;
		tickSize: 3;
		yourself.
c addDecoration: (RSHorizontalTick new configuration: tickConfiguration).
c addDecoration: (RSVerticalTick new configuration: tickConfiguration).
c
```

Another similar example:
```Smalltalk
classes := RSObject withAllSubclasses.
x := classes collect: [ :c | c numberOfMethods ].
y := classes collect: [ :c | c linesOfCode ].

c := RSChart new.

d := RSScatterPlot new.
d color: Color blue translucent.
d x: x y: y.
c addPlot: d.

tickConfiguration := RSTickConfiguration new.
tickConfiguration labelConversion: [ :p | 'V', p asString ].

c addDecoration: (RSHorizontalTick new configuration: tickConfiguration).
c
```
"
Class {
	#name : #RSTickConfiguration,
	#superclass : #Object,
	#instVars : [
		'numberOfTicks',
		'shouldHaveLabels',
		'labelConversion',
		'shouldUseNiceLabel',
		'labelRotation',
		'fontSize',
		'tickSize'
	],
	#category : #'Roassal3-Chart-Ticks'
}

{ #category : #public }
RSTickConfiguration >> createLabelFor: aValue [
	^ RSLabel new
		fontSize: self fontSize;
		text: (self labelConversion rsValue: aValue);
		rotateByDegrees: self labelRotation;
		yourself
]

{ #category : #accessing }
RSTickConfiguration >> fontSize [
	^ fontSize
]

{ #category : #accessing }
RSTickConfiguration >> fontSize: aNumber [
	fontSize := aNumber
]

{ #category : #initialization }
RSTickConfiguration >> initialize [
	super initialize.
	self numberOfTicks: 5;
		fontSize: 5;
		labelRotation: 0;
		shouldHaveLabels: true;
		shouldUseNiceLabel: true;
		labelConversion: [ :value | value ];
		tickSize: 3
]

{ #category : #accessing }
RSTickConfiguration >> labelConversion [
	^ labelConversion
]

{ #category : #accessing }
RSTickConfiguration >> labelConversion: aOneArgBlock [
	labelConversion := aOneArgBlock
]

{ #category : #accessing }
RSTickConfiguration >> labelRotation [
	^ labelRotation
]

{ #category : #accessing }
RSTickConfiguration >> labelRotation: degreesAsNumber [
	labelRotation := degreesAsNumber
]

{ #category : #accessing }
RSTickConfiguration >> numberOfTicks [
	^ numberOfTicks
]

{ #category : #accessing }
RSTickConfiguration >> numberOfTicks: aNumber [
	numberOfTicks := aNumber
]

{ #category : #accessing }
RSTickConfiguration >> shouldHaveLabels [
	^ shouldHaveLabels
]

{ #category : #accessing }
RSTickConfiguration >> shouldHaveLabels: aBoolean [
	shouldHaveLabels := aBoolean
]

{ #category : #accessing }
RSTickConfiguration >> shouldUseNiceLabel [
	^ shouldUseNiceLabel
]

{ #category : #accessing }
RSTickConfiguration >> shouldUseNiceLabel: aBoolean [
	shouldUseNiceLabel := aBoolean
]

{ #category : #accessing }
RSTickConfiguration >> tickSize [
	^ tickSize
]

{ #category : #accessing }
RSTickConfiguration >> tickSize: aNumber [
	tickSize := aNumber
]
