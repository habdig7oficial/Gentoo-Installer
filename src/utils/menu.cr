require "ncurses"

module NCurses
	
        def select_menu(line : Int8, options : Array(String), current_row : Int8 = 0_i8) : Int8
        
                win = Window.new(height - line, width, line, 0)
        
        while true
                build_select_menu(win, options, current_row)
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

                elsif key = Key::Resize 
                        refresh
                end
        end

        return current_row

        end

        def build_select_menu(win : Window, options : Array(String), row_id : Int8)     
                win.erase 

                options.each_with_index do | text, i |
                
                        if i.to_i8 == row_id
                                win.set_color 2
                        else
                                win.set_color 1
                        end
                        
                        win.print "-> #{text}\n"                
                end
                win.refresh
                
        end
end


