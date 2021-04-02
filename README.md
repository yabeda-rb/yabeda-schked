[![Gem Version](https://badge.fury.io/rb/yabeda-schked.svg)](https://badge.fury.io/rb/yabeda-schked)
[![Build Status](https://github.com/yabeda-rb/yabeda-schked/actions/workflows/test.yml/badge.svg)](https://github.com/yabeda-rb/yabeda-schked/actions?query=branch%3Amaster)

# Yabeda::[Schked]

Built-in metrics for monitoring [Schked] recurring jobs out of the box! Part of the [yabeda] suite.

<a href="https://evilmartians.com/?utm_source=yabeda-schked&utm_campaign=project_page">
<img src="https://evilmartians.com/badges/sponsored-by-evil-martians.svg" alt="Sponsored by Evil Martians" width="236" height="54">
</a>

## Installation

```ruby
gem "yabeda-schked"

# Then add monitoring system adapter, e.g.:
# gem "yabeda-prometheus"
```

And then execute:

    $ bundle

**And that is it!** Schked metrics are being collected!

## Metrics

- Total number of executed jobs: `schked_jobs_executed_total` - (the jobs' `name`s and whether their execution was `success`ful)
- Time of job run: `schked_job_execution_runtime` (seconds per job execution, segmented by the jobs' `name`s, and whether their execution was `success`ful)

❗ Notice: Schked jobs without a name specified (with `as` or `name` attribute) will be marked with the name `'none'`, so it's highly recommended to specify unique names for all jobs.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/yabeda-rb/yabeda-schked.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).



[Schked]: https://github.com/bibendi/schked "Framework agnostic Rufus-scheduler wrapper to run recurring jobs"
[yabeda]: https://github.com/yabeda-rb/yabeda
