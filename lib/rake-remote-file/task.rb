require 'aws-sdk-s3'
require 'mime-types'

module RakeRemoteFile
  class Task < Rake::FileTask
    attr_accessor :source_file
    
    def needed?
      @application.options.build_all || out_of_date?(timestamp)
    end
    
    def timestamp
      s3_object.last_modified
    rescue
      Rake::EARLY
    end
    
    def s3_object
      s3 = Aws::S3::Resource.new()
      
      s3.bucket(bucket_name).object(remote_path)
    end
    
    def bucket_name
      name[/s3\.amazonaws\.com\/(.*?)\/(.*)/, 1]
    end
    
    def remote_path
      name[/s3\.amazonaws\.com\/(.*?)\/(.*)/, 2]
    end
    
    def extname
      File.extname(source_file)
    end
    
    def mime_type
      ext = extname.strip.downcase[1..-1]
      MIME::Types.type_for(ext).first.to_s
    end
    
    def upload(options={})
      options[:content_type] ||= mime_type
      
      puts("actually uploading")
      s3_object.upload_file(source_file, options)
    end
  end
end
