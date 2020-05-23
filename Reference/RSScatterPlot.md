[list of classes](reference.md)
# RSScatterPlot
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

