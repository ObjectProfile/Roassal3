"
I can add a popup on an element when a move over event occurs.

Here is an example:
```
c := RSCanvas new.

classes := RSObject withAllSubclasses.

scale := NSScale linear
domain: { (classes collect: #numberOfMethods) min . (classes collect: #numberOfMethods) max};
range: { 'red'. 'blue' }.

classes do: [ :cls |
| b |
b := RSEllipse new.
b size: cls numberOfMethods.
b color: (scale scale: cls numberOfMethods).
b model: cls.
b @ RSPopup.
c add: b ].

RSFlowLayout on: c shapes.

c @ RSCanvasController
```

Per default, `RSPopup` gives a label as a popup. However, it may be easily customized by using `shapeBuilder:`, which takes a one-argument-block and must return a shape or a composite shape. Consider: 

```
canvas := RSCanvas new.

shapes := RSLabel models: (1 to: 10).
canvas addAll: shapes.
RSGridLayout on: shapes.

popup := RSPopup new.
popup shapeBuilder: [ :aNumber |
	| g |
	g := RSGroup new.
	g addAll: (RSCircle models: (1 to: aNumber)).
	RSGridLayout on: g.
	g asShape 
		color: Color white darker darker;
		padding: 5.
].
shapes @ popup.

canvas zoomToFit.
```

Anoter example, more complex:

```
packages := RPackageOrganizer default packages select: [ :rPak | rPak packageName beginsWith: 'Roassal3' ].

canvas := RSCanvas new.
shapes := RSBox models: packages.
canvas addAll: shapes.

shapes @ RSDraggable.

RSNormalizer size
	shapes: shapes;
	from: 5; to: 20;
	normalize: [ :rPackage | rPackage definedClasses size ].

lb := RSLineBuilder line.
lb shape color: Color gray translucent.
lb moveBehind.
lb shapes: shapes.
lb connectToAll: #dependentPackages.

popup := RSPopup new.
popup shapeBuilder: [ :package |
	| g nodes lbl |
	g := RSGroup new.
	nodes := RSBox models: package definedClasses.
	nodes color: Color blue.
	g addAll: nodes.
	tlb := RSLineBuilder orthoVertical.
	tlb canvas: g.
	tlb shapes: nodes.
	tlb connectFrom: #superclass.
	RSTreeLayout on: nodes.
	lbl := RSLabel text: package packageName.
	g add: lbl.
	RSLocation move: lbl above: nodes.
	g asShape 
		color: Color white darker translucent; 
		borderColor: #black;
		padding: 3.
].
shapes @ popup.

shapes @ RSHighlightable red withOutgoingLines.
shapes @ RSHighlightable green incomingLines.

RSForceBasedLayout new charge: -800; on: shapes.
canvas @ RSCanvasController.
```
"
Class {
	#name : #RSPopup,
	#superclass : #RSAbstractPopupInteraction,
	#instVars : [
		'shapeBuilder'
	],
	#category : #'Roassal3-Interaction-Popup'
}

{ #category : #accessing }
RSPopup class >> text: aStringOrOneArgBlock [
	"Define a Popup interaction with a particular text. The argument can either be a text, a symbol, or a one-argument block that is evaluated on the model object of the shape. For example:
```
canvas := RSCanvas new.

someColors := { Color red . Color blue . Color green }.
shapes := RSGroup new.
someColors do: [ :aColor |
	shapes add: (RSEllipse new size: 30; model: aColor; color: aColor) ].

canvas addAll: shapes.

shapes @ RSDraggable.
shapes @ RSLabeled highlightable.
shapes @ (RSPopup text: [ :aColor | 'My color is ', aColor asString]).

RSHorizontalLineLayout on: shapes.

canvas @ RSCanvasController.
canvas open.
```
	"
	| inst |
	inst := self new.
	inst shapeBuilder textBlock: aStringOrOneArgBlock.
	^ inst
]

{ #category : #accessing }
RSPopup class >> theme [
	^ self themeText: #yourself
]

{ #category : #accessing }
RSPopup class >> themeText: aBlock [
	"you can create your own custom popups by adding extention methods for this class"
	| popup theme |
	popup := self text: aBlock.
	theme := Smalltalk ui theme.
	popup shapeBuilder labelBuilder labelShape color: theme textColor.
	popup shapeBuilder boxBuilder
		border: (RSBorder new color: theme textColor);
		cornerRadius: 0;
		color: (theme backgroundColor alpha: 0.8);
		padding: 20.
	^ popup
]

{ #category : #hooks }
RSPopup >> createPopupFor: aShape event: event [
	| popupShape |
	popupShape := shapeBuilder shapeFor: (self modelFor: aShape).
	popupShape isFixed: true.
	event canvas addShape: popupShape.
	^ popupShape
]

{ #category : #initialization }
RSPopup >> initialize [
	super initialize.
	shapeBuilder := RSSimplePopupBuilder new
]

{ #category : #hooks }
RSPopup >> releasePopup: popup [
	popup remove
]

{ #category : #accessing }
RSPopup >> shapeBuilder [
	^ shapeBuilder
]

{ #category : #accessing }
RSPopup >> shapeBuilder: aShapeBuilder [
	"Let one customize the way the popup is generated. The method accept a shape builder or a one-argument-block. For example:

```
canvas := RSCanvas new.

shapes := RSLabel models: (1 to: 10).
canvas addAll: shapes.
RSGridLayout on: shapes.

popup := RSPopup new.
popup shapeBuilder: [ :aNumber |
	| g |
	g := RSGroup new.
	g addAll: (RSCircle models: (1 to: aNumber)).
	RSGridLayout on: g.
	g asShape
		color: Color white darker darker;
		padding: 5.
].
shapes @ popup.

canvas zoomToFit.
canvas open
```"
	shapeBuilder := aShapeBuilder
]

{ #category : #accessing }
RSPopup >> text: oneArgBlock [
	"The block is evaluated with the model provided as argument"
	self shapeBuilder textBlock: oneArgBlock
]

{ #category : #hooks }
RSPopup >> translatePopup: popup event: evt [
	| p e extent |
	p := evt camera fromSpaceToPixel: evt position.
	extent := popup canvas extent.
	e := (popup extent /2) + 5.
	p x + popup width > extent x ifTrue: [
		e := e x negated @ e y.
		p x - popup width < 0
		ifTrue: [ e := p x negated + (popup width/2 + 4) @ e y ].
		].
	p y + popup height > extent y ifTrue: [
		e := e x @ e y negated.
		p y - popup height < 0
		ifTrue: [ e := e x @ ( p y negated + (popup height/2 + 4) ) ]
		].
	popup translateTo: p + e
]
