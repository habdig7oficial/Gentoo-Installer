require "ncurses"



module NCurses
	start()
	
	## Limpa a tela
	def await_clear(time = 5.seconds)
		refresh()
		sleep time
		erase()
		refresh()
	end

	## Configura as cores
	def configure_colors
		unless has_colors?()
			print "Seu console não suporta cores\n"
			await_clear()		
		end

		start_color()
		
		## Configurar os tipos de Cores
		init_color_pair(1, Color::White, Color::Black)
		init_color_pair(2, Color::Black, Color::White)
		init_color_pair(3, Color::Cyan, Color::Black)
		
		unless can_change_color?()
			print "Mudança de Cores não suportada!\n"
			await_clear()
		end
	end

	configure_colors()
	
	## Ativa o Keypad 

	keypad true

	## Menu de Selecionamento 

	def select_menu(text : String, options : Array(String), row_id : Int8)
		erase()
		set_color 0
		print "#{text}\n\n"

		options.each_with_index do | text, i |
			
			if i.to_i8 == row_id
				set_color 2
			else
				set_color 1
			end

			print "#{i}) #{text}\n"
		end
	end


	###

	set_color 1 
	print "Bem Vindo"
	refresh()

	current_row = 0_i8
	op = ["Hello", "World"]

	select_menu("Bla", op, current_row) 
	while true
		key = get_char()

		if key == Key::Up && current_row > 0
			current_row -= 1_i8
		elsif key == Key::Down && current_row < op.size - 1
			current_row += 1_i8
		end

		select_menu("Bla", op, current_row) 

	end

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



