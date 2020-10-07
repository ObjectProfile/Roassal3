"Removing Roassal3 :V"

packagesRegExp := { '*Roassal3*' }.

packages := packagesRegExp flatCollect: [ :regExp |
	RPackageOrganizer default packages
		select: [ :p | regExp match: p packageName ] ].

packages := packages reject: [ :pck | pck name = 'Roassal3-Pharo7' ].
packages do: [ :package | package removeFromSystem ].
