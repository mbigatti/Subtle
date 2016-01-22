#!/usr/bin/ruby

counter=0
filename=ARGV[0]

#puts 'Processing ' + filename

module Status
	INDEX = 1
	TIMESTAMP = 2
	TEXT = 3
	EMPTY = 4
end

status = Status::INDEX

File.readlines(filename).each do |line|
	if status == Status::EMPTY
		status = Status::INDEX
	end
	if status == Status::TEXT
		if line.strip.length == 0
			status = Status::EMPTY
		else
			puts line
		end
	end
	if status == Status::TIMESTAMP
		status = Status::TEXT
	end
	if status == Status::INDEX
		status = Status::TIMESTAMP
		puts ''
	end
end