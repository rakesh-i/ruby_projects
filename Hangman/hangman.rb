#!/usr/bin/env ruby
#frozen_string_literal: true

class Hangman
  def initialize
    file_path_raw = "Hangman/google-10000-english-no-swears.txt"
    file_path_modified = "Hangman/modified.txt"
    modify(file_path_raw,file_path_modified)
    @@rand_word = randomWord(file_path_modified)
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

end

game = Hangman.new
