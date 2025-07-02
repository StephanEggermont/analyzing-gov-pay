Class {
	#name : #FileMetrics,
	#superclass : #Object,
	#instVars : [
		'file',
		'metrics'
	],
	#category : #'AnalyzingGovPay-Visualisation'
}

{ #category : #accessing }
FileMetrics class >> on: aFileReference [
	^self new
		file: aFileReference;
		yourself
]

{ #category : #'as yet unclassified' }
FileMetrics >> background [
	file size <1000 ifTrue: [^Color green].
	file size < 5000 ifTrue: [^Color yellow].
	^Color red
]

{ #category : #accessing }
FileMetrics >> calculateMetrics [
	|metric|
	metric := FileMetric new.
	metric backgroundValue: file size.
	metric metricsSize: self testsSize.
	metrics add: metric.
	metric := FileMetric new.
	metric backgroundValue: file size.
	metric metricsSize: self metricsSize.
	metrics add: metric.

]

{ #category : #accessing }
FileMetrics >> file [
	^ file
]

{ #category : #accessing }
FileMetrics >> file: aFileReference [ 
	file := aFileReference.
	metrics := OrderedCollection new.
	self calculateMetrics
]

{ #category : #accessing }
FileMetrics >> metrics [
	^ metrics ifNil: [^#()]
]

{ #category : #accessing }
FileMetrics >> metrics: anObject [
	metrics := anObject
]

{ #category : #'as yet unclassified' }
FileMetrics >> metricsSize [
	|nrOfMocks nrOfImports|
nrOfMocks := (file contents allRegexMatches: '@Mock') size.
	nrOfImports := (file contents allRegexMatches: 'import') size.
	^(3 max: nrOfMocks ) @ ( 3 max: nrOfImports)
]

{ #category : #'as yet unclassified' }
FileMetrics >> oneFileMetrics: aView [
	<gtView>
	^aView mondrian
		title: 'File metrics';
		priority: 10;
		painting: [ :m | 
			m nodes 
				stencil: [ :metrics |
					BlElement new
						background: self background;
						size: self metricsSize
					];
					with: (Array with:self).

			m ]
	
]

{ #category : #'as yet unclassified' }
FileMetrics >> testsSize [
	|nrOfMocks nrOfTests|
nrOfMocks := (file contents allRegexMatches: '@Mock') size.
	nrOfTests := (file contents allRegexMatches: '@Test') size.
	^(3 max: nrOfMocks ) @ ( 3 max: nrOfTests)
]
