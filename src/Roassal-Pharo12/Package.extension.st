Extension { #name : 'Package' }

{ #category : '*Roassal-Pharo12' }
Package >> dependentPackages [
	"
	Return the list of packages that I depend on

	(PackageOrganizer default packageNamed: 'Roassal') dependentPackages
	"
	^ (self definedClasses flatCollect: #dependentClasses), self extendedClasses collect: #package as: Set
]

{ #category : '*Roassal-Pharo12' }
Package >> dependentPackagesWithOccurences [
	"
	Return the list of packages that I depend on. The result may includes several times the same packages. This reflects the number of dependencies.

	(PackageOrganizer default packageNamed: 'Athens-Cairo') dependentPackagesWithOccurences
	"
	^ (self definedClasses flatCollect: #dependentClassesWithOccurences as: Bag) collect: #package
]

{ #category : '*Roassal-Pharo12' }
Package >> numberOfDependenciesToward: anotherPackage [
	"
	Return the number of dependencies between mysefl and the package provided as argument

	(PackageOrganizer default packageNamed: 'Athens-Cairo') numberOfDependenciesToward: (PackageOrganizer default packageNamed: 'Text-Core')
	"
	^ (self dependentPackagesWithOccurences select: [ :p | p == anotherPackage ]) size
]
