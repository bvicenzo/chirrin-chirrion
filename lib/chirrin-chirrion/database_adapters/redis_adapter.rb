class RedisAdapter
  attr_reader :redis_database
  private :redis_database

  def initialize(redis_database)
    @redis_database = redis_database
  end

  def add_toggle(toggle_name)
    redis_database.set(toggle_name, 't').eql?('OK')
  end

  def remove_toggle(toggle_name)
    redis_database.del(toggle_name).eql?(1)
  end

  def exists?(toggle_name)
    redis_database.get(toggle_name).eql?('t')
  end
end
