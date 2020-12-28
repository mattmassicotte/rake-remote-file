require 'test_helper'
require 'rake'

class DSLTest < Minitest::Test
  include RakeRemoteFile::DSL

  def setup
    ENV['AWS_REGION'] = 'us-east-1'
    ENV['AWS_ACCESS_KEY_ID'] = 'key'
    ENV['AWS_SECRET_ACCESS_KEY'] = 'secret'
  end

  def test_remote_file_task
    url = "https://s3.amazonaws.com/my_bucket/a/file/path"
    
    remote_file 'local_file', url
    
    task = Rake::Task['local_file']
    assert !task.nil?
    assert_equal 'local_file', task.name
  end
end
