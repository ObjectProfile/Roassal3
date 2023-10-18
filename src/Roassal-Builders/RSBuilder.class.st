"
I am the base for roassal visualizations. When a user wants to create a new visualization, he will need to create a new subclass of me.

A container builder(RSBuilder), is an object that creates roassal shapes and it keeps/adds those shapes in a container (which could be either a RSCanvas, a RSComposite or RSGroup). 

The builder can modify the canvas and register new callbacks for events, as for interactions.

First describe your model-object-domain, then the builder will generate the shapes with the method `RSBuilder >> #build`. Note that some methods like `RSBuilder >> #asPresenter` or `RSBuilder >> #open` first call the method `build`.

# Methods
- `RSBuilder >> #defaultContainer`: use this method to configure your canvas, like the event interactions you want the background color, etc.
- `RSBuilder >> #build`: because a builder news to build
- `RSBuilder >> #container`: to set the container where shapes will be added.
- `RSBuilder >> #renderIn:`: is abstract class and recives a container, usually a canvas.
- `RSBuilder >> #asPresenter`: first it calls `build` then it convert the builder into a `SpPresenter` like `SpRoassalInspectorPresenter`.
- `RSBuilder >> #asShape`: first it calls `build` then it convert the the generated shapes into a `RSComposite` shape.
- `RSBuilder >> #update`: will remove the elements in the container and will try to render `RSBuilder >>#renderIn:` again the shapes in the container

#Examples

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
	#name : 'RSBuilder',
	#superclass : 'RSObject',
	#instVars : [
		'container',
		'shapes'
	],
	#category : 'Roassal-Builders-Core',
	#package : 'Roassal-Builders',
	#tag : 'Core'
}

{ #category : 'accessing' }
RSBuilder >> asShape [
	^ self asShapeFor: nil
]

{ #category : 'accessing' }
RSBuilder >> asShapeFor: model [
	self build.
	^ self container asShape
		model: model;
		yourself
]

{ #category : 'building' }
RSBuilder >> build [
	| roassalContainer |
	roassalContainer := self container.
	self renderIn: roassalContainer.
	^ roassalContainer
]

{ #category : 'accessing' }
RSBuilder >> canvas [
	^ self container canvas
]

{ #category : 'accessing' }
RSBuilder >> container [
	^ container ifNil: [ container := self defaultContainer ]
]

{ #category : 'accessing' }
RSBuilder >> container: aTContainer [
	container := aTContainer
]

{ #category : 'accessing - defaults' }
RSBuilder >> defaultContainer [
	^ RSCanvas new
]

{ #category : 'public' }
RSBuilder >> open [
	self build.
	^ self canvas open
]

{ #category : 'rendering' }
RSBuilder >> renderIn: aCanvas [
	"add some shapes in the canvas"
	self subclassResponsibility
]

{ #category : 'accessing' }
RSBuilder >> shapes [
	^ shapes
]

{ #category : 'updating' }
RSBuilder >> update [
	self container shapes do: #remove.
	self build
]
