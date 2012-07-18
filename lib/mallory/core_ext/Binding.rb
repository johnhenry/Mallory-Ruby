class Binding
	public :local_variables
	def to_h
		hash = Hash.new
		local_variables.each do |var|
			hash[var] = eval(var.to_s) if(var != :_ && var != :hash)
		end
		return hash
	end
	def from_h hash
		hash.each_key do |key,value|
			self.eval("#{key.to_s}=#{value.to_s}") if key != :_
		end
		nil
	end
end

#locals = Hash.new; binding.local_variables.each {|var| locals[var] = binding.eval(var.to_s) if (var !=:_ && var !=:locals)}