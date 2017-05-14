visiting
writeVersion: aVersion
	"We have to do that to avoid writing the version info."

	| members |
	directory := (members := MCFileTreeGitRepository
		parseName: aVersion info name) last.
	self deleteExistingPackageStructureFor: members.
	self fileUtils ensureDirectoryExists: self packageFileDirectory.
	self initializePackageFileDirectoryCache.
	self writeFormat.
	self writePackage: aVersion package.
	self writeDefinitions: aVersion.
	aVersion dependencies do: [ :ea | self writeVersionDependency: ea ]