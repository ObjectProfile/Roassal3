Class {
	#name : #RSChannelTest,
	#superclass : #RSTest,
	#category : #'Roassal3-Mondrian-Tests'
}

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
