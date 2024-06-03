require "ncurses"

module NCurses
	## Leitor de Buffers Grandes

        def long_reader(text : Array(String))
                i = 0
                while true
                        j = 0
                        erase()
                        set_color 1
                        while j < height - 2 # 1 linha reservada pra mensagem
                                
                                print "#{text[j + i]}\n"
                                j += 1
                        end
                        
                        set_color 3
                        print "Aperte <Esc> para sair\n"
                        #
                        refresh()
                        
                        key = get_char()
                        if key == Key::Esc
                                break
                        elsif key == Key::Up && i > 0 
                                i -= 1
                        elsif key == Key::Down && i <= text.size - height + 1  # 1 linha reservada
                                i += 1 
                        elsif key == Key::PageUp
                                i -= height - 2
                        elsif key == Key::PageDown
                                i += height - 2
                        
                        elsif key == Key::Up && i == 0 
                                i = text.size - height + 2
                        elsif key == Key::Down && i > text.size - height + 1 # 1 linha reservada
                                i = 0
                        end


                end
        end

end
