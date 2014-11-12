class Path
  require "fileutils"

  def self.create_paths(outputs)
    outputs.each do |output|
      path = File.dirname(output[:url])
      Rails.logger.info "Creating path: #{path}"
      FileUtils::mkdir_p path
    end
  end

end
