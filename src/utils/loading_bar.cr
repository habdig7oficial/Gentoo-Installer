require "ncurses"

require "../utils/long_reader"
require "../utils/await_clear"

module NCurses
	def progress_print(line : Int8, interval : Time::Span = 0.1.seconds)
		win = Window.new(height - line, width, line, 0)

		while true
			win.print "/"
			
			await_clear interval, win: win
			
			win.print "-"

			await_clear interval, win: win

			win.print "|"

			await_clear interval, win: win

			win.print "\\"

			await_clear interval, win: win

			win.print "|"

			await_clear interval, win: win
		end

	end
end

