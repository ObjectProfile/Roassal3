Extension { #name : 'Package' }

{ #category : '*Roassal' }
Package >> dependentPackages [
	"
	Return the list of packages that I depend on

	(PackageOrganizer default packageNamed: 'Roassal') dependentPackages
	"
	^ (self definedClasses flatCollect: #dependentClasses), self extendedClasses collect: #package as: Set
]
