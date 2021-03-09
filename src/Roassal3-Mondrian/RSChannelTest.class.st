Class {
	#name : #RSChannelTest,
	#superclass : #RSTest,
	#category : #'Roassal3-Mondrian-Tests'
}

{ #category : #tests }
RSChannelTest >> testAnnouncement [

	| c start end channel |
	c := RSCanvas new.
	start := RSLabel text: 'Start'.
	end := RSLabel text: 'End'.
	c add: start; add: end.
	
	self assert: start announcer numberOfSubscriptions equals: 0.

	channel := RSChannel new.
	channel input: { start }.
	channel output: { end }.
	channel build.
	
	self assert: start announcer numberOfSubscriptions equals: 5.
]

{ #category : #tests }
RSChannelTest >> testBasic [

	| c m mondrianNodes oddLabel evenLabel bigLabel smallLabel g channel |
	c := RSCanvas new.

	m := RSMondrian new.
	m canvas: c.
	m nodes: (1 to: 30).
	m layout flow gapSize: 2.
	m build.

	mondrianNodes := c nodes copy.

	oddLabel := RSLabel text: 'Odd'.
	evenLabel := RSLabel text: 'Label'.
	bigLabel := RSLabel text: 'Big'.
	smallLabel := RSLabel text: 'Small'.

	g := { oddLabel . evenLabel . bigLabel . smallLabel } asGroup.
	c addAll: g.

	RSHorizontalLineLayout on: g.
	RSVerticalLineLayout new alignCenter; on: { g .  mondrianNodes }.

	"-------" 
	channel := RSChannel new.
	channel input: { oddLabel }.
	channel output: (mondrianNodes select: [ :e | e model odd ]).
	channel build.
	"-------"
	channel := RSChannel new.
	channel input: { evenLabel }.
	channel output: (mondrianNodes select: [ :e | e model even ]).
	channel build.
	"-------"
	channel := RSChannel new.
	channel input: { bigLabel }.
	channel output: (mondrianNodes select: [ :e | e model > 15 ]).
	channel build.
	"-------"
	channel := RSChannel new.
	channel input: { smallLabel }.
	channel output: (mondrianNodes select: [ :e | e model <= 15 ]).
	channel build.
	"-------"

	self assert: mondrianNodes first color equals: Color gray.
	mondrianNodes first announce: RSMouseEnter.
	self assert: mondrianNodes first color equals: Color gray.
	
	oddLabel announce: RSMouseEnter.
	self assert: mondrianNodes first color equals: Color blue.
	oddLabel announce: RSMouseLeave.
	self assert: mondrianNodes first color equals: Color gray.

	oddLabel announce: RSMouseClick.
]

{ #category : #tests }
RSChannelTest >> testLocationsOfUnderlines [

	| c lbl1 lbl2 box channel1 channel2 markBlue markRed |
	c := RSCanvas new.
	lbl1 := RSLabel text: 'Press1'.
	lbl2 := RSLabel text: 'Press2'.
	c
		add: lbl1;
		add: lbl2.

	box := RSBox new size: 10.
	c add: box.
	RSGridLayout on: c nodes.
	c @ RSCanvasController.

	channel1 := RSChannel new.
	channel1 color: Color blue.
	channel1 input: { lbl1 }.
	channel1 output: { box }.
	channel1 build.

	channel2 := RSChannel new.
	channel2 color: Color red.
	channel2 input: { lbl2 }.
	channel2 output: { box }.
	channel2 build.

	self assert: c numberOfShapes equals: 3.

	self assert: (channel1 getAllMarksFrom: box) isEmpty.
	self assert: box properties size equals: 0.

	lbl1 announce: RSMouseClick.
	self assert: c numberOfShapes equals: 5.

	self assert: (channel1 getAllMarksFrom: box) size equals: 1.
	self assert: box properties size equals: 1.
	self assert: (box properties keys anyOne beginsWith: #mark).
	markBlue := box properties values anyOne.
	self assert: markBlue color equals: Color blue.
	self assert: (channel1 getAllMarksFrom: box) anyOne equals: markBlue.

	lbl2 announce: RSMouseClick.
	self assert: c numberOfShapes equals: 7.
	self assert: box properties size equals: 2.
	markRed := (box properties values copyWithout: markBlue) anyOne.
	self assert: markRed color equals: Color red.

	self assert: ((channel1 getAllMarksFrom: box) includesAll: { 
				 markBlue.
				 markRed }).

	"Since the red was clicked after, the red mark must be below the blue mark"
	self assert: markRed position ~= markBlue position.
	self assert: markRed position y > markBlue position x
]
