#!/usr/bin/ruby
#
# subtle.rb
# 22/01/2016
# Massimiliano Bigatti (@mbigatti)
#
# Analyze a subtitle .srt file to find words not present in dictionary,
# then traslates them using Google Translate API.
#

require 'google/apis/translate_v2'
translate = Google::Apis::TranslateV2::TranslateService.new
translate.key = File.read('api.key')

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
File.readlines('dictionary.txt').each do |line|
	dictionary << line.strip
end

puts 'Dictionary contains ' + dictionary.count.to_s + ' words';

filename = ARGV[0]
status = Status::INDEX
word_list = []

puts 'Reading subtitles file ' + filename

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
						if !word_list.include?(word)
							word_list << word
						end
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

word_list.sort!

if word_list.count != 0
	puts '  subtitles contains ' + word_list.count.to_s + ' unknown words'	
	puts '  translating...'
	
	translations_file = File.open(filename + ".translations.txt", 'w')
	dictionary_file = File.open(filename + ".dictionary.txt", 'w')
	
	counter = 0
	
	word_list.each do |word|
		perc = counter * 100 / word_list.count
		
		if perc % 10 == 0
			puts perc.to_s + '%'
		end
		
		dictionary_file.write(word + "\n")
		
		result = translate.list_translations(word, 'it', source: 'en')
		translated = result.translations.first.translated_text
		
		if translated != nil && translated.length != 0
			translated.downcase!
			
			if translated != word
				translations_file.write(word + ' => ' + translated + "\n")
			end
		end
		
		counter = counter + 1
	end
end
