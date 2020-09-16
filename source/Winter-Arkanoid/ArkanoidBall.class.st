"
I represent the ball of the Arkanoid game.

Instance variables: 

- deltaPoint

Public API and Key Messages:

- checkCollisions
- checkEndGame
- negateX
- negateY
- playCollisionSound

"
Class {
	#name : #ArkanoidBall,
	#superclass : #GameMovableActor,
	#instVars : [
		'deltaPoint'
	],
	#category : #'Winter-Arkanoid'
}

{ #category : #'Instance Creation' }
ArkanoidBall class >> representedWith: aSprite [

	^ self new initializeRepresendtadWith: aSprite
]

{ #category : #Updating }
ArkanoidBall >> checkCollisions [

	( self position x between: 0 and: 550 )
		ifTrue: [ "Inside boundaries" ]
		ifFalse: [ self negateX ].
	self position y <= 0
		ifTrue: [ self negateY ]
		ifFalse: [ "Inside boundaries" ]
]

{ #category : #Initialization }
ArkanoidBall >> initialize [

	super initialize.
	deltaPoint := 10 @ 10 negated 
]

{ #category : #Initialization }
ArkanoidBall >> initializeCollisionShape [

	collisionShape := Circle 
		ofCenter: 250 @ 500
		radius: 15
		color: Color red
]

{ #category : #Initialization }
ArkanoidBall >> initializeRepresendtadWith: aSprite [

	sprite := aSprite 
]

{ #category : #Updating }
ArkanoidBall >> negateX [

	deltaPoint := deltaPoint x negated @ deltaPoint y
]

{ #category : #Updating }
ArkanoidBall >> negateY [

	deltaPoint := deltaPoint x  @ deltaPoint y negated
]

{ #category : #Updating }
ArkanoidBall >> update [

	super update.
	collisionShape position: collisionShape position + deltaPoint.
]
