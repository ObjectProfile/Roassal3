"
Baseline for https://github.com/ObjectProfile/Roassal3
"
Class {
	#name : #BaselineOfRoassal3,
	#superclass : #BaselineOf,
	#category : #BaselineOfRoassal3
}

{ #category : #baselines }
BaselineOfRoassal3 >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [
			spec baseline: 'Bloc' with: [ 
				spec repository: 'github://pharo-graphics/Bloc/src' ].
			spec 
				package: #Roassal3.
			spec 
				group: 'Core' with: #('Roassal3');
				group: 'Tests' with: #('Core' 'Tests');
				group: 'default' with: #('Core') ]
]
