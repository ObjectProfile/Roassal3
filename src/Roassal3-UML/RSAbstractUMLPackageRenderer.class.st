"
Abstract renderer for UML packages
"
Class {
	#name : #RSAbstractUMLPackageRenderer,
	#superclass : #RSAbstractUMLRenderer,
	#instVars : [
		'classColor',
		'packageColor'
	],
	#category : #'Roassal3-UML-Rendering'
}

{ #category : #testing }
RSAbstractUMLPackageRenderer class >> isAbstract [

	^self name = #RSAbstractUMLPackageRenderer
]

{ #category : #hooks }
RSAbstractUMLPackageRenderer >> classBoxFor: aClass and: classNameShape [
	^ RSBox new
		cornerRadius: 5;
		color: self classColor;
		border: self border;
		extent: classNameShape extent + 10;
		position: classNameShape position
		yourself
]

{ #category : #accessing }
RSAbstractUMLPackageRenderer >> classColor [
	^ classColor ifNil: [ classColor := self defaultClassColor ]
]

{ #category : #accessing }
RSAbstractUMLPackageRenderer >> classColor: aColor [
	classColor := aColor
]

{ #category : #hooks }
RSAbstractUMLPackageRenderer >> classFor: aClass [
	| box className |
	className := self classNameFor: aClass.
	box := self classBoxFor: aClass and: className.
	^ RSComposite new
		model: aClass;
		shapes: { box. className };
		popup;
		browseable;
		yourself
]

{ #category : #hooks }
RSAbstractUMLPackageRenderer >> classNameFor: aClass [
	^ RSLabel new
		text: (modelDescriptor classname rsValue: aClass);
		yourself
]

{ #category : #hooks }
RSAbstractUMLPackageRenderer >> classesFor: aPackage [
	| classes shapes |
	classes := modelDescriptor classes rsValue: aPackage.
	shapes := classes collect: [ :cls | self classFor: cls ].
	RSFlowLayout on: shapes.
	^ RSComposite new
		shapes: shapes;
		yourself
]

{ #category : #defaults }
RSAbstractUMLPackageRenderer >> defaultClassColor [
	^ Color colorFrom: 'DEEBF7'
]

{ #category : #accessing }
RSAbstractUMLPackageRenderer >> defaultLayout [

	| defaultLayout |
	defaultLayout := RSLayoutBuilder new.
	defaultLayout vertical
		verticalGap: 100;
		horizontalGap: 50.
	^defaultLayout
]

{ #category : #defaults }
RSAbstractUMLPackageRenderer >> defaultPackageColor [
	^ Color colorFrom: '9ECAE1'
]

{ #category : #hooks }
RSAbstractUMLPackageRenderer >> packageBoxFor: title and: classes [
	| boxTitle boxClasses rect cradius |
	RSVerticalLineLayout new gapSize: 0; on: { title. classes }.
	title translateBy: 10@ -5.
	rect := classes encompassingRectangle.
	cradius := RSCornerRadius new
		radius: 5;
		yourself.
	boxTitle := RSBox new
		position: title position;
		extent: title extent + 10;
		cornerRadius: cradius;
		border: self border;
		color: self packageColor;
		yourself.
	boxClasses := RSBox new
		position: rect floatCenter;
		extent: rect extent+10;
		cornerRadius: cradius;
		border: self border;
		color: self packageColor;
		yourself.
	^ RSComposite new
		addAll: { boxTitle. boxClasses };
		yourself
]

{ #category : #accessing }
RSAbstractUMLPackageRenderer >> packageColor [
	^ packageColor ifNil: [ packageColor := self defaultPackageColor ]
]

{ #category : #accessing }
RSAbstractUMLPackageRenderer >> packageColor: aColor [
	packageColor := aColor
]

{ #category : #hooks }
RSAbstractUMLPackageRenderer >> packageNameFor: aPackage [
	| shape |
	shape := RSLabel new
		bold;
		text: (modelDescriptor packagename rsValue: aPackage);
		yourself.
	shape fontSize: shape fontSize * 1.2.
	^ shape
]
