class RedisAdapter
  TOGGLES_HASH_KEY = 'chirrin-chirrion-toggles'
  ACTIVE_STATUS = 'a'
  INACTIVE_STATUS = 'i'
  attr_reader :redis_database
  private :redis_database

  def initialize(redis_database)
    @redis_database = redis_database
  end

  # Adds a toggle to the database:
  #
  # redis_adapter.add_toggle('my_active_feature', 'a')
  # redis_adapter.add_toggle('my_inactive_feature', 'i')
  # redis_adapter.add_toggle('my_inactive_feature')
  #
  def add_toggle(toggle_name, status = INACTIVE_STATUS)
    redis_database.hset(TOGGLES_HASH_KEY, toggle_name, status)

    true
  end

  # Removes a toggle from the database:
  #
  # redis_adapter.remove_toggle('my_active_feature')
  # redis_adapter.remove_toggle('my_inactive_feature')
  #
  def remove_toggle(toggle_name)
    redis_database.hdel(TOGGLES_HASH_KEY, toggle_name)

    true
  end

  # Makes a toggle, existent or not, active:
  #
  # redis_adapter.activate('my_feature')
  #
  def activate(toggle_name)
    add_toggle(toggle_name, ACTIVE_STATUS)
  end

  # Makes a toggle, existent or not, iactive:
  #
  # redis_adapter.inactivate('my_feature')
  #
  def inactivate(toggle_name)
    add_toggle(toggle_name, INACTIVE_STATUS)
  end

  def active?(toggle_name)
    redis_database.hget(TOGGLES_HASH_KEY, toggle_name).eql?('a')
  end

  def inactive?(toggle_name)
    !active?(toggle_name)
  end
end
