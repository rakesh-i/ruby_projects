#!/usr/bin/env ruby
#frozen_string_literal: true

require 'csv'

class Hangman
  def initialize
    system("clear")
    file_path_raw = "Hangman/google-10000-english-no-swears.txt"
    file_path_modified = "Hangman/modified.txt"
    modify(file_path_raw,file_path_modified)
    rand_word, temp, strike= loadSave()
    play(rand_word, temp, strike)
  end

  def loadSave
    savefile = CSV.open("Hangman/save.csv", "r", headers:true, header_converters: :symbol)
    data = savefile.read
    puts "Sl  Date        Progress             Strikes"
    puts "============================================"
    puts "0     -----------NEW GAME-------------"
    data.each.with_index do |row, index|
      prog = row[:progress].to_s
      n = prog.length
      new_progress = ""
      for i in 0..12
        if(i<n)
          new_progress += "#{prog[i]} "
        else
          new_progress +="  "
        end
      end
      puts "#{index+1}   #{row[:date]}   #{new_progress}#{row[:strike]}"
    end
    puts "============================================"
    print "Enter the number curresponding to the saves to play: "
    choice = gets.chomp.to_i
    if choice==0
      word = randomWord("Hangman/modified.txt")
      word_lenght = word.length
      temp = Array.new(word_lenght)
      for i in 1..word_lenght
        temp[i-1] = '_'
      end
      return word, temp, 0
    end
    return data[choice-1][:randomword], data[choice-1][:progress].split(""), data[choice-1][:strike].to_i
  end

  def saveGame(progress, word, strike)
    progress = progress.join
    date = Time.now.strftime("%m/%d/%Y")
    data_to_append = {date:date, randomWord:word, progress:progress, strike:strike}
    CSV.open("Hangman/save.csv", "a", headers:true, header_converters: :symbol) do |csv|
      csv<<data_to_append.values
    end
    puts "Press 1 to return"
    until gets.chomp=="1"
      puts "Press 1 to return"
    end
    play(word, progress.split(""), strike.to_i)
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

  def play(rand_word, temp, strike)
    system("clear")
    word_dup = rand_word.dup
    word_lenght = word_dup.length
    #puts rand_word
    puts "Press 1 to save the progress"
    for i in 1..word_lenght
      print "#{temp[i-1]} "
    end
    puts ""
    draw(strike)

    while strike<6
      guess = gets.chomp.downcase
      if guess== "1"
        saveGame(temp, rand_word, strike)
        exit
      end
      system("clear")
      puts "Press 1 to save the progress"
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
      if temp.join==word_dup
        break
      end
    end
    puts word_dup
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
