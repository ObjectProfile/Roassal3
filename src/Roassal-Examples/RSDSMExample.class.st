"
RTDSMExample new installTitle: 'EvolutionDSM' 
		code:
'
	| b option data labels input other |
	option := #(collab gtinspector).
	option := TRPlatform current dialogChooseFrom: option values: option.
	option ifNil: [ ^ nil ].
	
	data := RTTabTable new 
		input: (RTDSMExample perform: option)
		usingDelimiter: Character tab.
	labels := data removeFirstRow.
	input := Dictionary new.
	other := Set new.
	data values do: [ :line| | item timeline  | 
		item := input at: (line second) ifAbsentPut: [ Dictionary new ].
		other add: line third.
		timeline := item at: line third ifAbsentPut: [ OrderedCollection new ].
		timeline add: line first -> line fourth asNumber. ].

	b := RTEvolutionDSM new.
	b objectsY: input keys.
	b objectsX: other.
	b timeline: [ :assoc | (input at: assoc key) at: assoc value ifAbsent: [ nil ] ].
	b labelShape
		height: 30;
		color: Color blue.
	b shape shape allShapes first size: 100.
	b shape shape allShapes second
		size: 100;
		values: [ :assoc| 
			assoc timeline 
				ifNil:  [ nil ]
				ifNotNil: [ :ob | ob collect: #value ] ].
	b selectElement: [ :e| e model score notNil ].
	b score: [ :assoc | assoc score ].
	^ b 
	

'
"
Class {
	#name : 'RSDSMExample',
	#superclass : 'RSAbstractExamples',
	#category : 'Roassal-Examples-DSM',
	#package : 'Roassal-Examples',
	#tag : 'DSM'
}

{ #category : 'example-data' }
RSDSMExample class >> collab [
	^ 'time	n1	n2 	weight
2005	Lea	Lucas	4.0
2005	Lucas	Lea	4.0
2005	Nathan	Nathan	1.0
2005	Lucas	Lucas	1.0
2005	Lea	Lea	1.0
2005	Louise	Louise	2.0
2006	Lucas	Nathan	2.0
2006	Nathan	Louise	2.0
2006	Lucas	Lea	8.0
2006	Louise	Nathan	2.0
2006	Louise	Lucas	2.0
2006	Lea	Lucas	8.0
2006	Nathan	Lucas	2.0
2006	Lucas	Louise	2.0
2006	Lucas	Lucas	3.0
2006	Emma	Emma	1.0
2006	Louise	Louise	1.0
2007	Lucas	Camille	4.0
2007	Lucas	Enzo	2.0
2007	Lea	Nathan	2.0
2007	Nathan	Camille	4.0
2007	Enzo	Lucas	2.0
2007	Emma	Lea	2.0
2007	Louise	Camille	4.0
2007	Lea	Camille	2.0
2007	Lucas	Emma	2.0
2007	Camille	Lea	2.0
2007	Enzo	Lea	2.0
2007	Chloe	Louise	2.0
2007	Chloe	Camille	2.0
2007	Louise	Nathan	8.0
2007	Lea	Lucas	8.0
2007	Nathan	Chloe	2.0
2007	Lucas	Chloe	2.0
2007	Chloe	Lucas	2.0
2007	Camille	Chloe	2.0
2007	Nathan	Lucas	8.0
2007	Emma	Lucas	2.0
2007	Chloe	Nathan	2.0
2007	Louise	Lea	2.0
2007	Camille	Nathan	4.0
2007	Nathan	Louise	8.0
2007	Lucas	Louise	8.0
2007	Lucas	Nathan	8.0
2007	Chloe	Lea	2.0
2007	Lea	Louise	2.0
2007	Lea	Emma	2.0
2007	Nathan	Lea	2.0
2007	Lea	Chloe	2.0
2007	Louise	Lucas	8.0
2007	Camille	Lucas	4.0
2007	Lea	Enzo	2.0
2007	Louise	Chloe	2.0
2007	Camille	Louise	4.0
2007	Lucas	Lea	8.0
2007	Hugo	Hugo	2.0
2007	Louise	Louise	1.0
2007	Sarah	Sarah	1.0
2007	Camille	Camille	1.0
2007	Enzo	Enzo	1.0
2007	Emma	Emma	1.0
2007	Chloe	Chloe	1.0
2008	Louise	Camille	2.0
2008	Emma	Lucas	2.0
2008	Camille	Louise	2.0
2008	Lucas	Gabriel	2.0
2008	Lucas	Camille	4.0
2008	Camille	Nathan	4.0
2008	Nathan	Louise	4.0
2008	Lucas	Louise	4.0
2008	Lucas	Nathan	6.0
2008	Louise	Lucas	4.0
2008	Camille	Lea	2.0
2008	Camille	Lucas	4.0
2008	Nathan	Lucas	6.0
2008	Nathan	Lea	2.0
2008	Lucas	Lea	2.0
2008	Nathan	Camille	4.0
2008	Emma	Enzo	2.0
2008	Gabriel	Lucas	2.0
2008	Louise	Nathan	4.0
2008	Lea	Camille	2.0
2008	Lea	Lucas	2.0
2008	Lea	Louise	2.0
2008	Lea	Nathan	2.0
2008	Enzo	Emma	2.0
2008	Lucas	Emma	2.0
2008	Louise	Lea	2.0
2008	Camille	Camille	1.0
2008	Emma	Emma	3.0
2008	Sarah	Sarah	1.0
2008	Gabriel	Gabriel	2.0
2008	Hugo	Hugo	1.0
2008	Louise	Louise	1.0
2009	Hugo	Lucas	4.0
2009	Lucas	Sarah	2.0
2009	Lucas	Lea	2.0
2009	Louise	Hugo	2.0
2009	Louise	Camille	4.0
2009	Hugo	Louise	2.0
2009	Enzo	Hugo	4.0
2009	Gabriel	Nathan	4.0
2009	Enzo	Louise	2.0
2009	Lea	Lucas	2.0
2009	Sarah	Lucas	2.0
2009	Camille	Nathan	4.0
2009	Camille	Hugo	2.0
2009	Enzo	Camille	2.0
2009	Louise	Gabriel	10.0
2009	Camille	Lucas	6.0
2009	Emma	Enzo	2.0
2009	Enzo	Lucas	2.0
2009	Camille	Enzo	2.0
2009	Gabriel	Louise	10.0
2009	Lucas	Camille	6.0
2009	Sarah	Louise	2.0
2009	Nathan	Louise	6.0
2009	Nathan	Camille	4.0
2009	Nathan	Lea	2.0
2009	Camille	Lea	2.0
2009	Gabriel	Lucas	10.0
2009	Nathan	Gabriel	4.0
2009	Louise	Nathan	6.0
2009	Louise	Sarah	2.0
2009	Nathan	Lucas	8.0
2009	Enzo	Emma	2.0
2009	Louise	Enzo	2.0
2009	Camille	Sarah	2.0
2009	Lea	Camille	2.0
2009	Hugo	Camille	2.0
2009	Enzo	Sarah	4.0
2009	Lucas	Hugo	4.0
2009	Sarah	Camille	2.0
2009	Camille	Louise	4.0
2009	Hugo	Enzo	4.0
2009	Sarah	Enzo	4.0
2009	Lucas	Louise	14.0
2009	Lucas	Enzo	2.0
2009	Lucas	Gabriel	10.0
2009	Lea	Nathan	2.0
2009	Lucas	Nathan	8.0
2009	Lea	Louise	2.0
2009	Louise	Lea	2.0
2009	Sarah	Hugo	2.0
2009	Hugo	Sarah	2.0
2009	Louise	Lucas	14.0
2009	Sarah	Sarah	1.0
2009	Camille	Camille	1.0
2009	Hugo	Hugo	1.0
2009	Gabriel	Gabriel	2.0
2009	Emma	Emma	4.0
2010	Nathan	Lea	2.0
2010	Sarah	Lucas	4.0
2010	Lea	Nathan	2.0
2010	Camille	Sarah	2.0
2010	Gabriel	Lucas	10.0
2010	Louise	Lea	2.0
2010	Hugo	Lucas	6.0
2010	Nathan	Camille	4.0
2010	Enzo	Louise	2.0
2010	Nathan	Lucas	6.0
2010	Camille	Hugo	2.0
2010	Lucas	Nathan	6.0
2010	Lucas	Hugo	6.0
2010	Lucas	Camille	6.0
2010	Louise	Gabriel	12.0
2010	Louise	Camille	4.0
2010	Sarah	Louise	4.0
2010	Hugo	Louise	2.0
2010	Lucas	Sarah	4.0
2010	Gabriel	Sarah	2.0
2010	Camille	Louise	4.0
2010	Nathan	Gabriel	2.0
2010	Camille	Lucas	6.0
2010	Nathan	Louise	4.0
2010	Lucas	Lea	2.0
2010	Enzo	Camille	2.0
2010	Enzo	Lucas	2.0
2010	Lucas	Enzo	2.0
2010	Lucas	Gabriel	10.0
2010	Hugo	Enzo	2.0
2010	Sarah	Gabriel	2.0
2010	Louise	Hugo	2.0
2010	Lea	Lucas	2.0
2010	Camille	Nathan	4.0
2010	Sarah	Enzo	2.0
2010	Gabriel	Louise	12.0
2010	Camille	Enzo	2.0
2010	Lucas	Louise	14.0
2010	Louise	Lucas	14.0
2010	Enzo	Sarah	2.0
2010	Hugo	Sarah	2.0
2010	Enzo	Hugo	2.0
2010	Louise	Sarah	4.0
2010	Sarah	Hugo	2.0
2010	Lea	Louise	2.0
2010	Camille	Lea	2.0
2010	Sarah	Camille	2.0
2010	Lea	Camille	2.0
2010	Hugo	Camille	2.0
2010	Louise	Enzo	2.0
2010	Gabriel	Nathan	2.0
2010	Louise	Nathan	4.0
2010	Enzo	Enzo	1.0
2010	Emma	Emma	1.0
2010	Chloe	Chloe	1.0
2010	Camille	Camille	1.0
2010	Hugo	Hugo	1.0'
]

{ #category : 'example-data' }
RSDSMExample class >> gtinspector [
	^ 'time	n1	n2 	weight
51	GTExample	AndreiChis	1
51	GTExample	StefanReichhart	3
47	GTExample	StefanReichhart	15
46	GTExample	StefanReichhart	10
49	GTExample	StefanReichhart	58
52	GTExample	StefanReichhart	5
48	GTExample	StefanReichhart	19
49	GTExampleFinder	StefanReichhart	12
48	GTExampleFinder	StefanReichhart	6
47	GTExampleFinder	StefanReichhart	2
46	GTExampleFinder	StefanReichhart	4
49	GTExampleResult	StefanReichhart	1
48	GTExampleResult	StefanReichhart	14
52	GTExampleResult	StefanReichhart	1
46	GTExampleResult	StefanReichhart	2
49	GTExampleProcessor	StefanReichhart	9
48	GTExampleProcessor	StefanReichhart	8
47	GTExampleProcessor	StefanReichhart	7
40	GTInspectorMethodListFilter	AndreiChis	12
49	GTExampleProxy	StefanReichhart	3
48	GTExampleProxy	StefanReichhart	16
47	GTExampleProxy	StefanReichhart	5
46	GTExampleProxy	StefanReichhart	2
40	GTInspectorTagFilter	AndreiChis	11
41	GTInspectorTagFilter	AndreiChis	2
51	GTExampleOrganizer	AndreiChis	3
47	GTExampleOrganizer	StefanReichhart	5
46	GTExampleOrganizer	StefanReichhart	1
49	GTExampleOrganizer	StefanReichhart	21
48	GTExampleOrganizer	StefanReichhart	2
0	GTInspector	TudorGirba	1
40	GTInspector	AndreiChis	1
40	GTInspector	EstebanLorenzano	1
36	GTInspector	AndreiChis	3
44	GTInspector	TudorGirba	1
31	GTInspector	TudorGirba	2
38	GTInspector	AndreiChis	3
38	GTInspector	SvenVanCaekenberghe	1
41	GTInspector	AndreiChis	6
49	GTExampleNautilus	StefanReichhart	2
52	GTExampleNautilus	StefanReichhart	5
51	GTExampleNautilus	JurajKubelka	2
'
]

{ #category : 'sources' }
RSDSMExample >> example01Numbers [
	<script: 'self new example01Numbers open'>
	| dsm |
	dsm := RSDSM new.
	dsm objects: (1 to: 10).
	dsm dependency: [ :aValue | aValue // 2 ].
	^ dsm
]

{ #category : 'sources' }
RSDSMExample >> example02Numbers [
	<script: 'self new example02Numbers open'>
	| dsm |
	dsm := RSDSM new.
	dsm objectsX: (1 to: 10).
	dsm objectsY: (1 to: 10 by: 2).
	dsm dependency: [ :aValue | aValue // 2 ].
	^ dsm
]

{ #category : 'sources' }
RSDSMExample >> example03Classes [
	<script: 'self new example03Classes open'>
	| dsm |
	dsm := RSDSM new.
	dsm objects: RSShape withAllSubclasses.
	dsm setShouldFeedY.
	dsm dependency: #dependentClasses.
	dsm shape popup.
	^ dsm
]

{ #category : 'sources' }
RSDSMExample >> example04Token [

	<script: 'self new example04Token open'>
	| packageRegExp packages getKeywordsFromClass rawKeywords top10Keywords dsm |
	packageRegExp := { 'Roassal-*' }.
	packages := RPackageOrganizer default packages select: [ :p |
		            packageRegExp anySatisfy: [ :r | r match: p name ] ].

	getKeywordsFromClass := [ :cls |
	                        cls name cutCamelCase
	                        ,
		                        (((cls methods collect: #selector)
			                          flatCollect: [ :k | k substrings: ':' ])
			                         flatCollect: #cutCamelCase) collect:
		                        #asLowercase ].

	rawKeywords := (packages flatCollect: #definedClasses) flatCollect:
		               getKeywordsFromClass.

	top10Keywords := (((rawKeywords groupedBy: #yourself) associations
		                   sorted: [ :a :b | a value size > b value size ])
		                  first: 70) collect: #key.

	dsm := RSDSM new.
	dsm objectsX: top10Keywords.
	dsm objectsY: packages.
	dsm setShouldFeedY.
	dsm labelShapeY textBlock: #name.
	dsm dependency: [ :pak |
		pak definedClasses flatCollect: getKeywordsFromClass ].
	^ dsm
]

{ #category : 'sources' }
RSDSMExample >> example05TopLabelRotation [
	<script: 'self new example05TopLabelRotation open'>
	| dsm v keys |
	v := Dictionary new
		at: #A put: #(B C);
		at: #B put: #(A C);
		at: #C put: #(A);
		yourself.
	keys := #(9 A B C D).
	dsm := RSDSM new.
	dsm objects: keys.
	dsm setShouldFeedY.
	dsm rotation: 0.
	dsm dependency: [ :k  | v at: k ifAbsent: #() ].
	^ dsm
]

{ #category : 'sources' }
RSDSMExample >> example06StronglyConnected [
	<script: 'self new example06StronglyConnected open'>
	| dsm v keys |
	v := Dictionary new
		at: #A put: #(B C);
		at: #B put: #(A C);
		at: #C put: #(A);
		yourself.
	keys := #(9 A B C D).
	dsm := RSDSMStronglyConnected new.
	dsm objects: keys.
	dsm setShouldFeedY.
	dsm dependency: [ :k  | v at: k ifAbsent: #() ].
	^ dsm
]

{ #category : 'sources' }
RSDSMExample >> example07StronglyConnectedWithClasses [
	<script: 'self new example07StronglyConnectedWithClasses open'>
	| classes v keys dsm |
	classes := Collection withAllSubclasses.
	v := Dictionary new.
	classes
		do: [ :c | v at: c name put: (c dependentClasses collect: #name) ]
		displayingProgress: [:c | 'Processing: ', c name ]
		every: 500.
	keys := v keys.
	dsm := RSDSMStronglyConnected new.
	dsm objects: keys.
	dsm setShouldFeedY.
	dsm shape @ (RSPopup text: [ :association |
		association key,
		((dsm isAssocDependent: association)
			ifTrue: [ ' depends on ' ]
			ifFalse: [ ' does not depend on' ]) , association value ]).
	dsm dependency: [ :k | v at: k ifAbsent: #() ].
	^ dsm
]

{ #category : 'sources' }
RSDSMExample >> example08Heatmap [
	<script: 'self new example08Heatmap open'>
	| builder |
	builder := RSHeatmap new.
	builder objectsX: #('A' 'B' 'C').
	builder objectsY: #('tomato' 'pumpkin').
	builder dataMatrix: #(#(1 2 5) #(3 4 6)).
	^ builder
]

{ #category : 'sources' }
RSDSMExample >> example09HeatmapMonths [
	<script: 'self new example09HeatmapMonths open'>
	| builder |
	builder := RSHeatmap new.
	builder shape extent: 40 @ 15.
	builder colorPalette: (NSScale linear
		range: {Color gray. Color purple muchDarker}).
	builder labelShapeCell labelShape
		border: (RSBorder new color: Color black; width: 0.3);
		color: Color white.
	builder objectsX: #('<0.1' '0.1-4.0' '4.1-10' '10.1-20' '>20').
	builder objectsY: #(January February March April May June July August September October November December).
   builder dataMatrix: #(
		#(255 167 123 65 41)
		#(244 196 89 52 12)
		#(268 198 119 46 20)
		#(321 179 88 31 11)
		#(413 152 51 31 4)
		#(432 137 42 15 4)
		#(567 63 14 7 4)
		#(550 63 24 8 6)
		#(454 114 39 16 7)
		#(337 165 81 44 24)
		#(238 162 110 65 55)
		#(263 176 113 64 35)).
   ^ builder
]

{ #category : 'sources' }
RSDSMExample >> example10Vegetables [
	<script: 'self new example10Vegetables open'>
	| vegetables farmers values h |
	h := RSHeatmap new.
	h shape extent: 40@20.
	vegetables := { 'cucumber' . 'tomato'.  'lettuce'. 'asparagus' .
              'potato'. 'wheat'. 'barley' }.
	farmers := { 'Farmer Joe'. 'Upland Bros.'. 'Smith Gardening'.
           'Agrifun'. 'Organiculture' . 'BioGoods Ltd.'. 'Cornylee Corp.' }.
	values := {{0.8. 2.4. 2.5. 3.9. 0.0. 4.0. 0.0}.
                    {2.4. 0.0. 4.0. 1.0. 2.7. 0.0. 0.0}.
                    {1.1. 2.4. 0.8. 4.3. 1.9. 4.4. 0.0}.
                    {0.6. 0.0. 0.3. 0.0. 3.1. 0.0. 0.0}.
                    {0.7. 1.7. 0.6. 2.6. 2.2. 6.2. 0.0}.
                    {1.3. 1.2. 0.0. 0.0. 0.0. 3.2. 5.1}.
                    {0.1. 2.0. 0.0. 1.4. 0.0. 1.9. 6.3}}.
	h objectsX: farmers.
	h objectsY: vegetables.
   h dataMatrix: values.
   ^ h
]

{ #category : 'sources' }
RSDSMExample >> example11Heatmap [
	<script: 'self new example11Heatmap open'>
	| builder |
	builder := RSHeatmap new.
	builder objectsX: #('A' 'B' 'C').
	builder objectsY: #('tomato' 'pumpkin').
	builder dataMatrix: #(#(1 2 5) #(3 4 6)).
	builder color: [ :aNumber | Color random ].
	builder build.
	builder gradientLegend remove.
	^ builder canvas
]

{ #category : 'sources' }
RSDSMExample >> example12Heatmap [
	<script: 'self new example12Heatmap open'>
	| builder |
	builder := RSHeatmap new.
	builder objectsX: #('A' 'B' 'C').
	builder objectsY: #('tomato' 'pumpkin').
	builder dataMatrix: #(#(1 2 5) #(3 4 6)).
	builder shouldShowCellLabels: false.
	^ builder
]
