[list of classes](reference.md)
# RSGroup
A `RSGroup` represents a collection of Roassal shapes. As soon as one assume a collection contains graphical elements, then it is convenient to be able to perform some operations (e.g., getting the encompassing rectangle of the elements, transforming a collection into a composite shape). `RSGroup` is a subclass of `OrderedCollection`. A `RSGroup` is not designed to contain other things than Roassal shapes. 

*Responsibility*: handle a collection of graphical shapes in an intuitive and efficient way. A group is also responsible to retrieve shapes from a given model object.

*Collaborators*: `RSGroup` is a central class in Roassal. Shapes are held in instance of `RSGroup`.

*Variables*:
- `shapeFromModelCache`: a group of shapes must remember the model to speed up the retreival of shapes from a given object model.


*Example*:
```Smalltalk
shapes := (1 to: 20) collect: [ :value | 
	| g |
	g := RSGroup new.
	g add: (RSEllipse new size: 30 atRandom).
	g add: (RSLabel new text: value).
	g asShape ].

c := RSCanvas new.
c addAll: shapes.
RSFlowLayout on: shapes.
c @ RSCanvasController.
```

Layout may be applied on a group
```Smalltalk
shapes := (1 to: 20) collect: [ :value | 
	| g |
	g := RSGroup new.
	g add: (RSLabel new text: value).
	g add: (RSEllipse new size: 30 atRandom).
	RSVerticalLineLayout new center; gapSize: 0; on: g.
	g asShape ].

c := RSCanvas new.
c addAll: shapes.
RSFlowLayout on: shapes.
c @ RSCanvasController.
```

```Smalltalk
g := RSGroup new.
g add: (RSBox new model: 'hello').
g add: (RSEllipse new model: 'world').
g shapeFromModel: 'hello' "=> a RSBox(hello))"
```