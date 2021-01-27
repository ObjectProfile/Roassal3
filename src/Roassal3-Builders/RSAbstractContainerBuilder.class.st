"
I am the base for roassal visualizations. When a user wants to create a new visualization, he will need to create a new subclass of me.

A container builder(RSAbstractContainerBuilder), is an object that creates roassal shapes and keeps those shapes in a container (which could be either a RSCanvas or a RSComposite). The builder can modify the canvas and register new callbacks for events, as for interactions.

Methods
- #build, because a builder news to build
- #container:, to set the container where shapes will be added.
- #renderIn:, is abstract class and recives a container, usually a canvas.

Example:

We can define an new calendar builder, that creates a calendar for a given year.

```Smalltalk
card := RSPunchCardBuilder new.
card objects: String withAllSubclasses.
card addMetric: [:cls | cls numberOfMethods] name: 'NOM'.
card build.
```

Then RSPunchCardBuilder should define 2 methods to run this example `objects:` and `renderIn:`. Check 
RSPunchCardBuilder for more details.

Then you can use this builder to create a canvas with several punch cards

```Smalltalk
canvas := RSCanvas new.
card := RSPunchCardBuilder new.
card addMetric: [:cls | cls numberOfMethods] name: 'NOM'.
card addMetric: [:cls | cls linesOfCode ] name: 'NLC'.
card addMetric: [:cls | cls numberOfVariables] name: 'NOV'.
{ String. Array. StringMorph } do: [ :class | 
	composite := RSComposite new.
	card 
		objects: class withAllSubclasses;
		renderIn: composite.
	composite adjustToChildren.
	canvas add: composite.
	 ].
RSVerticalLineLayout on: canvas nodes.
""each node is a calendar for one year""
canvas @ RSCanvasController
```
"
Class {
	#name : #RSAbstractContainerBuilder,
	#superclass : #RSObject,
	#instVars : [
		'container',
		'shapes'
	],
	#category : #'Roassal3-Builders-Core'
}

{ #category : #building }
RSAbstractContainerBuilder >> build [
	self renderIn: self container.
	^ self container
]

{ #category : #accessing }
RSAbstractContainerBuilder >> canvas [
	^ self container canvas
]

{ #category : #accessing }
RSAbstractContainerBuilder >> container [
	^ container ifNil: [ container := self defaultContainer ].
]

{ #category : #accessing }
RSAbstractContainerBuilder >> container: aTContainer [
	container := aTContainer
]

{ #category : #defaults }
RSAbstractContainerBuilder >> defaultContainer [
	^ RSCanvas new
]

{ #category : #hooks }
RSAbstractContainerBuilder >> renderIn: aCanvas [
	self subclassResponsibility
]

{ #category : #accessing }
RSAbstractContainerBuilder >> shapes [
	^ shapes
]
