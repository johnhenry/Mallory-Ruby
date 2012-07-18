class Mallory
	#Sets Compatibility Mode
	def self.Compatibility(*args)
		if args.include? :r
			Dir["compability/R.rb"].each {|file| load file }
			name = "R"
		end

		if args.include? :matlab
			Dir["compability/Matlab.rb"].each {|file| load file }
		end

		if args.include? :bash
			Dir["compability/Bash.rb"].each {|file| load file }
		end
	end
end