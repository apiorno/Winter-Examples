"
I represent the arkanoid game itself

Instance variables: 

- playing

Public API and Key Messages:

- player
- playing
- playing:
- resetPlayerAndBall:
"
Class {
	#name : #Arkanoid,
	#superclass : #Game,
	#instVars : [
		'playing',
		'collisionHandlers',
		'player',
		'assetManager',
		'actors',
		'ball',
		'checker',
		'actorsToRemove'
	],
	#category : #'Winter-Arkanoid'
}

{ #category : #removing }
Arkanoid >> addForRemoval: anActor [

	actorsToRemove add: anActor
]

{ #category : #Collisions }
Arkanoid >> checkEndGame [

	ball position y > self screen extentY
		ifTrue: [ self reset ]
]

{ #category : #Accessing }
Arkanoid >> dimensions [

	^ 650 @ 700
]

{ #category : #Accessing }
Arkanoid >> eventHandler [

	| handler |

	handler := BasicEventHandler of: self.
	handler registerObserver: player.
	^ handler
]

{ #category : #initialization }
Arkanoid >> greenBrick [

	^ assetManager assetNamed: #green
]

{ #category : #Collisions }
Arkanoid >> handleCollision: aCollision [

	collisionHandlers do: [ :handler | handler handle: aCollision ]
]

{ #category : #initialization }
Arkanoid >> initialize [

	super initialize.
	playing := false.
	self
		initializeResources;
		initializeCollisionHandlers;
		initializePlayer;
		initializeActors.
	ball := ArkanoidBall representedWith: ( assetManager assetNamed: #ball ).
	checker := CollisionChecker new.
	actorsToRemove := OrderedCollection new.
]

{ #category : #initialization }
Arkanoid >> initializeActors [

	actors := OrderedCollection new
		add: ( ArkanoidBrick yellowRepresentedWith: self yellowBrick on: 150 @ 150 ofExtent: 50 @ 25 );
		add: ( ArkanoidBrick greenRepresentedWith: self greenBrick on: 210 @ 150 ofExtent: 50 @ 25 );
		add: ( ArkanoidBrick redRepresentedWith: self redBrick on: 90 @ 150 ofExtent: 50 @ 25 );
		yourself
]

{ #category : #initialization }
Arkanoid >> initializeCollisionHandlers [

	collisionHandlers := OrderedCollection new.
	collisionHandlers
		add:
			( CollisionHandler
				between: ArkanoidBall
				and: ArkanoidBrick
				onCollisionDo: [ :collision | 
					collision secondComponent collidedByBallIn: self.
					collision firstComponent negateY.
					self playCollisionSound
					] );
		add:
			( CollisionHandler
				between: ArkanoidBall
				and: ArkanoidPlayer
				onCollisionDo: [ :collision | 
					collision firstComponent negateY.
					self playCollisionSound
					] )
]

{ #category : #initialization }
Arkanoid >> initializePlayer [

	player := ArkanoidPlayer representedWith: (assetManager assetNamed: #arkanoidBar).

	player
		addInteractionOnKeyDownOf: Character arrowLeft
			doing: [ player moveLeft.
			playing := true
			];
		addInteractionOnKeyDownOf: Character arrowRight
			doing: [ player moveRight.
			playing := true
			].

]

{ #category : #initialization }
Arkanoid >> initializeResources [

	assetManager := AssetsManager new.
	assetManager
		addSprite: 'resources/arkanoid/background.png'
			named: #background
			applying: [ :aForm | aForm scaledToSize: self dimensions ];
		addSprite: 'resources/arkanoid/yellow.png'
			named: #yellow
			applying: [ :aForm | aForm scaledToSize: 38 @ 38 ];
		addSprite: 'resources/arkanoid/green.png'
			named: #green
			applying: [ :aForm | aForm scaledToSize: 38 @ 38 ];
		addSprite: 'resources/arkanoid/red.png'
			named: #red
			applying: [ :aForm | aForm scaledToSize: 38 @ 38 ];
		addSprite: 'resources/arkanoid/ball.png'
			named: #ball
			applying: [ :aForm | aForm scaledToSize: 38 @ 38 ];
		addSprite: 'resources/arkanoid/arkanoid_bar.png' named: #arkanoidBar";
		addSound: 'resources/arkanoid/arkanoid_ball_collision.wav' named: #ballCollision"
]

{ #category : #Collisions }
Arkanoid >> playCollisionSound [

	"Fix load of sound asset"

	"( assetManager assetNamed: #ballCollision ) play"

	
]

{ #category : #Accessing }
Arkanoid >> player [

	^player
]

{ #category : #initialization }
Arkanoid >> redBrick [

	^ assetManager assetNamed: #red
]

{ #category : #removing }
Arkanoid >> removeActor: anActor [

	actors remove: anActor ifAbsent: [  ]
]

{ #category : #removing }
Arkanoid >> removeActorPendingForRemoval [

	actorsToRemove do: [ :actor | self removeActor: actor ]
]

{ #category : #rendering }
Arkanoid >> renderBackgroundOn: aCanvas [

	aCanvas setPaint: ( assetManager assetNamed: #background ).
	aCanvas drawShape: ( 0 @ 0 fastCorner: aCanvas surface extent )
]

{ #category : #rendering }
Arkanoid >> renderOn: aCanvas [

	self renderBackgroundOn: aCanvas.
	playing
		ifTrue: [ player
				renderOn: aCanvas;
				update.
			ball
				renderOn: aCanvas;
				update.
			[ checker checkFor: ball and: player.
			actors
				do: [ :actor | 
					actor
						renderOn: aCanvas;
						update.
					checker checkFor: ball and: actor
					]
			]
				on: CollisionOcurred
				do: [ :collision | 
					self handleCollision: collision.
					collision resume
					].

			self checkEndGame
			]
		ifFalse: [ player renderOn: aCanvas.
			ball renderOn: aCanvas.
			actors do: [ :actor | actor renderOn: aCanvas ]
			].
		
	self removeActorPendingForRemoval 
]

{ #category : #Reset }
Arkanoid >> reset [

	playing := false.
	self initialize 
]

{ #category : #Accessing }
Arkanoid >> title [

	^'Arkanoid'
]

{ #category : #initialization }
Arkanoid >> yellowBrick [

	^ assetManager assetNamed: #yellow
]
