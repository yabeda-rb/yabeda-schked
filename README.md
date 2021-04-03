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

To install this gem onto your local machine, run `bundle exec rake install`.

## Releasing

1. Bump version number in `lib/yabeda/schked/version.rb`

   In case of pre-releases keep in mind [rubygems/rubygems#3086](https://github.com/rubygems/rubygems/issues/3086) and check version with command like `Gem::Version.new(Yabeda::Schked::VERSION).to_s`

2. Fill `CHANGELOG.md` with missing changes, add header with version and date.

3. Make a commit:

   ```sh
   git add lib/yabeda/schked/version.rb CHANGELOG.md
   version=$(ruby -r ./lib/yabeda/schked/version.rb -e "puts Gem::Version.new(Yabeda::Schked::VERSION)")
   git commit --message="${version}: " --edit
   ```

4. Create annotated tag:

   ```sh
   git tag v${version} --annotate --message="${version}: " --edit --sign
   ```

5. Fill version name into subject line and (optionally) some description (list of changes will be taken from `CHANGELOG.md` and appended automatically)

6. Push it:

   ```sh
   git push --follow-tags
   ```

7. GitHub Actions will create a new release, build and push gem into [rubygems.org](https://rubygems.org)! You're done!

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/yabeda-rb/yabeda-schked.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).



[Schked]: https://github.com/bibendi/schked "Framework agnostic Rufus-scheduler wrapper to run recurring jobs"
[yabeda]: https://github.com/yabeda-rb/yabeda
