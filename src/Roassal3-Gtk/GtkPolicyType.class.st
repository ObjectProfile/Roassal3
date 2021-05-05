"
GtkPolicyType rebuildEnumAccessors.

GtkPolicyType initializeEnumeration.
"
Class {
	#name : #GtkPolicyType,
	#superclass : #GtkEnumeration,
	#classVars : [
		'GTK_POLICY_ALWAYS',
		'GTK_POLICY_AUTOMATIC',
		'GTK_POLICY_EXTERNAL',
		'GTK_POLICY_NEVER'
	],
	#category : #'Roassal3-Gtk'
}

{ #category : #'accessing enum' }
GtkPolicyType class >> GTK_POLICY_ALWAYS [
	"This method was automatically generated"
	^ GTK_POLICY_ALWAYS
]

{ #category : #'accessing enum' }
GtkPolicyType class >> GTK_POLICY_AUTOMATIC [
	"This method was automatically generated"
	^ GTK_POLICY_AUTOMATIC
]

{ #category : #'accessing enum' }
GtkPolicyType class >> GTK_POLICY_EXTERNAL [
	"This method was automatically generated"
	^ GTK_POLICY_EXTERNAL
]

{ #category : #'accessing enum' }
GtkPolicyType class >> GTK_POLICY_NEVER [
	"This method was automatically generated"
	^ GTK_POLICY_NEVER
]

{ #category : #'enum declaration' }
GtkPolicyType class >> enumDecl [
	^ #(
	GTK_POLICY_ALWAYS 	0
	GTK_POLICY_AUTOMATIC		1
	GTK_POLICY_EXTERNAL 2
	GTK_POLICY_NEVER 3
	)
]
