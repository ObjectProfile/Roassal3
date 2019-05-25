Extension { #name : #RPackage }

{ #category : #'*Roassal3' }
RPackage >> dependentPackages [
	"
	Return the list of packages that I depend on
	
	(RPackageOrganizer default packageNamed: 'Roassal3') dependentPackages
	"
	^ (self definedClasses flatCollect: #dependentClasses) collect: #package as: Set
]

{ #category : #'*Roassal3' }
RPackage >> dependentPackagesWithOccurences [
	"
	Return the list of packages that I depend on. The result may includes several times the same packages. This reflects the number of dependencies.
	
	(RPackageOrganizer default packageNamed: 'Roassal3') dependentPackagesWithOccurences
	"
	^ (self definedClasses flatCollect: #dependentClassesWithOccurences as: OrderedCollection) collect: #package
]

{ #category : #'*Roassal3' }
RPackage >> numberOfDependenciesToward: anotherPackage [
	"
	Return the number of dependencies between mysefl and the package provided as argument
	
	(RPackageOrganizer default packageNamed: 'Trachel') numberOfDependenciesToward: (RPackageOrganizer default packageNamed: 'Roassal2')
	
	(RPackageOrganizer default packageNamed: 'Roassal2') numberOfDependenciesToward: (RPackageOrganizer default packageNamed: 'Trachel')
	"
	^ (self dependentPackagesWithOccurences select: [ :p | p == anotherPackage ]) size
]
