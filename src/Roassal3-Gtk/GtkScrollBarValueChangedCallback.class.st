Class {
	#name : #GtkScrollBarValueChangedCallback,
	#superclass : #GManagedSignalCallback,
	#pools : [
		'GtkTypes'
	],
	#category : #'Roassal3-Gtk'
}

{ #category : #accessing }
GtkScrollBarValueChangedCallback >> do: aBlock [

	super do: [ :event :aData |
		aBlock value: (GtkAdjustment fromHandle: event) ]
]

{ #category : #accessing }
GtkScrollBarValueChangedCallback >> signalName [

	^ 'value_changed'
]

{ #category : #accessing }
GtkScrollBarValueChangedCallback >> signature [

	^ #(void (GtkAdjustment *adjustment, void *user_data))
]
