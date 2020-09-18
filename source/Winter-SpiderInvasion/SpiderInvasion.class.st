"
I represent the SPider invasion game itself


Public API and Key Messages:

- dimensions
- gameSize
- player
- spriteSize

"
Class {
	#name : #SpiderInvasion,
	#superclass : #Game,
	#instVars : [
		'player',
		'assetsManager',
		'collisionHandlers',
		'actors',
		'actorsToRemove'
	],
	#category : #'Winter-SpiderInvasion'
}

{ #category : #Running }
SpiderInvasion class >> start [

	^ self new start
]

{ #category : #accessing }
SpiderInvasion >> actors [

	^ actors
]

{ #category : #managing }
SpiderInvasion >> addActor: anActor [

	actors add: anActor
]

{ #category : #managing }
SpiderInvasion >> addForRemoval: anActor [

	actorsToRemove add: anActor
]

{ #category : #accessing }
SpiderInvasion >> assetsManager [

	^ assetsManager
]

{ #category : #accessing }
SpiderInvasion >> background [

	^ Color black
]

{ #category : #accessing }
SpiderInvasion >> dimensions [

	^ self gameSize * self spriteSize
]

{ #category : #accessing }
SpiderInvasion >> eventHandler [

	| handler |

	handler := BasicEventHandler of: self.
	handler registerObserver: player.
	^ handler
]

{ #category : #accessing }
SpiderInvasion >> gameSize [

	^ 8 @ 14
]

{ #category : #processing }
SpiderInvasion >> handleCollision: aCollision [

	collisionHandlers do: [ :handler | handler handle: aCollision ]
]

{ #category : #initialization }
SpiderInvasion >> initialize [

	super initialize.
	self
		initializeResources;
		initializePlayer;
		initializeCollisionHandlers;
		initializeActors.

	actorsToRemove := OrderedCollection new
]

{ #category : #initialization }
SpiderInvasion >> initializeActors [

	actors := OrderedCollection new.
	self initializeWalls.
	self initializeSpiders
]

{ #category : #initialization }
SpiderInvasion >> initializeCollisionHandlers [

	collisionHandlers := OrderedCollection new.
	collisionHandlers
		add:
			( CollisionHandler
				between: SpiderInvasionSpider
				and: SpiderInvasionWall
				onCollisionDo: [ :collision | 
					| leftOrRight newSpiderPos |

					leftOrRight := #(-1 1) atRandom.
					newSpiderPos := collision firstComponent position - ( 0 @ 1 ) + ( leftOrRight @ 0 ).
					( self isValidPosition: newSpiderPos )
						ifTrue: [ collision firstComponent position: newSpiderPos ]
					] );
		add:
			( CollisionHandler
				between: SpiderInvasionSpider
				and: SpiderInvasionMissile
				onCollisionDo: [ :collision | 
					collision firstComponent die.
					collision secondComponent die
					] );
		add:
			( CollisionHandler
				between: SpiderInvasionWall
				and: SpiderInvasionMissile
				onCollisionDo: [ :collision | 
					collision firstComponent die.
					collision secondComponent die
					] )
]

{ #category : #initialization }
SpiderInvasion >> initializePlayer [

	player := SpiderInvasionPlayer on: self.

	player
		addInteractionOnKeyDownOf: Character arrowLeft doing: [ player moveLeft ];
		addInteractionOnKeyDownOf: Character arrowRight doing: [ player moveRight ];
		addInteractionOnKeyDownOf: Character tab doing: [ player fire ]
]

{ #category : #initialization }
SpiderInvasion >> initializeResources [

	assetsManager := AssetsManager new.
	assetsManager
		addSprite: 'resources/spaceInvaders/spider.png' named: #spider;
		addSprite: 'resources/spaceInvaders/wall.png' named: #wall;
		addSprite: 'resources/spaceInvaders/missile.png' named: #missile;
		addSprite: 'resources/spaceInvaders/explode.png' named: #explode;
		addSprite: 'resources/spaceInvaders/spaceShip.png' named: #spaceShip
]

{ #category : #initialization }
SpiderInvasion >> initializeSpiders [

	"Only half of the boxes in the first row contain a spider at the start of the game."
	1 to: self maxX // 2 do: [ :i |
		self newRandomSpiderTicked: self maxX + 10 + 20 atRandom ]
]

{ #category : #initialization }
SpiderInvasion >> initializeWalls [

	self
		withIndexItemsDo: [ :x :y | 
			( y = self minY or: [ y = self maxY ] )
				ifFalse: [ 100 atRandom < 20
						ifTrue: [ "20% of chances" self addActor: ( SpiderInvasionWall inPosition: x @ y of: self ) ]
					]
			]
]

{ #category : #testing }
SpiderInvasion >> isOccupiedAt: aPosition [

	^ self actors anySatisfy: [ :actor | actor position = aPosition ]
]

{ #category : #testing }
SpiderInvasion >> isValidPosition: aPosition [

	^ self minX @ self minY <= aPosition and: [ aPosition <= ( self maxX @ self maxY ) ]
]

{ #category : #processing }
SpiderInvasion >> lostGame [

	actors := OrderedCollection new.
	self
		withIndexItemsDo: [ :i :j | 
			j = self maxY
				ifFalse: [ self addActor: ( SpiderInvasionExplode atPosition: i @ j of: self tick: 30 ) ]
			]
]

{ #category : #private }
SpiderInvasion >> maxX [

	^ 8
]

{ #category : #private }
SpiderInvasion >> maxY [

	^ 14
]

{ #category : #private }
SpiderInvasion >> minX [

	^ 1
]

{ #category : #private }
SpiderInvasion >> minY [

	^ 1
]

{ #category : #private }
SpiderInvasion >> newRandomSpiderTicked: numTick [

	| randomX spider |

	[ randomX := self randomX.
	self isOccupiedAt: randomX @ 1
	] whileTrue.
	spider := SpiderInvasionSpider atPosition: randomX @ self minY of: self tick: numTick.
	self addActor: spider
]

{ #category : #private }
SpiderInvasion >> randomX [

	^ self maxX atRandom - 1 + self minX
]

{ #category : #managing }
SpiderInvasion >> removeActor: anActor [

	actors remove: anActor ifAbsent: [  ]
]

{ #category : #managing }
SpiderInvasion >> removeActorPendingForRemoval [

	actorsToRemove do: [ :actor | self removeActor: actor ]
]

{ #category : #rendering }
SpiderInvasion >> renderBackgroundOn: aCanvas [

	aCanvas setPaint: self background.
	aCanvas drawShape: ( 0 @ 0 fastCorner: aCanvas surface extent )
]

{ #category : #rendering }
SpiderInvasion >> renderOn: aCanvas [

	self renderBackgroundOn: aCanvas.
	player renderOn: aCanvas.
	player update.

	[ actors
		do: [ :actor | 
			actor
				renderOn: aCanvas;
				update
			]
	]
		on: CollisionOcurred
		do: [ :collision | self handleCollision: collision ].
	self removeActorPendingForRemoval
]

{ #category : #accessing }
SpiderInvasion >> spriteSize [

	^ 48@48
]

{ #category : #accessing }
SpiderInvasion >> title [

	^'Spider Invasion'
]

{ #category : #private }
SpiderInvasion >> withIndexItemsDo: aBlock [

	self minY to: self maxY do: [ :j | self minX to: self maxX do: [ :i | aBlock value: i value: j ] ]
]
