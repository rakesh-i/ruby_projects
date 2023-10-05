#!/usr/bin/env ruby
# frozen_string_literal: true

require 'csv'

class Hangman
  def initialize
    system('clear')
    @@file_path_raw = 'google-10000-english-no-swears.txt'
    @@file_path_modified = 'modified.txt'
    modify
    rand_word, temp, strike = load_save
    play(rand_word, temp, strike)
  end

  def load_save
    savefile = CSV.open('save.csv', 'r', headers: true, header_converters: :symbol)
    data = savefile.read
    puts 'Sl  Date        Progress             Strikes'
    puts '============================================'
    puts '0     -----------NEW GAME-------------'
    data.each.with_index do |row, index|
      prog = row[:progress].to_s
      n = prog.length
      new_progress = ''
      13.times do |i|
        new_progress += if i < n
                          "#{prog[i]} "
                        else
                          '  '
                        end
      end
      puts "#{index + 1}   #{row[:date]}   #{new_progress}#{row[:strike]}"
    end
    puts '============================================'
    print 'Enter the number curresponding to the saves to play: '
    choice = gets.chomp.to_i
    if choice.zero?
      word = random_word
      word_lenght = word.length
      temp = Array.new(word_lenght)
      (1..word_lenght).each do |i|
        temp[i - 1] = '_'
      end
      return word, temp, 0
    end
    [data[choice - 1][:random_word], data[choice - 1][:progress].split(''), data[choice - 1][:strike].to_i]
  end

  def save_game(progress, word, strike)
    progress = progress.join
    date = Time.now.strftime('%m/%d/%Y')
    data_to_append = { date: date, random_word: word, progress: progress, strike: strike }
    CSV.open('save.csv', 'a', headers: true, header_converters: :symbol) do |csv|
      csv << data_to_append.values
    end
    puts 'Progress Saved'
    puts 'Press 1 to return'
    puts 'Press 1 to return' until gets.chomp == '1'
    play(word, progress.split(''), strike.to_i)
  end

  def modify
    file1 = File.open(@@file_path_raw, 'r')
    return unless File.exist?(@@file_path_modified) == false || File.foreach(@@file_path_modified).count.zero?

    file2 = File.open(@@file_path_modified, 'a')
    file1.each_line do |line|
      word = line.strip
      file2.puts(word) if word.length > 4 && word.length < 13
    end
    file2.rewind
  end

  def random_word
    total_lines = File.foreach(@@file_path_modified).count
    random_line = rand(1..total_lines)
    random_word = nil
    File.open(@@file_path_modified, 'r') do |file|
      file.each_line.with_index do |line, index|
        if index + 1 == random_line
          random_word = line.chomp
          break
        end
      end
    end
    random_word
  end

  def play(rand_word, temp, strike)
    system('clear')
    word_dup = rand_word.dup
    word_lenght = word_dup.length
    # puts rand_word
    puts 'Press 1 to save the progress'
    (1..word_lenght).each do |i|
      print "#{temp[i - 1]} "
    end
    puts ''
    draw(strike)

    while strike < 6
      guess = gets.chomp.downcase
      if guess == '1'
        save_game(temp, rand_word, strike)
        exit
      end
      system('clear')
      puts 'Press 1 to save the progress'
      flag = 0
      (0..word_lenght - 1).each do |i|
        if guess == word_dup[i]
          flag = 1
          temp[i] = guess
        end
      end
      (1..word_lenght).each do |i|
        print "#{temp[i - 1]} "
      end
      puts ''
      strike += 1 if flag.zero?
      draw(strike)
      break if temp.join == word_dup
    end
    puts word_dup
  end

  def draw(strike)
    case strike
    when 0
      puts '  +---+'
      puts '  |   |'
      puts '      |'
      puts '      |'
      puts '      |'
      puts '      |'
      puts '========'
    when 1
      puts '  +---+'
      puts '  |   |'
      puts '  O   |'
      puts '      |'
      puts '      |'
      puts '      |'
      puts '========'
    when 2
      puts '  +---+'
      puts '  |   |'
      puts '  O   |'
      puts '  |   |'
      puts '      |'
      puts '      |'
      puts '========'
    when 3
      puts '  +---+'
      puts '  |   |'
      puts '  O   |'
      puts ' /|   |'
      puts '      |'
      puts '      |'
      puts '========'
    when 4
      puts '  +---+'
      puts '  |   |'
      puts '  O   |'
      puts ' /|\\  |'
      puts '      |'
      puts '      |'
      puts '========'
    when 5
      puts '  +---+'
      puts '  |   |'
      puts '  O   |'
      puts ' /|\\  |'
      puts ' /    |'
      puts '      |'
      puts '========'
    when 6
      puts '  +---+'
      puts '  |   |'
      puts '  O   |'
      puts ' /|\\  |'
      puts ' / \\  |'
      puts '      |'
      puts '========'
    end
  end
end

Hangman.new
