#!/usr/bin/env ruby

# frozen_string_literal: true

require "erb"
require "optparse"
require "pathname"

ROOT_PATH = Pathname.new(__dir__).parent

options = {
  force: false,
  year: Time.now.year
}

OptionParser.new do |opts|
  opts.banner = "Usage: create-files.rb [options]"

  opts.on("-d", "--day DAY", Integer, "The day of the puzzle") do |day|
    options[:day] = day
  end

  opts.on("-y", "--year [YEAR]", Integer, "The year of the puzzle (default: current year)") do |year|
    options[:year] = year
  end

  opts.on("-f", "--force", "Force the creation of the files") do |force|
    options[:force] = force
  end
end.parse!

raise "The day number is required to create files" if options[:day].nil?

day = format("%02d", options[:day].to_i)
year = options[:year]

PUZZLE_DIR = ROOT_PATH / "lib/puzzles/#{year}/day#{day}"
TEST_DIR = ROOT_PATH / "test/puzzles/#{year}/day#{day}"
PUZZLE_SIG_DIR = ROOT_PATH / "sig/puzzles/#{year}"
TEST_SIG_DIR = ROOT_PATH / "sig/test/puzzles/#{year}"

files_with_templates = {
  PUZZLE_DIR / "day#{day}.rb" => "templates/day.rb.erb",
  PUZZLE_DIR / "part1.rb" => "templates/part1.rb.erb",
  PUZZLE_DIR / "part2.rb" => "templates/part2.rb.erb",
  PUZZLE_DIR / "README.md" => "templates/README.md.erb",
  PUZZLE_DIR / "input.txt" => "templates/input.txt.erb",
  TEST_DIR / "day#{day}_test.rb" => "templates/day_test.rb.erb",
  TEST_DIR / "test_data.txt" => "templates/test_data.txt.erb",
  PUZZLE_SIG_DIR / "day#{day}.rbs" => "templates/day.rbs.erb",
  TEST_SIG_DIR / "day#{day}_test.rbs" => "templates/day_test.rbs.erb"
}

puts "Creating files for puzzle: Day #{day} (#{year})"

files_with_templates.each do |file, template_file|
  if file.exist? && !options[:force]
    puts "  - Skipping #{file.relative_path_from(ROOT_PATH)} (already exists)."
    next
  end

  print "  - Creating #{file.relative_path_from(ROOT_PATH)}..."
  file.dirname.mkpath
  template = ERB.new((ROOT_PATH / template_file).read)
  file.write(template.result(binding))
  puts " done."
end

puts "\nGo to https://adventofcode.com/#{year}/day/#{day.to_i} for the puzzle description."
