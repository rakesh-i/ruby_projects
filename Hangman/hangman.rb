#!/usr/bin/env ruby
#frozen_string_literal: true

class Hangman
  def initialize
    file_path_raw = "Hangman/google-10000-english-no-swears.txt"
    file_path_modified = "Hangman/modified.txt"
    modify(file_path_raw,file_path_modified)
    rand_word = randomWord(file_path_modified).split("")
    play(rand_word)
  end

  def modify(file_path_raw, file_path_modified)
    file1 = File.open(file_path_raw,'r')
    if File.exist?(file_path_modified)==false||File.foreach(file_path_modified).count==0
      file2 = File.open(file_path_modified, 'a')
      file1.each_line do |line|
        word = line.strip
        if word.length>4&&word.length<13
          file2.puts(word)
        end
      end
      file2.rewind
    end
  end

  def randomWord(file_path_modified)
    total_lines = File.foreach(file_path_modified).count
    random_line = rand(1..total_lines)
    random_word = nil
    File.open(file_path_modified, "r") do |file|
      file.each_line.with_index do|line, index|
        if index+1==random_line
          random_word = line.chomp
          break
        end
      end
    end
    random_word
  end

  def play(rand_word)
    system("clear")
    word_dup = rand_word.dup
    word_lenght = word_dup.length
    temp = Array.new(word_lenght)
    puts "Six strikes and you lose"
    for i in 1..word_lenght
      print "_ "
      temp[i-1] = '_'
    end
    puts ""
    strike = 0
    while strike<6
      guess = gets.chomp
      system("clear")
      puts "Six strikes and you lose"
      flag = 0
      for i in 0..word_lenght-1
        if guess == word_dup[i]
          flag = 1
          temp[i] = guess
        end
      end
      for i in 1..word_lenght
        print "#{temp[i-1]} "
      end
      puts ""
      if flag==0
        strike +=1
      end
      draw(strike)
      if temp==word_dup
        break
      end
    end
    puts word_dup.join
  end

  def draw(strike)
    case strike
    when 0
      puts "  +---+"
      puts "  |   |"
      puts "      |"
      puts "      |"
      puts "      |"
      puts "      |"
      puts "========"
    when 1
      puts "  +---+"
      puts "  |   |"
      puts "  O   |"
      puts "      |"
      puts "      |"
      puts "      |"
      puts "========"
    when 2
      puts "  +---+"
      puts "  |   |"
      puts "  O   |"
      puts "  |   |"
      puts "      |"
      puts "      |"
      puts "========"
    when 3
      puts "  +---+"
      puts "  |   |"
      puts "  O   |"
      puts " /|   |"
      puts "      |"
      puts "      |"
      puts "========"
    when 4
      puts "  +---+"
      puts "  |   |"
      puts "  O   |"
      puts " /|\\  |"
      puts "      |"
      puts "      |"
      puts "========"
    when 5
      puts "  +---+"
      puts "  |   |"
      puts "  O   |"
      puts " /|\\  |"
      puts " /    |"
      puts "      |"
      puts "========"
    when 6
      puts "  +---+"
      puts "  |   |"
      puts "  O   |"
      puts " /|\\  |"
      puts " / \\  |"
      puts "      |"
      puts "========"
    end
  end

end

game = Hangman.new
