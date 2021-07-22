# SearchEDU

An exercise demonstrating knowledge of consuming an published API, and how to display a very basic page with a search box and a map with markers for hits.

### Requirements and Setu

This was written to run on Ruby 2.7.4.

1. `cp .env.sample .env` and populate API Keys
1. `bundle install`
1. `bin/rails s`


### CollegeScorecard

This POR model wraps the College Scorecard API using Faraday. It is a bit over engineered for the requirements of this exercise, but since I'm interested in backend development and this is exercise feels more designed to showcase frontend skills, I built this wrapper out a bit more than needed.

Example usage:

```ruby
# Single page results using defaults
one_page_schools = CollegeScorecard.schools.search({ 'school.name' => 'poly' })

# Or iterate over pages of results
all_schools = []
CollegeScorecard.schools.search({ 'school.name' => 'poly' }) { |schools| all_schools += schools }
```


### Additional Notes

- Only requesting 50 schools at a time, because HTTP code 500 responses happened several times when trying to send a `per_page=100` despite documentation (and intermittent successes)
- I have more experience with RSpec than Minitest. I have fundamental dislike of the RSpec DSL, so I thought I'd try Minitest for this exercise.
- When I set out to complete this excercise, I had planned to write a task that would populate a local database and demonstrate my Rails backend modeling knowledge, but in the end decided to submit this version. There is a work in progress on the `local-cache-schools` branch.
