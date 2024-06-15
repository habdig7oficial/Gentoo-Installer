require "ncurses"

require "../utils/long_reader"
require "../utils/await_clear"

module NCurses
	def progress_print()
		win = Window.new()

		win.print "hello "
		win.refresh

	end
end

