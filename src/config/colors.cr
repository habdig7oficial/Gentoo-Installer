require "ncurses"

module NCurses
        ## Configura as cores
        def configure_colors
                unless has_colors?()
                        print "Seu console não suporta cores\n"
                        await_clear() 
			NCurses.end
			Process.exit()
                end

                start_color()

	        unless can_change_color?()
                        print "Mudança de Cores não suportada!\n"
                        await_clear()
                end

		## New Colors
		lime = 10
		init_color lime, 0, 255 ,0

		print "#{has_colors?}" 


                ## Configurar os tipos de Cores
                init_color_pair(1, Color::White, Color::Black)
                init_color_pair(2, Color::Black, Color::White)
                init_color_pair(3, Color::Cyan, Color::Black)
                init_color_pair(4, Color::Magenta, Color::Black)
                init_color_pair(5, Color::Red, Color::Black)
		#init_color_pair(6, lime, Color::Black)	
		#init_color_pair(7, 10, 10)
		print "#{typeof(LibNCurses::Color)}" 
		refresh 
		get_char

                
        end

end
