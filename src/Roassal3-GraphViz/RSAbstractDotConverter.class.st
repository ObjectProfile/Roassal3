"
Abstract converter for different types of layouts in graphviz
"
Class {
	#name : #RSAbstractDotConverter,
	#superclass : #Object,
	#instVars : [
		'stream',
		'nodes',
		'dotMode'
	],
	#category : #'Roassal3-GraphViz-Core'
}

{ #category : #accessing }
RSAbstractDotConverter >> dotMode: aRSDotMode [
	dotMode := aRSDotMode
]

{ #category : #visiting }
RSAbstractDotConverter >> idFor: aShape [
	^ nodes at: aShape ifAbsentPut: [
		(nodes size+1) asString ]
]

{ #category : #accessing }
RSAbstractDotConverter >> stream [
	^ stream
]

{ #category : #visiting }
RSAbstractDotConverter >> visitBoundingShape: aShape [
	"http://www.graphviz.org/doc/info/attrs.html#d:height"
	| s |
	s := 0.01.
	stream
		<< (self idFor: aShape);
		<< ' [label="' ;
		<< aShape model asString;
		<< '", height=';
		<< (aShape height * s) asFloat asString;
		<< ']'
]

{ #category : #visiting }
RSAbstractDotConverter >> visitCanvas: aCanvas [
	aCanvas shapes accept: self
]

{ #category : #visiting }
RSAbstractDotConverter >> visitGroup: aRSGroup [

	stream := WriteStream on: String new.
	nodes := Dictionary new.

	self writeHeader: aRSGroup.

	aRSGroup do: [ :node | node accept: self ]
		separatedBy: [ stream << ';'; crlf ].
	stream << '}'.
	stream close
]

{ #category : #visiting }
RSAbstractDotConverter >> visitLabel: aShape [
	^ self visitBoundingShape: aShape
]

{ #category : #visiting }
RSAbstractDotConverter >> visitLine: aLine [
	stream
		<< '"';
		<< (self idFor: aLine from);
		<< '" '.
	self writeLineConnector: aLine.
	stream
		<< '"';
		<< (self idFor: aLine to);
		<< '"'
]

{ #category : #visiting }
RSAbstractDotConverter >> writeHeader: aRSGroup [
	self subclassResponsibility
]

{ #category : #visiting }
RSAbstractDotConverter >> writeLineConnector: aLine [
	self subclassResponsibility
]
