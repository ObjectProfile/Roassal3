"
<keyClass>
`RSScatterPlot` is a scatter plot. Shapes are defined using two components, X and Y. 

*Responsibility*: create shapes that represent a scatter plot.

*Collaborators*: a plot closely interacts with decorations and can be added in a `RSCompositeChart`.

*Variables*:
- `processBlock`: is either `nil` or refer to a one argument block. This block is used to particularize the shapes.

*Example*:
```Smalltalk
x := OrderedCollection new.
y := OrderedCollection new.
z := OrderedCollection new.
r := Random seed: 42.
1 to: 100 do: [ :i |
	x add: i + (r nextInteger: 10).
	y add: i + (r nextInteger: 10).
	z add: i + (r nextInteger: 10).
].

p := RSScatterPlot new x: x y: y.
p color: Color blue translucent.
 
p horizontalTick doNotUseNiceLabel asFloat: 3.

p build.
shapes := p ellipses.
shapes models: z.
RSNormalizer size
	shapes: shapes;
	from: 2;
	to: 10;
	normalize: #yourself.
RSNormalizer color
	shapes: shapes;
	normalize: #yourself.
p canvas
```



"
Class {
	#name : 'RSScatterPlot',
	#superclass : 'RSAbstractPlot',
	#instVars : [
		'ellipses'
	],
	#category : 'Roassal-Chart-Core',
	#package : 'Roassal-Chart',
	#tag : 'Core'
}

{ #category : 'accessing' }
RSScatterPlot >> createdShapes [
	^ ellipses
]

{ #category : 'accessing - defaults' }
RSScatterPlot >> defaultShape [
	^ RSEllipse new noPaint
]

{ #category : 'accessing' }
RSScatterPlot >> ellipses [
	^ ellipses
]

{ #category : 'testing' }
RSScatterPlot >> isScatterPlot [
	^ true
]

{ #category : 'rendering' }
RSScatterPlot >> renderIn: canvas [
	| newPoint color |
	super renderIn: canvas.
	color := self computeColor.
	self checkAssertion.
	ellipses := (1 to: xValues size)
		collect: [ :notUsed |
			self shape copy
				radius: 2;
				color: color ] as: RSGroup.
	xValues doWithIndex: [ :xt :i |
		| yt et |
		et := ellipses at: i.
		yt := yValues at: i.
		newPoint := self scalePoint: xt @ yt.
		(self isPointWellDefined: newPoint)
			ifTrue: [
				et model: xt @ yt.
				et translateTo: newPoint.
				canvas add: et ] ]
]
