namespace :db do

  desc "Roll migrations up, down and back to check they are reversible"
  task :migtest do
    Rake::Task['db:migrate'].invoke
    Rake::Task['db:rollback'].invoke
    Rake::Task['db:migrate'].reenable
    Rake::Task['db:migrate'].invoke
    Rake::Task['db:test:prepare'].invoke
    Object.send(:remove_const, :Rails) # Hack to trick annotate into loading the model files
    Rake::Task['annotate_models'].invoke
  end
end
