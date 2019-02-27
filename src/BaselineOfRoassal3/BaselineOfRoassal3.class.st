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
			spec package: 'Athens-SVG' with: [
				spec repository: 'http://www.smalltalkhub.com/mc/Pharo/Athens/main' ].
			
			spec
				package: 'Roassal3-Trachel' with: [spec requires: #('Athens-SVG')];
				package: 'Roassal3-Animation';
				package: #'Roassal3-Trachel-Shapes';
				package: #'Roassal3';
				
				package: #'Roassal3-Scales';
				package: #'Roassal3-Layouts';
				package: #'Roassal3-Trachel-Shapes';
				package: #'Roassal3-Examples';
				package: #'Roassal3-Tests'.
				
			spec 
				group: 'Core' with: #(
					'Roassal3'
					'Roassal3-Layouts'
					'Roassal3-Scales'
					'Roassal3-Animation'
					'Roassal3-Trachel'
					'Roassal3-Trachel-Shapes');
				group: 'Examples'  with: #('Core' 'Roassal3-Examples');
				group: 'Tests' with: #('Core' 'Roassal3-Tests');
				group: 'default' with: #('Core' 'Tests' 'Examples') ]
			
		
	







]
