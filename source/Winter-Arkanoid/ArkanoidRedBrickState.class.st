"
I represent the red color state of a brick

Public API and Key Messages:

- affectCollisionWithBallTo:
- color
- sprite
"
Class {
	#name : #ArkanoidRedBrickState,
	#superclass : #ArkanoidBrickState,
	#category : #'Winter-Arkanoid'
}

{ #category : #Collisions }
ArkanoidRedBrickState >> affectCollisionWithBallTo: anArkanoidBlock in: aGame [

	anArkanoidBlock changeColorStateTo: ( ArkanoidYellowBrickState representedWith: aGame yellowBrick )
]

{ #category : #Accessing }
ArkanoidRedBrickState >> color [

	^ Color red
]
