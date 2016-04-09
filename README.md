# Chirrin Chirrion
Chirrin Chirrion is a gem to manage feature toggle, allowing developers to easily change the software behavior by showing/hiding new features and fixes.

## Inspiration
The gem name was inspired by a funny Chapolim Colorado [episode](https://youtu.be/dzgrex7g_zY) called 'Chirrin Chirrion del Diablo', where there was a magic wand that created new things if its bearer used the magic word 'chirrin', and those things were destroyed with the word 'chirrion'.

## Install

   gem install chirrin-chirrion

## How to use

### Configuration

```ruby
require 'chirrin-chirrion'
redis_connection = Redis.new
redis_adapter = ChirrinChirrion::DatabaseAdapters::RedisAdapter.new(redis_connection)
ChirrinChirrion.config(database_adapter: redis_adapter)
```

### Listing toggles

```ruby
ChirrinChirrion.list
# => [#<OpenStruct description="What the toggle does.", active=true, name="toggle_name">]
```

### Adding a toggle
```ruby
ChirrinChirrion.add_toggle('new_user_register_validation', {active: true, description: 'When this is active, gender, age and phone number are not required'})
```

### Removing a toggle
```ruby
ChirrinChirrion.remove_toggle('new_user_register_validation')
```

### Making a toggle active
```ruby
ChirrinChirrion.chirrin!('new_user_register_validation')
```

### Making a toggle inactive
```ruby
ChirrinChirrion.chirrion!('new_user_register_validation')
```

### Using a toggle with if else
```ruby
if ChirrinChirrion.chirrin?('new_user_register_validation')
  # new busines rules
else
  # old busines rules
end
```

### Using with procs and default values
```ruby
chirrin_behavior = lambda do
  # do a lot of things
  { result: 'of things' }
end

chirrion_behavior = { result: 'old static result' }

ChirrinChirrion.chirrin_chirrion('my_toggle', chirrin_behavior, chirrion_behavior)
```
