module RakeRemoteFile
  module DSL
    include Rake::DSL

    def remote_file(src_file, *args, &block)
      file src_file

      remote_task = RakeRemoteFile::Task.define_task(*args, &block)

      remote_task.enhance([src_file])

      remote_task.source_file = src_file

      remote_task.enhance do
        remote_task.upload
      end

      remote_task
    end
  end
end

extend RakeRemoteFile::DSL
