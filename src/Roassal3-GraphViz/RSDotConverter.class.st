"
TODO
"
Class {
	#name : #RSDotConverter,
	#superclass : #Object,
	#instVars : [
		'stream',
		'nodes'
	],
	#category : #'Roassal3-GraphViz'
}

{ #category : #visiting }
RSDotConverter >> idFor: aShape [
	^ nodes at: aShape ifAbsentPut: [ 
		(nodes size+1) asString ].
]

{ #category : #visiting }
RSDotConverter >> initialize [
	super initialize.
	stream := WriteStream on: String new.
	nodes := Dictionary new.
]

{ #category : #accessing }
RSDotConverter >> stream [
	^ stream
]

{ #category : #visiting }
RSDotConverter >> visitBoundingShape: aShape [
	stream << (self idFor: aShape); << ' [label="' ; << aShape model asString; << '"]'.
	
]

{ #category : #visiting }
RSDotConverter >> visitCanvas: aCanvas [
	aCanvas shapes accept: self
]

{ #category : #visiting }
RSDotConverter >> visitGroup: aRSGroup [
	stream << 'strict graph '.
	
	stream << '{'.
	aRSGroup do: [ :node | node accept: self ]
		separatedBy: [ stream crlf ]. 
	stream << '}'.
	stream close.
	
]

{ #category : #visiting }
RSDotConverter >> visitLine: aLine [
	stream 
		<< '"';
		<< (self idFor: aLine from);
		<< '" -- "';
		<< (self idFor: aLine to);
		<< '"'.
]
