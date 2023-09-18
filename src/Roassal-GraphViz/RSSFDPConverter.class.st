"
TODO
"
Class {
	#name : #RSSFDPConverter,
	#superclass : #RSAbstractDotConverter,
	#category : #'Roassal3-GraphViz-Core'
}

{ #category : #writing }
RSSFDPConverter >> writeHeader: aRSGroup [
	stream
		<< 'graph G {'; crlf;
		<< 'ratio = auto ; '; crlf;
		<< 'layout = "sfdp" ;'; crlf
]

{ #category : #visiting }
RSSFDPConverter >> writeLineConnector: aLine [
	stream << '--'
]
