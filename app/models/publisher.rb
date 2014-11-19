class Publisher

  def self.publish(id, progress)
    puts "#{id.to_s}: #{progress.to_s}%"
    Redis.current.hset("progress", id.to_s, progress.to_i)
  end

end
