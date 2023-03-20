Extension { #name : #RPackage }

{ #category : #'*Roassal3' }
RPackage >> dependentPackages [
	"
	Return the list of packages that I depend on

	(RPackageOrganizer default packageNamed: 'Roassal3') dependentPackages
	"
	^ (self definedClasses flatCollect: #dependentClasses), self extendedClasses collect: #package as: Set
]
