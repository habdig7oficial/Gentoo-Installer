require "ncurses"

module NCurses
	## Leitor de Buffers Grandes

        def long_reader(text : Array(String), console : Bool = false) : String | Void 
                i = 0

		buffer = Array(String).new

                while true
                        j = 0
                        erase()
                        set_color 1

                        while j < height - 2 # 1 linha reservada pra mensagem
                                
                                print "#{text[j + i]}\n"
                                j += 1
                        end
                       	 
			unless console
                        	set_color 3
                        	print "Aperte <Esc> para sair\n"
                        	#
                        	refresh()

			else
				set_cursor Cursor::Visible
				set_color 6
				print "console>> "
				set_color 1
				print buffer.join
			end
                        
                        key = get_char()
			if (key == Key::Esc && console == false) || (key.to_s == "\n" && console == true) 
				erase()
				set_cursor Cursor::Invisible
				refresh
				return buffer.join
                        elsif key == Key::Up && i > 0 
                                i -= 1
                        elsif key == Key::Down && i <= text.size - height + 1  # 1 linha reservada
                                i += 1 
                        elsif key == Key::PageUp
                                i -= height - 2
                        elsif key == Key::PageDown
                                i += height - 2
			
			## Pula pro início ou fim 
                        elsif key == Key::Up && i == 0 
                                i = text.size - height + 2
                        elsif key == Key::Down && i > text.size - height + 1 # 1 linha reservada
                                i = 0
			

			elsif key == Key::Backspace && buffer.size > 0
				buffer.pop
			else
				buffer << key.to_s
			end

                end
        end

end
