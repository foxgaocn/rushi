rushi
=====

Convert javascript JSON data into a Ruby OpenStruct with ruby naming convention


## Installation

Add this line to your application's Gemfile:

    gem 'rushi'

Or install it yourself as:

    $ gem install rushi

## Usage

1. Convert simple json:
    os = Rushi::RushiObject.objectify('{"foo1":"bar1", "foo2":true }
    os.foo1 == "bar1"
    os.foo2 = true
2. Convert array:
    array = Rushi::RushiObject.objectify('[{"foo1":"bar1"}, {"foo2":true}]')
    array[0].foo1 == "bar1"
    array[1].foo2 == true
3. Create ruby convention
    os = Rushi::RushiObject.objectify('{"isActive":true, "UID":"1234", "hasHTML":false }
    os.is_active == true
    os.uid == "1234"
    os.has_html == false

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
