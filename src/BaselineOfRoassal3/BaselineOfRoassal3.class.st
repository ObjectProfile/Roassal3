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
				package: #Roassal3;
				package: 'Roassal3-Trachel';
				package: #'Roassal3-Tests';
				package: #'Roassal3-Examples';
				package: #'Roassal3-Animation'.
			spec 
				group: 'Core' with: #(
					'Roassal3'
					'Roassal3-Trachel'
					'Roassal3-Animation');
				group: 'Examples'  with: #('Roassal3-Examples');
				group: 'Tests' with: #('Roassal3-Tests');
				group: 'default' with: #('Core' 'Tests' 'Examples') ]
			
		
]
