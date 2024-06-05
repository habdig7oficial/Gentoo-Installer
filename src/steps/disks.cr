require "ncurses"

require "../utils/long_reader"
require "../utils/menu"
require "../utils/await_clear"

module NCurses 
	def disks()

		print "Etapa Atual: Preparando os discos\n\n"

		print "Escolha o modo de particionamento\n\n"

		choice = select_menu(4, ["Guiado", "Manual"], 0)
		
		case choice 
		when 0

			config = Hash(String, String).new

			stdout = IO::Memory.new
                	Process.run("parted", ["--script", "-l"], output: stdout)         
			dev = long_reader("#{stdout.to_s}Digite o nome do Disco desejado no formato /dev/sdX".split("\n"), console: true).strip
			
			if File.exists?(dev) && dev.match(/\/dev\/(.*)/) 
				print "Dispositivo Flash Selecionado"
			elsif Dir.exists?(dev) && dev.match(/\/cdrom(.*)/) 
				print "Disco Selecionado"
			else
				print "O disco escolhido não existe"

				await_clear 4.seconds
				disks()
			end
			await_clear 2.seconds
			config["target"] = dev

			stdout.clear
                        Process.run("parted", ["--script", dev, "-l"], output: stdout)
                        long_reader("#{stdout.to_s}".split("\n"), console: true).strip

			
			refresh
		when 1

		end
	end
end
