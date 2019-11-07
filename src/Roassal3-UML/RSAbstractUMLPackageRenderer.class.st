"
Abstract renderer for UML packages
"
Class {
	#name : #RSAbstractUMLPackageRenderer,
	#superclass : #RSAbstractUMLRenderer,
	#instVars : [
		'packageNameShape',
		'packageShape',
		'packageBoxShape',
		'packageNameBoxShape'
	],
	#category : #'Roassal3-UML-Rendering'
}

{ #category : #testing }
RSAbstractUMLPackageRenderer class >> isAbstract [ 

	^self name = #RSAbstractUMLPackageRenderer
]

{ #category : #accessing }
RSAbstractUMLPackageRenderer >> packageBoxShape [

	^ packageBoxShape ifNil: [ packageBoxShape := RSShapeBuilder box
		noPaint;
		border: (RSBorder new width: 5; joinMiter; color: '666EA0') ]
]

{ #category : #accessing }
RSAbstractUMLPackageRenderer >> packageNameBoxShape [

	^ packageNameBoxShape ifNil: [ packageNameBoxShape := RSShapeBuilder box
		noPaint;
		border: (RSBorder new width: 5; joinMiter; color: '666EA0') ]
]

{ #category : #accessing }
RSAbstractUMLPackageRenderer >> packageNameShape [
	^ packageNameShape ifNil: [ packageNameShape := RSShapeBuilder label
		text: [ :m | modelDescriptor packagename rsValue: m ];
		onElement;
		fontSize: [ :e | e font pointSize * 1.2];
		onModel ]
]

{ #category : #accessing }
RSAbstractUMLPackageRenderer >> packageNameShape: anObject [
	packageNameShape := anObject
]

{ #category : #accessing }
RSAbstractUMLPackageRenderer >> packageShape [
	^ packageShape
]

{ #category : #accessing }
RSAbstractUMLPackageRenderer >> packageShape: anObject [
	packageShape := anObject
]
