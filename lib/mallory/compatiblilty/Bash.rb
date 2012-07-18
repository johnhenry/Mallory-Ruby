def ls(pattern="*", cols=3)
	if cols < 2
		puts Dir.glob(pattern)
		return nil
	end

	length = Dir.glob(pattern).map{|value| value.length+1}.max
	str = ""
	i = 0
	Dir.glob(pattern).each do |f|
		str += sprintf("%-#{length}s", f)
		i += 1
		i %= cols
		str += "\n" if i == 0
	end
	puts str
	nil
end




def lsl(pattern="*",attributes={
"File Name"=>lambda{|f| File.basename(f)},
"Access Time"=>lambda{|f| File.atime(f).to_s},
"Mod Time"=>lambda{|f| File.mtime(f).to_s},
"Change Time"=>lambda{|f| File.ctime(f).to_s},
"Size"=>lambda{|f| File.size(f).to_s+" bytes"},
"Type"=>lambda{|f| File.ftype(f).to_s},
"Mode"=>lambda{|f|
	num = "---";
	num[2] = "x" if File.executable?(f)
	num[1] = "w" if File.writable?(f)
	num[0] = "r" if File.readable?(f)
	num
},
}
)

# attributes["Absolute Path"] = lambda{|f| File.absolute_path(f)}

# attributes["Octal Umask"] = lambda{|f|
	# num = 0;
	# num |= 1 if File.executable?(f)
	# num |= 2 if File.writable?(f)
	# num |= 4 if File.readable?(f)
	# num.to_s(8)
# }


	lengths = Hash.new
	attributes.each_key do |key|
		lengths[key] = key.length
	end

	Dir.glob(pattern).each do |f|
		attributes.each_pair do |key,value|
			lengths[key] = [lengths[key], value.call(f).length+1].max
		end
	end

	files = Array.new;
	header = ""
	attributes.each_pair do |key,value|
		header += sprintf("%-#{lengths[key]}s", key);
	end
	files.push header

	sep = ""
	attributes.each_key do |key|
		sep += sprintf("%-#{lengths[key]}s", "-"*key.length)
	end
	files.push sep

	Dir.glob(pattern).each do |f|
		str = ""
		attributes.each_pair do |key,value|
			str += sprintf("%-#{lengths[key]}s", value.call(f));
		end
		files.push str
	end
	puts files
	nil
end
#
def list 
	puts $binding.eval("puts local_variables.map{|var| var.to_s}")
end

def chmod permissions, *files
	files.each {|file| File.chmod(permissions, file)}
end

def rm(*files)
	files.each {|file| File.delete(file)}
end

def mkdir(directory)
	Dir.mkdir(directory)
end

def rmdir(*directories)
	directories.each {|directory| Dir.rmdir(directory)}
end



def pwd
	puts Dir.pwd
end

alias getwd pwd

def cd dir="~"
	Dir.chdir(dir)
	nil
end

def clear
  system('cls')
end

def touch(file_name)
	if !File.exists?(file_name)
		f = File.new(file_name,"w")
		f.close
		return f
	end
	nil
end

def cat(file_name)
	File.open(file_name).each {|line| puts line}
	nil
end

def read_file(file_name)
	File.open(file_name, "rb").read
end

class Object
	def write_to(file_name)
		f = File.new(file_name,"w")
		f.write(self.to_s)
		f.close
		f
	end
end

class String
	def write_from(target_object)
		f = File.new(self,"w")
		f.write(target_object.to_s)
		f.close
		f
	end
end

puts "Now with more Bash!"
