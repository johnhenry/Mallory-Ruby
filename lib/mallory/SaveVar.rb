class SaveVar
	def self.LocalHash(names,binding,dumped=nil)
		has = Hash.new()
		names.each do|name| 
			has[name] = binding.eval(name.to_s) if (name != :_)
			has.delete(name) if has[name] == nil;
		end
		has.delete(dumped.to_sym) if dumped !=nil
		return has
	end
	def self.DumpString(names,binding,dumped=nil)
		Marshal.dump self.LocalHash names, binding, dumped
	end
	def self.DumpFile(filename,names,binding)
		fil = File.new(filename,"w")
		fil.write(DumpString(names,binding))
		fil.close
	end
	def self.UnDumpString(source,binding)
		has = Marshal.load(source)
			has.each do|name,value| 
				binding.eval(name.to_s+"="+value.to_s)
			end
		return nil
	end
	def self.UnDumpFile(filename,binding)
		fil = File.open(filename)
		source = ""
		fil.each {|line| source << line }
		UnDumpString(source,binding)
	end
end