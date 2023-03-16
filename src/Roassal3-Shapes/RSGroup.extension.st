Extension { #name : #RSGroup }

{ #category : #'*Roassal3-Shapes' }
RSGroup >> asShape [
	"Convert a RSGroup into a shape. Pretty convenient to create a group of shapes as a composite.
Consider the following example:

-=-=-=-=-=-=-=-=-=-=-=-=
c := RSCanvas new.

classes := Collection withAllSubclasses.
elements := classes collect: [ :cls |
	g := RSGroup new
		add: (RSLabel new text: cls name);
		add: (RSEllipse new size: (cls numberOfMethods + 5) sqrt; color: Color blue );
		yourself.
	RSVerticalLineLayout new center; on: g.
	g asShape ] as: RSGroup.

c addAll: elements.
elements @ RSHighlightable defaultRed.
RSGridLayout on: elements.
c @ RSCanvasController
-=-=-=-=-=-=-=-=-=-=-=-=

"
	^ self asShapeFor: nil
]

{ #category : #'*Roassal3-Shapes' }
RSGroup >> asShapeFor: model [
	"Convert a RSGroup into a shape, and tis shape has a model. Pretty convenient to create a group of shapes as a composite.
Consider the following example:

```
c := RSCanvas new.

classes := Collection withAllSubclasses.
elements := classes collect: [ :cls |
	g := RSGroup new
		add: (RSLabel new text: cls name);
		add: (RSEllipse new size: (cls numberOfMethods + 5) sqrt; color: Color blue );
		yourself.
	RSVerticalLineLayout new alignCenter; on: g.
	g asShapeFor: cls ] as: RSGroup.

c addAll: elements.
elements @ RSHighlightable red.
RSGridLayout on: elements.
c @ RSCanvasController
```
"
	^ RSComposite new
		model: model;
		shapes: self;
		yourself
]
