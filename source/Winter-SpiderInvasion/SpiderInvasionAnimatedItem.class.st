"
I am an abstract class for animated non player components in the spider invasion scene.

Instance variables: 

- tick
- currentTick

Public API and Key Messages:

- action
- doTick
- tick
- tick:
"
Class {
	#name : #SpiderInvasionAnimatedItem,
	#superclass : #SpiderInvasionItem,
	#instVars : [
		'tick',
		'currentTick'
	],
	#category : #'Winter-SpiderInvasion'
}

{ #category : #Actions }
SpiderInvasionAnimatedItem >> action [

	self subclassResponsibility
]

{ #category : #Actions }
SpiderInvasionAnimatedItem >> doTick [

	currentTick := currentTick - 1.
	currentTick = 0
		ifTrue: [ self action.
			currentTick := tick
			]
]

{ #category : #Accessing }
SpiderInvasionAnimatedItem >> tick [

	^ tick
]

{ #category : #Accessing }
SpiderInvasionAnimatedItem >> tick: anObject [

	currentTick := tick := anObject
]

{ #category : #Events }
SpiderInvasionAnimatedItem >> update [

	self doTick.
	super update
]
