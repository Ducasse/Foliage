Class {
	#name : 'FOServer',
	#superclass : 'Object',
	#instVars : [
		'server',
		'baseDirectory'
	],
	#category : 'Foliage-Server',
	#package : 'Foliage-Server'
}

{ #category : 'accessing' }
FOServer class >> start [
	<script>

	^ self new start
]

{ #category : 'accessing' }
FOServer class >> stop [
	<script>
	
	^ ZnServer default stop
]

{ #category : 'accessing' }
FOServer >> baseDirectory [

	^ baseDirectory ifNil: [ baseDirectory := 'generated' asFileReference ]
]

{ #category : 'accessing' }
FOServer >> baseDirectory: aReference [

	baseDirectory := aReference
]

{ #category : 'accessing' }
FOServer >> baseUrl [

	^ ''
]

{ #category : 'accessing' }
FOServer >> port [

	^ 7071
]

{ #category : 'start/stop' }
FOServer >> start [
	<script: 'self new start'>

	(ZnServer defaultOn: self port) start.
	ZnServer default delegate: (FOStaticFileServerDelegate new
		prefixFromString: self baseUrl;
		directory: self baseDirectory;
	 	yourself)
]

{ #category : 'start/stop' }
FOServer >> startOnTestFolder [
	<script: 'self new start'>

	(ZnServer defaultOn: 7071) start.
	ZnServer default delegate: (ZnStaticFileServerDelegate new
		prefixFromString: '';
		directory: '/Users/ducasse/Test2/Play/generated/' asFileReference;
	 	yourself)
]

{ #category : 'start/stop' }
FOServer >> startOnTestFolder74 [
	<script: 'self new startOnTestFolder74'>

	(ZnServer defaultOn: 7075) start.
	ZnServer default
		delegate:
			(ZnStaticFileServerDelegate new
				prefixFromString: '';
				directory: '/Users/ducasse/Test2/MySite/StephaneDucasse.github.io/generated' asFileReference;
				yourself).
]
