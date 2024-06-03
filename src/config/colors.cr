require "ncurses"

module NCurses
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
                init_color_pair(4, Color::Magenta, Color::Black)
                init_color_pair(5, Color::Red, Color::Black)

                unless can_change_color?()
                        print "Mudança de Cores não suportada!\n"
                        await_clear()
                end
        end

end
