require 'ostruct'
require 'time'

module ChirrinChirrion
  module DatabaseAdapters
    class RedisAdapter
      TOGGLES_HASH_KEY = 'chirrin-chirrion-toggles'
      attr_reader :redis_database
      private :redis_database

      def initialize(redis_database)
        @redis_database = redis_database
      end

      # Adds a toggle to the database:
      #
      # redis_adapter.add_toggle('my_active_feature', { active: true, description: 'What other people must know to understand what this toggle activates' })
      # redis_adapter.add_toggle('my_inactive_feature', { description: 'What other people must know to understand what this toggle activates' })
      # redis_adapter.add_toggle('my_inactive_feature')
      #
      def add_toggle(toggle_name, toggle_info = {})
        toggle_info[:active] ||= false
        redis_database.hset(TOGGLES_HASH_KEY, toggle_name, toggle_info.to_json)

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
      # redis_adapter.activate!('my_feature')
      #
      def activate!(toggle_name)
        toggle_info = get_toggle_info(toggle_name)
        raise ChirrinChirrion::Errors::ToggleNotFound, "The toggle #{toggle_name} was not found" unless toggle_info
        toggle_info['active'] = true

        redis_database.hset(TOGGLES_HASH_KEY, toggle_name, toggle_info.to_json)

        true
      end

      # Makes a toggle, existent or not, iactive:
      #
      # redis_adapter.inactivate!('my_feature')
      #
      def inactivate!(toggle_name)
        toggle_info = get_toggle_info(toggle_name)
        raise ChirrinChirrion::Errors::ToggleNotFound, "The toggle #{toggle_name} was not found" unless toggle_info
        toggle_info['active'] = false

        redis_database.hset(TOGGLES_HASH_KEY, toggle_name, toggle_info.to_json)

        true
      end

      def active?(toggle_name)
        toggle_info = get_toggle_info(toggle_name)
        return false unless toggle_info

        activate_scheduled_toggle(toggle_name, toggle_info)

        toggle_info['active'].eql?(true)
      end

      def inactive?(toggle_name)
        !active?(toggle_name)
      end

      def list
        toggles = redis_database.hgetall(TOGGLES_HASH_KEY)

        toggles.map do |toggle_name, toggle_info|
          toggle_details = JSON.parse(toggle_info).merge('name' => toggle_name)

          OpenStruct.new(toggle_details)
        end
      end

      private

      def get_toggle_info(toggle_name)
        toggle_info = redis_database.hget(TOGGLES_HASH_KEY, toggle_name)
        return nil unless toggle_info

        JSON.parse(toggle_info)
      end

      def activate_scheduled_toggle(toggle_name, toggle_info)
        valid_after = toggle_info['valid_after']
        return unless valid_after

        if Time.parse(valid_after) <= Time.now
          toggle_info['active'] = true
          toggle_info.delete('valid_after')

          redis_database.hset(TOGGLES_HASH_KEY, toggle_name, toggle_info.to_json)
        end
      end
    end
  end
end
