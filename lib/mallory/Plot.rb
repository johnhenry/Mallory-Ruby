class Plot
	
	@matrix
	@draw_char
	attr_accessor :current_x
	attr_accessor :current_y
	attr_accessor :auto_show

	def initialize(width,height,blank_char=" ",draw_char=".",auto_show=false)
		@matrix = Array.Make_Matrix(width,height,blank_char)
		@draw_char = draw_char
		@auto_show = auto_show
		self.move_to!()
		return
	end

	def width
		return @matrix.width
	end

	def height 
		return @matrix.height 
	end

	def move_to!(x=0,y=0)
		@current_x = x
		@current_y = y
		return
	end
	
	def line_to!(x=0,y=0,draw_char=@draw_char)
		h_distance = x - current_x
		v_distance = y - current_y
		steps = [h_distance.abs,v_distance.abs].max
		if steps == h_distance.abs
			if h_distance > 0 
				if v_distance > 0
						incriment = v_distance.to_f/steps
						0.upto(h_distance) do |step| #h >0,#v>0
							self.plot!(current_x+step,current_y+incriment*step,draw_char)#Tested,Works
						end
				else
						incriment = v_distance.to_f/steps
						0.upto(h_distance) do |step| # h>0,v<0
							self.plot!(current_x+step,current_y+incriment*step,draw_char)#Tested,Fixed
						end
				end
			else
				if v_distance > 0
						incriment = v_distance.to_f/steps
						0.downto(h_distance) do |step| # h<0,#v>0
							self.plot!(current_x+step,current_y+incriment*-step,draw_char)#Tested,Works
						end
				else
						incriment = v_distance.to_f/steps
						0.downto(h_distance) do |step| # h<0, v<0
							self.plot!(current_x+step,current_y+incriment*-step,draw_char)#Tested,Fixed
						end
				end
			end
		else
			if v_distance >0 
				if h_distance > 0
						incriment = h_distance.to_f/steps
						0.upto(v_distance) do |step| # v>0,h>0 
							self.plot!(current_x+incriment*step,current_y+step,draw_char)#Tested,Works
				 		end	
				else
						incriment = h_distance.to_f/steps
							0.upto(v_distance) do |step| # v>0,h<0 
							self.plot!(current_x+incriment*step,current_y+step,draw_char)#Tested,Fixed
						end
				end
			else
				if h_distance > 0
						incriment = h_distance.to_f/steps
						0.downto(v_distance) do |step| # v<0, h>0
							self.plot!(current_x+incriment*-step,current_y+step,draw_char)#Tested,Works
						end
				else
						incriment = h_distance.to_f/steps
							0.downto(v_distance) do |step| # v<0,h<0
							self.plot!(current_x+incriment*-step,current_y+step,draw_char)#Tested,Fixed
						end
				end
			end
		end
		self.move_to(x,y)
		self.show if @auto_show
		return
	end

	def draw_circle!(x=0,y=0,r=1,draw_char=@draw_char)
		self.move_to(x,y)
	 0.upto(100) {|index| self.plot!((r*(Math.cos(3.14159*2*index.to_f/100))+@current_x),(r*(Math.sin(3.14159*2*index.to_f/100))+@current_y),draw_char)}
		self.show if @auto_show
		return
	end

	def draw_rectangle!(x,y,w,h,draw_char=@draw_char)
		self.move_to!(x,y)
		self.line_to!(x+w-1,y,draw_char)
		self.line_to!(x+w-1,y+h-1,draw_char)
		self.line_to!(x,y+h-1,draw_char)
		self.line_to!(x,y,draw_char)
		self.show if @auto_show
		return
	end

	def plot!(draw_char = @draw_char, x = current_x, y = current_y, move = false)
		x = x.round%width
		y = y.round%height
		@matrix[y][x] = draw_char.to_s.split("")[0]
		self.show if @auto_show
		self.move_to!(x,y) if move
		return
	end

	def plot_string!(string = "", orientation = :right, move = false, x = current_x, y = current_y)
		last_x = x;
		last_y = y;

		pause_auto_show = @auto_show
		@auto_show = false;
		case orientation
			when :up
				0.upto(string.length-1) do |index| 
					last_y = y-index;
					self.plot!(string.split("")[index],x,last_y)
				end 
			when :down
				0.upto(string.length-1) do |index| 
					last_y = y+index;
					self.plot!(string.split("")[index],x,last_y)
				end 
			when :left
				0.upto(string.length-1) do |index| 
					last_x = x-index;
					self.plot!(string.split("")[index],last_x,y)
				end
			else
				0.upto(string.length-1) do |index| 
					last_x = x+index;
					self.plot!(string.split("")[index],last_x,y)
				end
			end
		@auto_show = pause_auto_show
		self.show if @auto_show
		self.move_to!(last_x,last_y) if move;
		return
	end

	def auto_show_toggle!()
		@auto_show = !@auto_show
		return @auto_show
	end
	
	def clear!(blank_char=" ")
		@matrix = Array.Make_Matrix(width,height,blank_char)
		self.show if @auto_show	
		return
	end
	
	def show
		@matrix.each {|row| puts row.join("")}
		return
	end
	
	alias inspect show
end
