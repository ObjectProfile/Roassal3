"
I am used in subclasses of RSAbstractModelBuilder. 
RSAbstractModelBuilder can create objects of anything based on 2 components, element and target.
the element has the model, the real object. target can be another object.

Instances of RSAbstractModelBuilder usually creates this 2 components and then uses accessors to modify the object created. by the commands of RSAbstractModelBuilder. CAAction allows you to modify these objects before and after their creation.
"
Class {
	#name : #RSAction,
	#superclass : #RS3Object,
	#instVars : [
		'action',
		'isPreloadAction',
		'element'
	],
	#category : #'Roassal3-Scripting-Commands'
}

{ #category : #accessing }
RSAction >> action [
	^ action
]

{ #category : #accessing }
RSAction >> action: aBlock [
	action := aBlock
]

{ #category : #accessing }
RSAction >> element [
	^ element
]

{ #category : #accessing }
RSAction >> element: anElement [
	element := anElement
]

{ #category : #accessing }
RSAction >> execute [
	self action rsValue: self element
]

{ #category : #accessing }
RSAction >> initialize [
	super initialize.
	self postload.
]

{ #category : #accessing }
RSAction >> isPostload [
	^ isPreloadAction not
]

{ #category : #accessing }
RSAction >> isPreload [
	^ isPreloadAction
]

{ #category : #accessing }
RSAction >> postload [
	isPreloadAction := false
]

{ #category : #accessing }
RSAction >> preload [
	isPreloadAction := true
]

{ #category : #dependencies }
RSAction >> release [
	super release.
	action := element :=  nil.
]
