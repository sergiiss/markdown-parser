require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.libs << 'lib/markdown-parser'
  t.test_files = FileList['test/**/*_test.rb']
end