require "ncurses"


module NCurses

	## Limpa a tela
        def await_clear(time = 5.seconds)
                refresh()
                sleep time
                erase()
                refresh()
        end
end
