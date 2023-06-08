"
format
```
digraph G {Hello->World}
```
"
Class {
	#name : #RSDigraphDotConverter,
	#superclass : #RSAbstractDotConverter,
	#category : #'Roassal3-GraphViz-Core'
}

{ #category : #visiting }
RSDigraphDotConverter >> writeHeader: aRSGroup [
	stream
		<< 'digraph G {'; crlf;
		<< 'ratio = auto ; '; crlf;
		<< 'mincross = 2.0 ; '; crlf
]

{ #category : #visiting }
RSDigraphDotConverter >> writeLineConnector: aLine [
	stream << '->'
]
