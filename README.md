# DeepTry

Welcome to deep_try. 

I will add a new method to any object, that works like try(:my_method), but with an arbitrary long list of methods.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'deep_try'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install deep_try

## Usage

With any object use deep_try as follows

```ruby
    object.deep_try(:class, :name, :to_s) # replace object with your object
```
    
This is identical to calling

```ruby
    object.class.name.to_s
```
    
but without failing. If any of the methods return nil or don't exist, then nil is returned as if

```ruby
    object&.class&.name&.to_s
```
    
would have been called.

If you have an array of methods in correct order, let's say

```ruby
    methods = ["method_1", "method_2", "method_3"]
```
    
then use deep_try

```ruby
    object.deep_try(*methods)
```

which has the same effect like

```ruby
    object.method_1&.method_2&.method_3
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/HugoHasenbein/deep_try. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/HugoHasenbein/deep_try/blob/master/CODE_OF_CONDUCT.md).

## Code of Conduct

Everyone interacting in the DeepTry project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/HugoHasenbein/deep_try/blob/master/CODE_OF_CONDUCT.md).
