#!/usr/bin/env ruby
# frozen_string_literal: true

require 'csv'

class Hangman
  def initialize
    system('clear')
    @@file_path_raw = 'google-10000-english-no-swears.txt'
    @@file_path_modified = 'modified.txt'
    @@save_path = 'save.csv'
    delete_previous_saves()
    modify()
    game()
  end

  def game
    begin
      system("clear")
      rand_word, temp, strike = load_save
      #puts rand_word
      play(rand_word, temp, strike)
      puts "Press 'y' to play again and 'n' to exit"
    end while gets.chomp.downcase!='n'
    exit
  end
  def delete_previous_saves
    header = CSV.open(@@save_path, 'r', &:readline)
    CSV.open(@@save_path, 'w') do |csv|
      csv << header
    end
  end
  def load_save
    savefile = CSV.open('save.csv', 'r', headers: true, header_converters: :symbol)
    data = savefile.read
    count = 0
    draw(6)
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
      count+=1
    end
    puts '============================================'
    print 'Enter the number curresponding to the saves to play: '
    choice = gets.chomp.to_i
    until choice<=count||choice<0
      puts "invalid input try again"
      choice = gets.chomp.to_i
    end
    if choice.zero?
      word = random_word
      word_lenght = word.length
      temp = Array.new(word_lenght)
      (1..word_lenght).each do |i|
        temp[i - 1] = '_'
      end
      return word, temp, 0
    end
    return data[choice - 1][:randomword], data[choice - 1][:progress].split(''), data[choice - 1][:strike].to_i
  end

  def save_game(progress, word, strike)
    progress = progress.join
    date = Time.now.strftime('%m/%d/%Y')
    data_to_append = { date: date, randomword: word, progress: progress, strike: strike }
    CSV.open('save.csv', 'a', headers: true, header_converters: :symbol) do |csv|
      csv << data_to_append.values
    end
    puts 'Progress Saved'
    puts 'Press 1 to return'
    puts 'Press 1 to return' until gets.chomp == '1'
    play(word, progress.split(''), strike.to_i)
    game
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
    puts 'Press 1 to save the progress and 2 to exit'
    (1..word_lenght).each do |i|
      print "#{temp[i - 1]} "
    end
    puts ''
    draw(strike)

    while strike < 6
      guess = gets.chomp.downcase
      if guess == '1'
        save_game(temp, rand_word, strike)
        game
      end
      if guess == '2'
        game()
        exit
      end
      system('clear')
      puts 'Press 1 to save the progress and 2 to exit'
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
