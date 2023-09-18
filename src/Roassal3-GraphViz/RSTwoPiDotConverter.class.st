"
format
```
digraph G {
ranksep=3;
ratio=auto;
layout=twoPi;
Hello->World
}
```
"
Class {
	#name : #RSTwoPiDotConverter,
	#superclass : #RSAbstractDotConverter,
	#category : #'Roassal3-GraphViz-Core'
}

{ #category : #visiting }
RSTwoPiDotConverter >> writeHeader: aRSGroup [
	stream
		<< 'digraph Roassal3{ '; crlf;
		<< 'ranksep=3;'; crlf;
		<< 'ratio=auto;'; crlf;
		<< 'layout=twopi;'; crlf
]

{ #category : #visiting }
RSTwoPiDotConverter >> writeLineConnector: aLine [
	stream << '->'
]
