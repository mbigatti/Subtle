#!/usr/bin/ruby

module Status
	INDEX = 1
	TIMESTAMP = 2
	TEXT = 3
	EMPTY = 4
end

# see: http://mentalized.net/journal/2011/04/14/ruby-how-to-check-if-a-string-is-numeric/
class String
  def numeric?
    Float(self) != nil rescue false
  end
end

dictionary = []

Dir["*.srt"].each do |filename|
	puts 'Processing ' + filename
	
	status = Status::INDEX

	File.readlines(filename).each do |line|
		if status == Status::EMPTY
			status = Status::INDEX
		end
		if status == Status::TEXT
			if line.strip.length == 0
				status = Status::EMPTY
			else
				line.split(/\W+/).each do |word|
					word.strip!
				
					if word.length > 2 && !word.numeric?
						word.downcase!
				
						if !dictionary.include?(word)
							dictionary << word
						end
					end
				end
			end
		end
		if status == Status::TIMESTAMP
			status = Status::TEXT
		end
		if status == Status::INDEX
			status = Status::TIMESTAMP
		end
	end

	puts '  ' + dictionary.count.to_s
end

dictionary.sort!

file = File.open('dictionary.txt', 'w')

dictionary.each do |word|
	file.write(word)
	file.write("\n")
end
