Class {
	#name : 'RSDependencyTest',
	#superclass : 'RSTest',
	#category : 'Roassal-Global-Tests-Infrastructure',
	#package : 'Roassal-Global-Tests',
	#tag : 'Infrastructure'
}

{ #category : 'private - asserting' }
RSDependencyTest >> assertPackage: p1Name dependOn: p2Name [

	| p1 p2 |
	p1 := self packageNamed: p1Name.
	p2 := self packageNamed: p2Name.
	self assert: (p1 dependentPackages includes: p2)
]

{ #category : 'private - asserting' }
RSDependencyTest >> assertPackage: p1Name doesNotDependOn: p2Name [

	| p1 p2 |
	p1 := self packageNamed: p1Name.
	p2 := self packageNamed: p2Name.
	self deny: (p1 dependentPackages includes: p2)
]

{ #category : 'testing' }
RSDependencyTest >> hasPackage: aString [

	^ (self packageNamed: aString) notNil
]

{ #category : 'private - accessing' }
RSDependencyTest >> packageNamed: aSymbol [
	^ RPackageOrganizer default packageNamed: aSymbol
		ifAbsent: [ nil ]
]

{ #category : 'tests' }
RSDependencyTest >> testDependencies [

	self assertPackage: 'Roassal' doesNotDependOn: 'Roassal-Layouts'.
	self assertPackage: 'Roassal' doesNotDependOn: 'Roassal-Inspector'.
	self assertPackage: 'Roassal' doesNotDependOn: 'Roassal-Animation'.
	self assertPackage: 'Roassal' doesNotDependOn: 'Roassal-Builders'.
	self assertPackage: 'Roassal' doesNotDependOn: 'Roassal-Chart'.
	self assertPackage: 'Roassal' doesNotDependOn: 'Roassal-Colors'.
	self assertPackage: 'Roassal-Animation' dependOn: 'Roassal'.

	"Chart uses RSLocation from Layouts"

	self assertPackage: 'Roassal' dependOn: 'Announcements-Core'
]
