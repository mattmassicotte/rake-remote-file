require 'aws-sdk-s3'
require 'mime-types'

module RakeRemoteFile
  class Task < Rake::FileTask
    attr_accessor :source_file

    def initialize(task_name, app)
      @s3 = Aws::S3::Resource.new
      super(task_name, app)
    end

    def needed?
      @application.options.build_all || out_of_date?(timestamp)
    end

    def timestamp
      s3_object.last_modified
    rescue StandardError
      # if we cannot read last_modified, assume the file
      # is extremely old
      Rake::EARLY
    end

    def content_hash
      s3_object.etag
    end

    def s3_object
      @s3.bucket(bucket_name).object(remote_path)
    end

    def bucket_name
      name[%r{s3\.amazonaws\.com/(.*?)/(.*)}, 1]
    end

    def remote_path
      name[%r{s3\.amazonaws\.com/(.*?)/(.*)}, 2]
    end

    def extname
      File.extname(source_file)
    end

    def mime_type
      ext = extname.strip.downcase[1..-1]
      MIME::Types.type_for(ext).first.to_s
    end

    def upload(options = {})
      options[:content_type] ||= mime_type

      s3_object.upload_file(source_file, options)
    end
  end
end
