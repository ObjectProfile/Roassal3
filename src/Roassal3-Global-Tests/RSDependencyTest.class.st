Class {
	#name : #RSDependencyTest,
	#superclass : #RSTest,
	#category : #'Roassal3-Global-Tests-Infrastructure'
}

{ #category : #tests }
RSDependencyTest >> assertPackage: p1Name dependOn: p2Name [

	| p1 p2 |
	p1 := self packageNamed: p1Name.
	p2 := self packageNamed: p2Name.
	self assert: (p1 dependentPackages includes: p2).
]

{ #category : #tests }
RSDependencyTest >> assertPackage: p1Name doesNotDependOn: p2Name [

	| p1 p2 |
	p1 := self packageNamed: p1Name.
	p2 := self packageNamed: p2Name.
	self deny: (p1 dependentPackages includes: p2).
]

{ #category : #testing }
RSDependencyTest >> hasPackage: aString [ 
	
	^ (self packageNamed: aString) notNil.
]

{ #category : #tests }
RSDependencyTest >> packageNamed: aSymbol [
	^ RPackageOrganizer default packageNamed: aSymbol 
		ifAbsent: [ nil ]
]

{ #category : #tests }
RSDependencyTest >> testDependencies [

	self assertPackage: 'Roassal3' doesNotDependOn: 'Roassal3-Layouts'.
	self assertPackage: 'Roassal3' doesNotDependOn: 'Roassal3-Animation'.
	self assertPackage: 'Roassal3' doesNotDependOn: 'Roassal3-Builders'.
	self assertPackage: 'Roassal3' doesNotDependOn: 'Roassal3-Chart'.
	self assertPackage: 'Roassal3' doesNotDependOn: 'Roassal3-Colors'.
	self assertPackage: 'Roassal3-Shapes' doesNotDependOn: 'Roassal3-Layouts'.
	self assertPackage: 'Roassal3-Animation' dependOn: 'Roassal3'.

	"Chart uses RSLocation from Layouts"
	self assertPackage: 'Roassal3-Chart' dependOn: 'Roassal3-Layouts'.
	"not a core package then we can not depent on this package"
	(self hasPackage: 'Roassal3-Spec-Examples') ifFalse: [ ^ self ].
	self assertPackage: 'Roassal3-Spec-Examples' dependOn: 'Roassal3-Menu'.
]
