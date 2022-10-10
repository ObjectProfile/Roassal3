Extension { #name : #RSWorldMenu }

{ #category : #'*Roassal3-Examples' }
RSWorldMenu class >> browseExample [

	^ (RPackageOrganizer default packageNamed: 'Roassal3-Examples')
		  browse
]

{ #category : #'*Roassal3-Examples' }
RSWorldMenu class >> menu05ExamplesOn: aBuilder [

	<worldMenu>
	(aBuilder item: #Roassal3Examples)
		parent: #Roassal3;
		order: 5;
		label: 'Examples';
		help: 'Browse examples packages for Roassal3';
		icon: self roassalIcon;
		action: [ RSExamplesBrowser new open ]
]
