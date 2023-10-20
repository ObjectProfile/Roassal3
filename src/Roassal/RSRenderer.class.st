"
A renderer recives a canvas a then it visit each element of the canvas.

RSRenderer is like a visitor for the RSCanvas.

RSCanvas and RSShapes accept this visitor.

RSCanvas can be rendered with the next 

- RSAthensRenderer renders the canvas in a Athens Surface using an athens library

Future renderes: 
- RSPngRenderer, this can produce an image with different parameters 
- RSBlocRenderer, this render a canvas with the bloc/sparta commponents
- RSPDFRenderer, creates a pdf documents
- RSGifRenderer, creates gif files with animation
- RSSourceRenderer, creates a method with the content of the canvas.
- RSJavascriptRenderer, creates and html file with css and javascript code to render the canvas with basic insteractions.
- RSVideoRenderer, creates a mp4 video with the canvas animation and transparency.

"
Class {
	#name : 'RSRenderer',
	#superclass : 'RSObject',
	#instVars : [
		'athensCanvas'
	],
	#category : 'Roassal-Rendering',
	#package : 'Roassal',
	#tag : 'Rendering'
}

{ #category : 'examples' }
RSRenderer class >> example [
	"The only backend for now is Athens, but Sparta or Alexandrie are open"
	^ RSAthensMorph example
]

{ #category : 'accessing' }
RSRenderer >> canvas [
	^ athensCanvas
]

{ #category : 'accessing' }
RSRenderer >> canvas: aCanvas [
	"aCanvas is AthensCanvas"
	athensCanvas := aCanvas
]

{ #category : 'visiting' }
RSRenderer >> visitBorder: border [
]

{ #category : 'visiting' }
RSRenderer >> visitBoundingShape: shape [
]

{ #category : 'visiting' }
RSRenderer >> visitCamera: camera [
]

{ #category : 'visiting' }
RSRenderer >> visitCanvas: canvas [
]

{ #category : 'visiting' }
RSRenderer >> visitGroup: aGroup [
]

{ #category : 'visiting' }
RSRenderer >> visitLabel: label [
]

{ #category : 'visiting' }
RSRenderer >> visitLine: line [
]
