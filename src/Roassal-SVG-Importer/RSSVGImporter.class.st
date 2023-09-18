"
TODO
"
Class {
	#name : #RSSVGImporter,
	#superclass : #RSObject,
	#category : #'Roassal3-SVG-Importer'
}

{ #category : #'instance creation' }
RSSVGImporter class >> fromFile: aFileName [
	^ (AthensSVGConverter fromFile: aFileName) asShape.
]

{ #category : #'instance creation' }
RSSVGImporter class >> fromString: aString [
	| doc |
	doc := XMLDOMParser parse: aString.
	^ (AthensSVGConverter new importXMLDocument: doc) asShape.
]

{ #category : #'instance creation' }
RSSVGImporter class >> fromURL: anUrl [
	^ (AthensSVGConverter fromURL: anUrl) asShape.
]
