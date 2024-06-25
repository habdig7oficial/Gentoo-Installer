require "ncurses"


module NCurses

	## Limpa a tela
        def await_clear(time = 5.seconds, win : Window = stdscr)
		win.refresh()
                sleep time
		win.erase()
		win.refresh()
        end
end
