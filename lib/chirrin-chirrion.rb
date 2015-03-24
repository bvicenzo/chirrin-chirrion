require "chirrin-chirrion/version"
require "chirrin-chirrion/database_adapters/redis_adapter"

module ChirrinChirrion

  # Defines the configuration for Chirrin Chirrion.
  # The config are:
  #  - database_adapter, an adapter which wrap the database management to provide the correct service
  #
  # redis_connection = Redis.new
  # redis_adapter    = RedisAdapter.new(redis_connection)
  # ChirrinChirrion.config(database_adapter: redis_adapter)
  #
  def self.config(options)
    @database_adapter = options[:database_adapter]
  end

  # Private mehtod which returns the Chirrin Chirrion config
  #
  def self.database_adapter
    @database_adapter
  end

  # Adds a toggle to the database
  #
  # ChirrinChirrion.add_toggle('my_active_feature')
  # ChirrinChirrion.add_toggle('my_inactive_feature')
  #
  def self.add_toggle(toggle_name)
    database_adapter.add_toggle(toggle_name)
  end

  # Removes a toggle from the database
  #
  # ChirrinChirrion.remove_toggle('my_active_feature')
  # ChirrinChirrion.remove_toggle('my_inactive_feature')
  #
  def self.remove_toggle(toggle_name)
    database_adapter.remove_toggle(toggle_name)
  end

  # Makes a toggle active
  #
  # ChirrinChirrion.chirrin('my_inactive_feature')
  # ChirrinChirrion.chirrin?('my_inactive_feature') #=> true
  #
  def self.chirrin(toggle_name)
    database_adapter.activate(toggle_name)
  end

  # Makes a toggle inactive
  #
  # ChirrinChirrion.chirrion('my_active_feature')
  # ChirrinChirrion.chirrion?('my_active_feature') #=> false
  #
  def self.chirrion(toggle_name)
    database_adapter.inactivate(toggle_name)
  end

  # Checks if a toggle active
  #
  # ChirrinChirrion.chirrin?('my_active_feature') #=> true
  # ChirrinChirrion.chirrin?('my_inactive_feature') #=> false
  #
  def self.chirrin?(toggle_name)
    database_adapter.active?(toggle_name)
  end

  # Checks if a toggle inactive
  #
  # ChirrinChirrion.chirrion?('my_active_feature') #=> false
  # ChirrinChirrion.chirrion?('my_inactive_feature') #=> true
  #
  def self.chirrion?(toggle_name)
    database_adapter.inactive?(toggle_name)
  end

  # Executes determinated action if the toggle chirrin, if not executes another achtion
  #
  # ChirrinChirrion.chirrin('mult_for_2')
  # ten_numbers            = (1..10).to_a
  # actiction_for_chirrin  = lambda { ten_numbers.map{|number| number * 2 } }
  # actiction_for_chirrion = lambda { ten_numbers.map{|number| number * 4 } }
  # ChirrinChirrion.chirrin_chirrion('mult_for_2', action_for_chirrin, action_for_chirrion) #=> [4, 8, 12, 16, 20, 24, 28, 32, 36, 40]
  # ChirrinChirrion.chirrin('mult_for_2')
  # ChirrinChirrion.chirrin_chirrion('mult_for_2', action_for_chirrin, action_for_chirrion) #=> [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]
  #
  def self.chirrin_chirrion(toggle_name, for_chirrin, for_chirrion)
    if chirrin?(toggle_name)
      for_chirrin.respond_to?(:call) ? for_chirrin.call : for_chirrin
    else
      for_chirrion.respond_to?(:call) ? for_chirrion.call : for_chirrion
    end
  end

  private_class_method :database_adapter
end
