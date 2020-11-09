Class {
	#name : #RSChannelExample,
	#superclass : #Object,
	#category : #'Roassal3-Mondrian-Examples'
}

{ #category : #examples }
RSChannelExample >> exampleBasic [
	<script: 'self new exampleBasic'>

| c box1 box2 label connection |
c := RSCanvas new.

box1 := RSBox new size: 50; color: Color gray translucent.
box2 := RSBox new size: 30; color: Color gray translucent.
box1 @ RSDraggable.
box2 @ RSDraggable.
c add: box1; add: box2.

box1 translateBy: 150 @ -40.

label := RSLabel new text: 'Move the mouse above me'.
c add: label.
RSLocation new 
	above;
	stick: label on: box1.

"-------"
"Connection here"

connection := RSChannel new.
connection input: { box1 } asGroup.
connection output: { box2 } asGroup.
connection build.
"connection effect: [ :evt |  ]"

"-------"

c open
]
