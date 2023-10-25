Class {
	#name : 'RSForceBasedLayoutTest',
	#superclass : 'RSTest',
	#instVars : [
		'canvas',
		'boxes'
	],
	#category : 'Roassal-Global-Tests-Layouts',
	#package : 'Roassal-Global-Tests',
	#tag : 'Layouts'
}

{ #category : 'running' }
RSForceBasedLayoutTest >> setUp [
	super setUp.
	canvas := RSCanvas new.
	boxes := RSBox models: (10 to: 50).
	RSLineBuilder line
		canvas: canvas;
		shapes: boxes;
		color: (Color blue alpha: 0.5);
		connectFrom: [ :nb | nb // 2 ].
	canvas addAll: boxes
]

{ #category : 'tests' }
RSForceBasedLayoutTest >> testAddNodesAndEdges [

	| groups |
	RSForceBasedLayout new
		start;
		addNodes: boxes;
		addLines: canvas edges;
		step.
	groups := boxes groupedBy: [ :box | box position ].
	self assert: boxes size equals: groups size
]

{ #category : 'tests' }
RSForceBasedLayoutTest >> testAttributes [
	RSForceBasedLayout new
		length: 100;
		charge: -300;
		center: 200@200;
		on: boxes.
	self assertIntegerPosition: boxes equals: {181 @ 36.
340 @ 305.
8 @ 310.
76 @ -59.
333 @ -76.
263 @ 43.
479 @ 117.
19 @ 215.
203 @ 362.
-67 @ 92.
80 @ 30.
228 @ 128.
443 @ 309.
293 @ 397.
18 @ 410.
105 @ 331.
-9 @ -7.
168 @ -96.
337 @ 21.
414 @ -12.
356 @ 85.
235 @ -53.
384 @ 150.
427 @ 205.
112 @ 250.
11 @ 112.
203 @ 463.
257 @ 279.
-113 @ 183.
-53 @ 195.
83 @ 133.
146 @ 107.
191 @ 221.
300 @ 198.
501 @ 229.
427 @ 411.
283 @ 495.
385 @ 365.
-61 @ 349.
83 @ 485.
131 @ 426}
]

{ #category : 'tests' }
RSForceBasedLayoutTest >> testAutoRepulse [
	self assert: RSForceBasedLayout new autoRepulse equals: false.
	RSForceBasedLayout new
		autoRepulse: true;
		on: boxes.
	self assertIntegerPosition: boxes equals: {0 @ -26.
36 @ 49.
-40 @ 35.
-23 @ -71.
49 @ -52.
17 @ -55.
61 @ 0.
-60 @ -37.
4 @ 21.
-68 @ 2.
-10 @ -37.
4 @ -11.
51 @ 45.
21 @ 54.
-42 @ 51.
-27 @ 26.
-38 @ -65.
-8 @ -73.
49 @ -36.
63 @ -46.
24 @ -41.
21 @ -70.
76 @ -5.
47 @ -3.
-71 @ -26.
-51 @ -24.
1 @ 36.
20 @ 18.
-71 @ 17.
-52 @ 4.
-25 @ -43.
-22 @ -25.
-8 @ -1.
20 @ -9.
65 @ 37.
50 @ 29.
8 @ 63.
25 @ 70.
-57 @ 49.
-32 @ 64.
-20 @ 40}
]

{ #category : 'tests' }
RSForceBasedLayoutTest >> testBasic [
	RSForceBasedLayout new
		doNotUseProgressBar;
		on: boxes.
	self assertIntegerPosition: boxes equals: {0 @ -44.
53 @ 27.
-56 @ 37.
-32 @ -87.
57 @ -41.
39 @ -76.
77 @ 5.
-69 @ -32.
4 @ 72.
-91 @ -11.
-19 @ -53.
5 @ -23.
32 @ 21.
70 @ 40.
-66 @ 55.
-36 @ 27.
-52 @ -78.
-10 @ -89.
78 @ -34.
68 @ -59.
30 @ -56.
23 @ -89.
59 @ -5.
97 @ -1.
-63 @ -11.
-49 @ -21.
-10 @ 87.
21 @ 85.
-98 @ 8.
-78 @ 6.
-40 @ -54.
-25 @ -31.
-4 @ -4.
25 @ -15.
26 @ 42.
11 @ 24.
56 @ 57.
76 @ 61.
-58 @ 76.
-45 @ 62.
-18 @ 38}
]

{ #category : 'tests' }
RSForceBasedLayoutTest >> testBasic02 [
	RSForceBasedLayout on: boxes.
	self assertIntegerPosition: boxes equals: {0 @ -44.
53 @ 27.
-56 @ 37.
-32 @ -87.
57 @ -41.
39 @ -76.
77 @ 5.
-69 @ -32.
4 @ 72.
-91 @ -11.
-19 @ -53.
5 @ -23.
32 @ 21.
70 @ 40.
-66 @ 55.
-36 @ 27.
-52 @ -78.
-10 @ -89.
78 @ -34.
68 @ -59.
30 @ -56.
23 @ -89.
59 @ -5.
97 @ -1.
-63 @ -11.
-49 @ -21.
-10 @ 87.
21 @ 85.
-98 @ 8.
-78 @ 6.
-40 @ -54.
-25 @ -31.
-4 @ -4.
25 @ -15.
26 @ 42.
11 @ 24.
56 @ 57.
76 @ 61.
-58 @ 76.
-45 @ 62.
-18 @ 38}
]
