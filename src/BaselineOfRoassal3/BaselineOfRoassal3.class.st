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
		do: [ | dep |
			spec package: 'Athens-SVG' with: [
				spec repository: 'http://www.smalltalkhub.com/mc/Pharo/Athens/main' ].
			spec package: 'Geometry' with: [ 
				spec repository: 'github://TelescopeSt/Geometry:v1.1.0/src' ].
			dep := (AthensCairoCanvas canUnderstand: #fillRuleEvenOdd)
				ifTrue: [ #('Athens-SVG') ]
				ifFalse: [ #('Athens-SVG' 'Roassal3-Pharo7') ].
			spec
				package: #'Roassal3-Pharo7';
				package: #'Roassal3-Trachel' with: [spec requires: dep];
				package: #'Roassal3-Scales';
				package: 'Roassal3-Animation';
				package: #'Roassal3-Trachel-Shapes';
				package: #'Roassal3' with: [spec requires: #('Geometry')];
				package: #'Roassal3-Interaction';
				package: #'Roassal3-Utils';
				package: #'Roassal3-Legend';
				package: #'Roassal3-Spec';
				package: #'Roassal3-UML';
				package: #'Roassal3-Layouts';
				package: #'Roassal3-Trachel-Shapes';
				package: #'Roassal3-Colors';
				package: #'Roassal3-Examples';
				package: #'Roassal3-Tests';
				package: #'Roassal3-Menu'.
				
			spec 
				group: 'Core' with: #(
					'Roassal3'
					'Roassal3-Interaction'
					'Roassal3-Layouts'
					'Roassal3-Utils'
					'Roassal3-Colors'
					'Roassal3-Legend'
					'Roassal3-Scales'
					'Roassal3-Animation'
					'Roassal3-Trachel'
					'Roassal3-Trachel-Shapes'
					'Roassal3-Spec'
					'Roassal3-UML'
					'Roassal3-Menu');
				group: 'Examples'  with: #('Core' 'Roassal3-Examples');
				group: 'Tests' with: #('Core' 'Roassal3-Tests');
				group: 'default' with: #('Core' 'Tests' 'Examples') ]
			
		
	







]
