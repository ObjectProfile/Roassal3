"
<keyClass>
`RSScatterPlot` is a scatter plot. Shapes are defined using two components, X and Y. 

*Responsibility*: create shapes that represent a scatter plot.

*Collaborators*: used by `RSChart`

*Variables*:
- `processBlock`: is either `nil` or refer to a one argument block. This block is used to particularize the shapes.

*Example*:
```Smalltalk
x := OrderedCollection new.
y := OrderedCollection new.
z := OrderedCollection new.
r := Random seed: 42.
1 to: 100 do: [ :i |
	x add: i + (r nextInt: 10).
	y add: i + (r nextInt: 10).
	z add: i + (r nextInt: 10).
].

c := RSChart new.
p := RSScatterPlot new x: x y: y.
p color: Color blue translucent.
p processBlock: [ :shapes | 
		shapes models: z.
		RSNormalizer size
			shapes: shapes;
			from: 2;
			to: 10;
			normalize: #yourself.
		RSNormalizer color
			shapes: shapes;
			normalize: #yourself.
			
			 ].
c addPlot: p.
 
c addDecoration: (RSHorizontalTick new doNotUseNiceLabel asFloat: 3).
c addDecoration: RSVerticalTick new.

c
```



"
Class {
	#name : #RSScatterPlot,
	#superclass : #RSAbstractPlot,
	#instVars : [
		'processBlock'
	],
	#category : #'Roassal3-Chart-Core'
}

{ #category : #initialization }
RSScatterPlot >> defaultShape [
	^ RSEllipse new noPaint
]

{ #category : #testing }
RSScatterPlot >> isScatterPlot [
	^ true
]

{ #category : #accessing }
RSScatterPlot >> processBlock [
	^ processBlock
]

{ #category : #accessing }
RSScatterPlot >> processBlock: oneArgBlock [
	"Set the process block, which is a one-arg block that is executed on the set of shapes after the rendering. It is a hook for particularizing some visual aspects of the plot.
	"
	processBlock := oneArgBlock
]

{ #category : #rendering }
RSScatterPlot >> renderIn: canvas [
	| shapes newPoint color |
	color := self computeColor.
	self checkAssertion.
	shapes := (1 to: xValues size)
		collect: [ :notUsed | 
			self shape copy
				radius: 2;
				color: color ] as: RSGroup.
	1 to: xValues size do: [ :i | 
		| xt yt et |
		et := shapes at: i.
		xt := xValues at: i.
		yt := yValues at: i.
		newPoint := self scalePoint: xt @ yt.
		(self isPointWellDefined: newPoint)
			ifTrue: [ et translateTo: newPoint.
				canvas add: et ] ].
		
	processBlock rsValue: shapes.
]
