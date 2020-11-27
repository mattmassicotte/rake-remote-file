require 'test_helper'
require 'rake'

class DSLTest < Minitest::Test
  include RakeRemoteFile::DSL

  def test_remote_file_task
    url = "https://s3.amazonaws.com/my_bucket/a/file/path"
    
    remote_file 'local_file', url
    
    task = Rake::Task['local_file']
    assert !task.nil?
    assert_equal 'local_file', task.name
  end
end
