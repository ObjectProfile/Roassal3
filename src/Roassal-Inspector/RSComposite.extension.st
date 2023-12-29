Extension { #name : 'RSComposite' }

{ #category : '*Roassal-Inspector' }
RSComposite >> inspectorShapes [
	<inspectorPresentationOrder: 100 title: 'Children'>
	^ SpTablePresenter new
		items: self children;
		addColumn: (SpStringTableColumn
			title: 'Shape'
			evaluated: [ :each | each asString ] );
		addColumn: (SpStringTableColumn
			title: 'Model'
			evaluated: [ :each | each model asString ] );
		addColumn: (SpStringTableColumn
			title: 'Paint'
			evaluated: [ :each | each paint asString ] );
		addColumn: (SpStringTableColumn
			title: 'Border'
			evaluated: [ :each | each border asString ] )
]
