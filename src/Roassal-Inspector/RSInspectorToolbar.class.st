"
Use this class to add specific interactions with icons an buttons for your canvas in the inspector
"
Class {
	#name : 'RSInspectorToolbar',
	#superclass : 'RSObject',
	#instVars : [
		'canvas'
	],
	#category : 'Roassal-Inspector-Contexts',
	#package : 'Roassal-Inspector',
	#tag : 'Contexts'
}

{ #category : 'accessing' }
RSInspectorToolbar class >> interactions [
	^ self withAllSubclasses reject: [ :cls | cls isAbstract or:[ cls hasAbstractMethods ] ]
]

{ #category : 'accessing' }
RSInspectorToolbar >> canvas [
	^ canvas
]

{ #category : 'accessing' }
RSInspectorToolbar >> canvas: aRSCanvas [
	canvas := aRSCanvas
]

{ #category : 'hooks' }
RSInspectorToolbar >> newButton [
	^ self subclassResponsibility
]
