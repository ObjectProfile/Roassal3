Class {
	#name : #PLTExample,
	#superclass : #Object,
	#category : #'Roassal3-Matplotlib'
}

{ #category : #'as yet unclassified' }
PLTExample >> exampleBasic01 [

"
x = np.linspace(0, 2, 100)

plt.plot(x, x, label='linear')
plt.plot(x, x**2, label='quadratic')
plt.plot(x, x**3, label='cubic')

plt.xlabel('x label')
plt.ylabel('y label')

plt.title('Simple Plot')
plt.legend()
plt.show()

From: https://matplotlib.org/tutorials/introductory/usage.html#sphx-glr-tutorials-introductory-usage-py
"

	| plt x |
	plt := PLT new.
	x := (0 to: 2 by: 1 / 100).
	plt plotX: x y: x label: 'linear'.
	plt plotX: x y: (x collect: [ :v | v raisedTo: 2 ]) label: 'quadratic'.
	plt plotX: x y: (x collect: [ :v | v raisedTo: 3 ]) label: 'cubic'.
		
	plt xLabel: 'x label'.
	plt yLabel: 'y label'.
	plt title: 'Simple plot'.
	plt legend.
	plt show
]
