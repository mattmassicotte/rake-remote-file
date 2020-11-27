require 'test_helper'

class TaskTest < Minitest::Test

  def test_s3_url_parse
    url = "https://s3.amazonaws.com/my_bucket/a/file/path"
    task = RakeRemoteFile::Task.new(url, Rake.application)
    
    assert_equal url, task.name
    assert_equal "my_bucket", task.bucket_name
    assert_equal "a/file/path", task.remote_path
  end

end
