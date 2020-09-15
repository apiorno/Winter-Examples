Class {
	#name : #BaselineOfWinterExamples,
	#superclass : #BaselineOf,
	#category : #BaselineOfWinterExamples
}

{ #category : #baselines }
BaselineOfWinterExamples >> baseline: spec [

	<baseline>
	spec
		for: #pharo
		do: [ self setUpDependenciesFor: spec.
			self setUpPackagesFor: spec
			]
]

{ #category : #accessing }
BaselineOfWinterExamples >> projectClass [ 

	^ MetacelloCypressBaselineProject
]

{ #category : #initialization }
BaselineOfWinterExamples >> setUpDependenciesFor: spec [

	spec
		baseline: 'Winter' with: [ spec repository: 'github://ba-st/Winter:release-candidate/source' ];
		project: 'Winter-Deployment' copyFrom: 'Winter' with: [ spec loads: 'Deployment' ]
]

{ #category : #initialization }
BaselineOfWinterExamples >> setUpPackagesFor: spec [

	spec
		package: 'Winter-Arkanoid' with: [ spec requires: #('Winter-Deployment') ];
		group: 'Deployment' with: 'Winter-Arkanoid';
		package: 'Winter-SpiderInvasion' with: [ spec requires: #('Winter-Deployment') ];
		group: 'Deployment' with: 'Winter-SpiderInvasion';
		package: 'Winter-WizardBattleArena' with: [ spec requires: #('Winter-Deployment') ];
		group: 'Deployment' with: 'Winter-WizardBattleArena'

]
