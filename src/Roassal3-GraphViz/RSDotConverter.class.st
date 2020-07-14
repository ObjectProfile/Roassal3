"
TODO
"
Class {
	#name : #RSDotConverter,
	#superclass : #Object,
	#instVars : [
		'stream'
	],
	#category : #'Roassal3-GraphViz'
}

{ #category : #visiting }
RSDotConverter >> initialize [
	super initialize.
	stream := WriteStream on: String new.
]

{ #category : #accessing }
RSDotConverter >> stream [
	^ stream
]

{ #category : #visiting }
RSDotConverter >> visitBoundingShape: aShape [
	stream << aShape model
]

{ #category : #visiting }
RSDotConverter >> visitCanvas: aCanvas [
	stream << 'digraph g '.
	
	stream << '{'.
	aCanvas shapes do: [ :node | node accept: self ]
		separatedBy: [ stream crlf ]. 
	stream << '}'.
	stream close.
]

{ #category : #visiting }
RSDotConverter >> visitLine: aLine [
	stream 
		<< aLine from model;
		<< ' -> ';
		<< aLine to model.
]
