Class {
	#name : #RSHeatmapExample,
	#superclass : #Object,
	#category : #'Roassal3-Heatmap'
}

{ #category : #'as yet unclassified' }
RSHeatmapExample >> example01SimpleHeatmap [
	<script: 'self new example01SimpleHeatmap'>
	"Example from https://matplotlib.org/3.1.1/gallery/images_contours_and_fields/image_annotated_heatmap.html#sphx-glr-gallery-images-contours-and-fields-image-annotated-heatmap-py"
	| vegetables farmers values h |
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
	h := RSHeatmap new.
	h xLabels: farmers.
	h yLabels: vegetables.
	h show: values.
	h open
]

{ #category : #'as yet unclassified' }
RSHeatmapExample >> example02WithLabels [
	<script: 'self new example02WithLabels'>
	| h |
	h := RSHeatmap new.
	h scale: (NSScale linear range: #(purple red)).
	h xLabels: #('A' 'BCDEFBCDEFBCDEFBCDEF').
	h yLabels: #('A' 'BCDEFBCDEFBCDEFBCDEF').
	h show: #(#(1 2) #(3 4)).
	h open
]
