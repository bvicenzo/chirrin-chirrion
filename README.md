# Chirrin Chirrion
Chirrin Chirrion is a gem to, easily, change the software behavior for new features, fixes, etc.

## Inspiration
The gem name was inspired in a funny Chapolim Colorado [episode](https://youtu.be/dzgrex7g_zY) called 'Chirrin Chirrion del Diablo'.
Where there is a magic object which the the key word 'chirrin' gives a new thing and 'chirrion' takes it away.

## Intall

   gem install chirrin-chirrion

## How to use

### Configuration

```ruby
require 'chirrin-chirrion'
redis_connection = Redis.new
redis_adapter    = RedisAdapter.new(redis_connection)
ChirrinChirrion.config(database_adapter: redis_adapter)
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
ChirrinChirrion.chirrin('new_user_register_validation')
```

### Making a toggle inactive
```ruby
ChirrinChirrion.chirrion('new_user_register_validation')
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
  {result: 'of things'}
end

chirrion_behavior = {result: 'old static result'}

ChirrinChirrion.chirrin_chirrion('my_toggle', chirrin_behavior, chirrion_behavior)
```
