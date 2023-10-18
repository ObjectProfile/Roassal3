Extension { #name : 'RPackage' }

{ #category : '*Roassal-Examples' }
RPackage >> dependentPackagesWithOccurences [
	"
	Return the list of packages that I depend on. The result may includes several times the same packages. This reflects the number of dependencies.

	(RPackageOrganizer default packageNamed: 'Athens-Cairo') dependentPackagesWithOccurences
	"
	^ (self definedClasses flatCollect: #dependentClassesWithOccurences as: Bag) collect: #package
]

{ #category : '*Roassal-Examples' }
RPackage >> numberOfDependenciesToward: anotherPackage [
	"
	Return the number of dependencies between mysefl and the package provided as argument

	(RPackageOrganizer default packageNamed: 'Athens-Cairo') numberOfDependenciesToward: (RPackageOrganizer default packageNamed: 'Text-Core')
	"
	^ (self dependentPackagesWithOccurences select: [ :p | p == anotherPackage ]) size
]
