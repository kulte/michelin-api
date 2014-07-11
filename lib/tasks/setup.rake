task :setup => :environment do
	Rake::Task["db:create"].invoke
	Rake::Task["db:migrate"].invoke
	Rake::Task["db:seed"].invoke
	Rake::Task["import:all"].invoke
end
