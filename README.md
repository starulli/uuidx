<h1 align="center">uuidx</h1>
<p align="center">Fast Ruby implementations of UUID versions 4, 6, 7, and 8 🪪</p> 

---

## What's in the box?

✅ Simple usage documentation written to get started fast. [30 seconds and you're off.](#usage)

📚 API documentation for the library. [Read the docs.](https://tinychameleon.github.io/uuidx/)

⚡ A reasonably fast, zero dependency implementation of the new UUID standards.

🤖 RBS types for your type checking wants. [Typed goodness.](./sig)

💎 Tests against Ruby 2.7, 3.0, 3.1, and 3.2.

🔒 MFA protection on gem owners.

---

## Installation

### Using Bundler

Run `bundle add uuidx` to update your `Gemfile` and install the gem. You may
also add the gem to your `Gemfile` manually and then run `bundle install`.

### Manual

Use `gem install uuidx` to install the gem from [RubyGems](https://rubygems.org).

## Usage

To get started using the default generators for UUID v4, v6, or v7 `require`
the library and call the associated method.

```ruby
require "uuidx"

Uuid.v4 # => "2b54639d-e43e-489f-9c64-30ecdcac3c95"
Uuid.v6 # => "1eda9761-9f6f-6414-8c5f-fd61f1239907"
Uuid.v7 # => "01863d24-6d1e-78ba-92ee-6e80c79c4e28"
```

These methods all use default generators and are thread-safe. However, if you
are using child processes (like Puma's clustered mode) you should also reset
the generators you are using when each child process starts.

```ruby
# Puma example that resets all default generators.
on_worker_boot do
  Uuid.reset_v4!
  Uuid.reset_v6!
  Uuid.reset_v7!
end
```

This way you will get thread-safe state access per process without requiring
IPC.

### Advanced Usage
If you require multiple generators you can drop below the simple API presented
above to create generators directly.

```ruby
v6 = Uuid::Version6.new
v6.generate # => "1eda9adc-2ed9-629e-9a02-4d2ccc87c569"
```

These generators are lock-free, so if you use them to obtain higher throughput
keep in mind that you must ensure they are never shared between threads.

For typical MRI Ruby workloads using multi-process worker strategies state will
be cloned and modified using copy-on-write and the thread safety provided by
the simple API is adequate.

#### UUID v8
UUID v8 is a special case of advanced usage that always requires you to build
a generator directly. It takes a single parameter to its constructor which must
be the class name of your UUID v8 definition.

```ruby
v8 = Uuid::Version8.new(MyV8Definition)
v8.generate # => "..."
```

The definition class should implement the methods `custom_a`, `custom_b`, and
`custom_c` in order to fill out the UUID data [according to the draft](https://www.ietf.org/archive/id/draft-ietf-uuidrev-rfc4122bis-01.html#name-uuid-version-8).

See the [documentation for Version8](https://tinychameleon.github.io/uuidx/Uuid/Version8.html) for precise details.

### Clock Resolution
If you have need to verify the clock resolution for UUID v6 or v7 you can call
the `verify_clock_resolution!` method on either class. A `ClockResolutionError`
is raised if the system has insufficient precision.

```ruby
begin
  Uuid::Version6.verify_clock_resolution! # or Uuid::Version7
rescue Uuid::ClockResolutionError
  # ...
end
```

The API documentation has details about what the clock resolution must be for
each of the UUID versions. See the
[Version 6](https://tinychameleon.github.io/uuidx/Uuid/Version6.html) and
[Version 7](https://tinychameleon.github.io/uuidx/Uuid/Version7.html)
documentation for details.

### A Note on Clock Timings
The API documentation contains specific details around how the implementations
deal with clock drift. See the
[Uuid](https://tinychameleon.github.io/uuidx/Uuid.html),
[Version 6](https://tinychameleon.github.io/uuidx/Uuid/Version6.html), and
[Version 7](https://tinychameleon.github.io/uuidx/Uuid/Version7.html)
documentation for more information.

## Performance
This performance data was captured using `benchmark/ips`. It uses the following
Ruby version

    ruby 3.2.0 (2022-12-25 revision a528908271) [arm64-darwin22]

and is run on a Macbook Pro with an M1 Max CPU.

    ❯ bundle exec ruby test/benchmarks/simple_api.rb
    Warming up --------------------------------------
                  stdlib    62.055k i/100ms
                   uuid4   108.502k i/100ms
                   uuid6   114.782k i/100ms
                   uuid7   104.576k i/100ms
    Calculating -------------------------------------
                  stdlib    628.493k (± 0.2%) i/s -      3.165M in   5.035575s
                   uuid4      1.084M (± 1.1%) i/s -      5.425M in   5.005244s
                   uuid6      1.149M (± 0.2%) i/s -      5.854M in   5.096869s
                   uuid7      1.052M (± 0.8%) i/s -      5.333M in   5.071797s
    
    Comparison:
                   uuid6:  1148528.3 i/s
                   uuid4:  1084023.7 i/s - 1.06x  (± 0.00) slower
                   uuid7:  1051645.3 i/s - 1.09x  (± 0.00) slower
                  stdlib:   628492.6 i/s - 1.83x  (± 0.00) slower

As reported, the `stdlib` version of `SecureRandom.uuid` is at least 1.70x
slower than the simple API implementation of UUID v4.

These timings are good enough that they shouldn't get in the way of any web
frameworks.

## Development
After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake test` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To run tests across all supported Ruby versions on Debian and Alpine Linux run
`make test-all`. To run a specific version use `make test-[version]`;
for example, `make test-3.2.0`.

To install this gem onto your local machine, run `bundle exec rake install`.

To release a new version:

1. ensure the documentation and changelog are ready
2. run `bundle exec rake rdoc` to generate the new documentation and commit it
3. update the version number in `lib/uuid/gem_version.rb`
4. run `bundle install` to update the `Gemfile.lock`
5. create a release commit with the version updates
6. run `bundle exec rake release` to tag and push the version to RubyGems

## Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/tinychameleon/uuidx.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
