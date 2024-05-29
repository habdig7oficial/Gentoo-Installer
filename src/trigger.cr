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

	def select_menu(text : String, options : Array(String), current_row : Int8 = 0_i8) : Int8

        build_select_menu(text, options, current_row)
        while true
                key = get_char()

                if key == Key::Up && current_row > 0
                        current_row -= 1_i8
                elsif key == Key::Down && current_row < options.size - 1
                        current_row += 1_i8

		elsif key.to_s == "\n"
			#print "\n\nOpção Selecionada: #{options[current_row]}"
			await_clear(0.seconds)
			break;
			#return current_row

                elsif key == Key::Up && current_row == 0
                        current_row = (options.size() - 1).to_i8 
                elsif key == Key::Down && current_row == options.size - 1
                        current_row = 0_i8
                end
	
                build_select_menu(text, options, current_row)

        end

	return current_row

	end

	def build_select_menu(text : String, options : Array(String), row_id : Int8)
		erase()
		set_color 0
		print "#{text}\n\n"

		options.each_with_index do | text, i |
			
			if i.to_i8 == row_id
				set_color 2
			else
				set_color 1
			end

			print "-> #{text}\n"
		end
	end


	###

	set_color 1 

	opt = select_menu("Bem-Vindo", ["Instalar", "Sair", "Ver Licença"])

	case opt
	when 0 
		print "comecando"
	when 1 
		NCurses.end()
		Process.exit()
	when 2
		set_color 1
		scrollok()

		license = File.read("./COPYING.txt")

		print license
		refresh()

		while true 
			if get_char() == Key::Esc 
				Process.restart()
			end
		end
	end
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



