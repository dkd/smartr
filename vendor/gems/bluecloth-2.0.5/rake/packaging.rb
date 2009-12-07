# 
# Packaging Rake Tasks
# $Id: packaging.rb 102 2009-05-23 21:40:00Z deveiant $
# 

require 'rbconfig'
require 'rake/packagetask'
require 'rake/gempackagetask'

include Config

### Task: gem
### Task: package
Rake::PackageTask.new( PKG_NAME, PKG_VERSION ) do |task|
  	task.need_tar_gz   = true
	task.need_tar_bz2  = true
	task.need_zip      = true
	task.package_dir   = PKGDIR.to_s
  	task.package_files = RELEASE_FILES.collect {|f| f.to_s }
end
task :package => [:gem]


### Task: gem
gempath = PKGDIR + GEM_FILE_NAME

desc "Build a RubyGem package (#{GEM_FILE_NAME})"
task :gem => gempath.to_s
file gempath.to_s => [PKGDIR.to_s] + GEMSPEC.files do
	when_writing( "Creating GEM" ) do
		Gem::Builder.new( GEMSPEC ).build
		verbose( true ) do
			mv GEM_FILE_NAME, gempath
		end
	end
end

svnrev = get_svn_rev()
prerelease_gem_file_name = "#{PKG_FILE_NAME}.#{svnrev}.gem"
prerelease_gempath = PKGDIR + prerelease_gem_file_name

desc "Build a pre-release RubyGem package"
task :prerelease_gem => prerelease_gempath.to_s
file prerelease_gempath.to_s => [PKGDIR.to_s] + GEMSPEC.files do
	when_writing( "Creating prerelease GEM" ) do
		gemspec = GEMSPEC.clone
		gemspec.version = Gem::Version.create( "%s.%d" % [GEMSPEC.version, svnrev] )
		Gem::Builder.new( gemspec ).build
		verbose( true ) do
			mv prerelease_gem_file_name, prerelease_gempath
		end
	end
end


### Task: install
desc "Install #{PKG_NAME} as a conventional library"
task :install => "spec:quiet" do
	log "Installing #{PKG_NAME} as a conventional library"
	sitelib = Pathname.new( CONFIG['sitelibdir'] )
	sitearch = Pathname.new( CONFIG['sitearchdir'] )
	Dir.chdir( LIBDIR ) do
		LIB_FILES.each do |libfile|
			relpath = libfile.relative_path_from( LIBDIR )
			target = sitelib + relpath
			FileUtils.mkpath target.dirname,
				:mode => 0755, :verbose => true, :noop => $dryrun unless target.dirname.directory?
			FileUtils.install relpath, target,
				:mode => 0644, :verbose => true, :noop => $dryrun
		end
	end
	if EXTDIR.exist?
		trace "  looking for a binary extension (%s)" % [ EXTDIR + "*.#{Config::CONFIG['DLEXT']}" ]
		Dir.chdir( EXTDIR ) do
			Pathname.glob( "*.#{Config::CONFIG['DLEXT']}" ) do |dl|
				trace "    found: #{dl}"
				target = sitearch + dl.basename
				FileUtils.install dl, target, 
					:mode => 0755, :verbose => true, :noop => $dryrun
			end
		end
	end
end



### Task: install_gem
desc "Install #{PKG_NAME} from a locally-built gem"
task :install_gem => [:package] do
	$stderr.puts 
	installer = Gem::Installer.new( %{pkg/#{PKG_FILE_NAME}.gem} )
	installer.install
end


### Task: uninstall
desc "Uninstall #{PKG_NAME} if it's been installed as a conventional library"
task :uninstall do
	log "Uninstalling conventionally-installed #{PKG_NAME} library files"
	sitelib = Pathname.new( CONFIG['sitelibdir'] )
	sitearch = Pathname.new( CONFIG['sitearchdir'] )

	Dir.chdir( LIBDIR ) do
		LIB_FILES.each do |libfile|
			relpath = libfile.relative_path_from( LIBDIR )
			target = sitelib + relpath
			FileUtils.rm_f target, :verbose => true, :noop => $dryrun
			FileUtils.rm_rf( target.dirname, :verbose => true, :noop => $dryrun ) if
				target.dirname.entries.empty?
		end
	end
	if EXTDIR.exist?
		trace "  looking for a binary extension (%s)" % [ EXTDIR + "*.#{Config::CONFIG['DLEXT']}" ]
		Dir.chdir( EXTDIR ) do
			Pathname.glob( "*.#{Config::CONFIG['DLEXT']}" ) do |dl|
				trace "    found: #{dl}"
				target = sitearch + dl.basename
				FileUtils.rm target, :verbose => true, :noop => $dryrun
			end
		end
	end
end


### Task: uninstall_gem
desc "Install the #{PKG_NAME} gem"
task :uninstall_gem => [:clean] do
	uninstaller = Gem::Uninstaller.new( PKG_FILE_NAME )
	uninstaller.uninstall
end



