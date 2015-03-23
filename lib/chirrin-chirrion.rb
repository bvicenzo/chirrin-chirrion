require "chirrin-chirrion/version"
require "chirrin-chirrion/database_adapters/redis_adapter"

module ChirrinChirrion
  def self.config(options)
    @database_adapter = options[:database_adapter]
  end

  def self.database_adapter
    @database_adapter
  end

  def self.add_toggle(toggle_name)
    database_adapter.add_toggle(toggle_name)
  end

  def self.remove_toggle(toggle_name)
    database_adapter.remove_toggle(toggle_name)
  end

  def self.chirrin?(toggle_name)
    database_adapter.exists?(toggle_name)
  end

  def self.chirrion?(toggle_name)
    !chirrin?(toggle_name)
  end

  def self.chirrin_chirrion(toggle_name, for_chirrin, for_chirrion)
    if chirrin?(toggle_name)
      for_chirrin.respond_to?(:call) ? for_chirrin.call : for_chirrin
    else
      for_chirrion.respond_to?(:call) ? for_chirrion.call : for_chirrion
    end
  end

  private_class_method :database_adapter
end
