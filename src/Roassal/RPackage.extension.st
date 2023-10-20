Extension { #name : 'RPackage' }

{ #category : '*Roassal' }
RPackage >> dependentPackages [
	"
	Return the list of packages that I depend on

	(RPackageOrganizer default packageNamed: 'Roassal') dependentPackages
	"
	^ (self definedClasses flatCollect: #dependentClasses), self extendedClasses collect: #package as: Set
]
