"
I represent an empty element in a cell


Public API and Key Messages:

- allowMovement

"
Class {
	#name : #WBAEmpty,
	#superclass : #WBAElement,
	#classInstVars : [
		'empty'
	],
	#category : #'Winter-WizardBattleArena'
}

{ #category : #accessing }
WBAEmpty class >> empty [
	^ empty ifNil: [ empty := self new ]
]

{ #category : #Testing }
WBAEmpty >> allowMovement [
	^ true
]

{ #category : #Accessing }
WBAEmpty >> initialShift [
	^ 0@0
]

{ #category : #initialization }
WBAEmpty >> initialize [

	super initialize.

	self shift: self initialShift

]