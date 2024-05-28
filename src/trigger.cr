require "ncurses"



module NCurses
	start()
	
	def await_clear(time = 5.seconds)
		refresh()
		sleep time
		erase()
		refresh()
	end

	def configure_colors
		unless has_colors?()
			print "Seu console não suporta cores\n"
			await_clear()		
		end

		start_color()
		
		## Configurar os tipos de Cores
		init_color_pair(1, Color::Cyan, Color::Black)

		unless can_change_color?()
			print "Mudança de Cores não suportada!\n"
			await_clear()
		end
	end

	configure_colors()

	set_color 1 
	print "Hello"
	refresh()

	await_clear()
	
	NCurses.end
end


#NCurses.start

#if NCurses.has_colors?
#	NCurses.print "Seu console não suporta cores\n"
#	NCurses.refresh
#	sleep 5.seconds
#	NCurses.erase

#end



