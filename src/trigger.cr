require "ncurses"

## Configurações básicas
require "./config/colors"

## Utilidades Globais
require "./utils/menu"
require "./utils/long_reader"
require "./utils/await_clear"

## Modulos para cada etapa 

require "./steps/network"

module NCurses
	start()

	configure_colors()
	
	## Ativa o Keypad 

	keypad true

	## Desativa o print do cursor na tela
	set_cursor Cursor::Invisible	


	uid = LibC.getuid #Process.run("whoami", [], output: IO::Memory.new)

	if uid != 0 
		print "Nível de Pemissão Atual (#{uid}) Insuficiênte. Por Favor rode o programa novamento como "
		set_color 5
		print "ROOT"
		set_color 1
		refresh 
		await_clear()
		NCurses.end
		Process.exit()
	end

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



