"
I have the roassal shapes to build the visualizacion
"
Class {
	#name : #RSUMLClassRenderer,
	#superclass : #RSObject,
	#instVars : [
		'marker',
		'edgeBuilder',
		'classBoxShape',
		'border',
		'classInnerLine',
		'classNameShape',
		'classDescriptor',
		'methodsShape',
		'methodShape',
		'varsShape',
		'varShape'
	],
	#category : #'Roassal3-UML'
}

{ #category : #'accessing - shapes' }
RSUMLClassRenderer >> classBoxShape [
	^ classBoxShape ifNil: [ classBoxShape := RSShapeBuilder box
		paint: (Color colorFrom: 'cfd9df');
		cornerRadius: 10;
		border: self defaultBorder ]
]

{ #category : #'accessing - shapes' }
RSUMLClassRenderer >> classBoxShape: aShape [ 
	classBoxShape := aShape
]

{ #category : #accessing }
RSUMLClassRenderer >> classDescriptor [
	^ classDescriptor 
]

{ #category : #accessing }
RSUMLClassRenderer >> classDescriptor: aClassDescriptor [
	classDescriptor := aClassDescriptor
]

{ #category : #'accessing - shapes' }
RSUMLClassRenderer >> classInnerLine [
	^ classInnerLine ifNil: [ classInnerLine := RSSingleEdgeBuilder line 
		border: self defaultBorder ].
]

{ #category : #'accessing - shapes' }
RSUMLClassRenderer >> classInnerLine: aShape [
	classInnerLine := aShape
]

{ #category : #'accessing - shapes' }
RSUMLClassRenderer >> classNameShape [
	^ classNameShape ifNil: [ classNameShape := RSShapeBuilder label 
		fontSize: 20;
		text: [ :m | classDescriptor classname rsValue: m ] ]
]

{ #category : #'accessing - shapes' }
RSUMLClassRenderer >> classNameShape: aShape [
	classNameShape := aShape
]

{ #category : #'accessing - shapes' }
RSUMLClassRenderer >> defaultBorder [
	^ border ifNil: [ border := TSBorder new ].
]

{ #category : #'accessing - shapes' }
RSUMLClassRenderer >> edgeBuilder [
	^ edgeBuilder ifNil: [ edgeBuilder := RSEdgeBuilder orthoVertical
		attachPoint: RSVerticalAttachPoint new; 
		border: self defaultBorder;
		markerStart: self marker ]
]

{ #category : #'accessing - shapes' }
RSUMLClassRenderer >> edgeBuilder: anEdgeBuilder [
	edgeBuilder := anEdgeBuilder
]

{ #category : #'accessing - shapes' }
RSUMLClassRenderer >> marker [ 
	^ marker ifNil: [ marker := TSMarker new 
		offset: 25 / 2;
		shape: (RSShapeBuilder triangle
			color: Color white;
			border: self defaultBorder;
			extent: 20@25) element. ]
]

{ #category : #'accessing - shapes' }
RSUMLClassRenderer >> marker: aMarker [
	marker := aMarker.
]

{ #category : #'accessing - shapes' }
RSUMLClassRenderer >> methodShape [ 
	^ methodShape ifNil: [ methodShape := RSShapeBuilder label 
		fontSize: 12;
		text: [:m | classDescriptor methodSelector rsValue: m ] ]
]

{ #category : #'accessing - shapes' }
RSUMLClassRenderer >> methodShape: aShape [
	methodShape := aShape
]

{ #category : #'accessing - shapes' }
RSUMLClassRenderer >> methodsShape [ 
	^ methodsShape ifNil: [ methodsShape := RSShapeBuilder composite shapes: [ :m | | g |
		g := self methodShape elementsOn: (classDescriptor methods rsValue: m).
		RSVerticalLineLayout new gapSize: 0; on: g.
		g ] ]
]

{ #category : #'accessing - shapes' }
RSUMLClassRenderer >> methodsShape: aShape [
	methodsShape := aShape
]

{ #category : #'accessing - shapes' }
RSUMLClassRenderer >> varShape [
	^ varShape ifNil: [ varShape := RSShapeBuilder label fontSize: 12 ].
]

{ #category : #'accessing - shapes' }
RSUMLClassRenderer >> varShape: aShape [
	varShape := aShape
]

{ #category : #'accessing - shapes' }
RSUMLClassRenderer >> varsShape [
	^ varsShape ifNil: [ varsShape := RSShapeBuilder composite shapes: [ :m | | g |
		g := self varShape elementsOn: (classDescriptor instVars rsValue: m).
		RSVerticalLineLayout new gapSize: 0; on: g.
		g ] ].
]

{ #category : #'accessing - shapes' }
RSUMLClassRenderer >> varsShape: aShape [
	varsShape := aShape
]
