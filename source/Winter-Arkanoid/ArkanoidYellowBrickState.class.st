"
I represent the yellow color state of a brick

Public API and Key Messages:

- affectCollisionWithBallTo:
- color
- sprite
"
Class {
	#name : #ArkanoidYellowBrickState,
	#superclass : #ArkanoidBrickState,
	#category : #'Winter-Arkanoid'
}

{ #category : #Collisions }
ArkanoidYellowBrickState >> affectCollisionWithBallTo: anArkanoidBlock in: aGame [

	anArkanoidBlock changeColorStateTo: ( ArkanoidGreenBrickState representedWith: aGame greenBrick )
]

{ #category : #Accessing }
ArkanoidYellowBrickState >> color [

	^ Color yellow 
]
