require "ncurses"

## Modulos para cada etapa 

require "./steps/network"

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
		init_color_pair(4, Color::Magenta, Color::Black)

		unless can_change_color?()
			print "Mudança de Cores não suportada!\n"
			await_clear()
		end
	end

	configure_colors()
	
	## Ativa o Keypad 

	keypad true

	## Desativa o print do cursor na tela
	set_cursor Cursor::Invisible
	


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

	## Menu de Selecionamento

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


	txt = Array(String).new
	set_color 1 
	print "Bem-Vindo ao Meu Instalador do Gentoo GNU/Linux\n\n"
	set_color 3
	print "Copyright © 2024 Mateus Felipe da Silveira Vieira\n\n" 
	set_color 1
	print "Este Software é distribuido na licença GNU Affero General Public License (AGPL) versão 3 ou em qualquer versão posterior\n\n"
	print("
    _-`````-,           ,- '- .
  .'   .- - |          | - -.  `.
 /.'  /                     `.   \\
:/   :      _...   ..._      ``   :
::   :     /._ .`:'_.._\.    ||   :
::    `._ ./  ,`  :    \ . _.''   .
`:.      /   |  -.  \-. \\_      /
  \:._ _/  .'   .@)  \@) ` `\ ,.'
     _/,--'       .- .\,-.`--`.
       ,'/''     (( \ `  )    
        /'/'  \    `-'  (      
         '/''  `._,-----'
          ''/'    .,---'
           ''/'      ;:
             ''/''  ''/
               ''/''/''
                 '/'/'
                  `;

ASCII GNU art
Copyright © 2003 Vijay Kumar
(This work is available under the GNU General Public License, version 2 or any later version, or the GNU Free Documentation License, version 1.1 or any later version.)
Este trabalho está disponível sob a licença GNU General Public License (GPL), versão 2 ou qualquer versão posterior ou na GNU Free Documentation License, versão 1.1 ou qualquer versão posterior
       ")
	set_color 4
	print "\nFree as in Freedom!"
	set_color 1
	refresh
	opt = select_menu((height - 4).to_i8, ["Instalar", "Sair", "Ver Licença"], 1_i8)

	case opt
	when 0 
		network()
	when 1 
		NCurses.end()
		Process.exit()
	when 2
		set_color 1

		license = File.read_lines("./COPYING.txt")
		
		long_reader license
	end
	refresh()

	await_clear()
	
	NCurses.end
end



