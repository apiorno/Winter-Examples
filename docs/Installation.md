# Installation

## Basic Installation

You can load **Winter-Examples** evaluating:
```smalltalk
Metacello new
	baseline: 'WinterExamples';
	repository: 'github://apiorno/Winter-Examples:release-candidate/source';
	load.
```
>  Change `release-candidate` to some released version if you want a pinned version

## Using as dependency

In order to include **Winter-Examples** as part of your project, you should reference the package in your product baseline:

```smalltalk
setUpDependencies: spec

	spec
		baseline: 'WinterExamples'
			with: [ spec
				repository: 'github://apiorno/Winter-Examples:v{XX}/source';
				loads: #('Deployment') ];
		import: 'WinterExamples'.
```
> Replace `{XX}` with the version you want to depend on

```smalltalk
baseline: spec

	<baseline>
	spec
		for: #common
		do: [ self setUpDependencies: spec.
			spec package: 'My-Package' with: [ spec requires: #('WinterExamples') ] ]
```

## Provided groups

- `Deployment` will load all the packages needed in a deployed application
- `Development` will load all the needed packages to develop and contribute to the project
