"
I am the base for roassal visualizations. When a user wants to create a new visualization, he will need to create a new subclass of me.

A container builder(RSAbstractContainerBuilder), is an object that creates roassal shapes and keeps those shapes in a container (which could be either a RSCanvas or a RSComposite). The builder can modify the canvas and register new callbacks for events, as for interactions.

Methods
- #build, because a builder news to build
- #container:, to set the container where shapes will be added.
- #renderIn:, is abstract class and recives a container, usually a canvas.

Example

We can define an new calendar builder, that creates a calendar for a given year.

```Smalltalk
calendar := RSCalendar new.
calendar year: 2020.
calendar build.
calendar canvas.
```

Then RSCalendar should define 2 methods to run this example `year:` and `renderIn:`

```Smalltalk
RSAbstractContainerBuilder subclass: #RSCalendar
	instanceVariableNames: 'year'
	classVariableNames: ''
	package: 'MyPackage'
```

```Smalltalk
RSCalendar >> year: aNumber
	year := aNumber
```

```Smalltalk
RSCalendar >> renderIn: aCanvas
   ""TODO""
```

Then you can use this builder to create a canvas with several years

```Smalltalk
canvas := RSCanvas new.
calendar := RSCalendar new.
2016 to: 2020 do: [ :year | 
	composite := RSComposite new.
	calendar 
		year: year;
		renderIn: composite.
	composite adjustToChildren.
	canvas add: composite.
	 ].
RSHorizontalLineLayout on: canvas nodes.
""each node is a calendar for one year""
canvas 
```
"
Class {
	#name : #RSAbstractContainerBuilder,
	#superclass : #RSObject,
	#instVars : [
		'container',
		'shapes',
		'decorators'
	],
	#category : #'Roassal3-Builders'
}

{ #category : #building }
RSAbstractContainerBuilder >> build [
	self renderIn: self container
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
