require "ncurses"

require "../utils/long_reader"
require "../utils/menu"
require "../utils/await_clear"
require "../utils/unit_conversion.cr"

module NCurses

	def ram() : Int32
		proc = File.read_lines("/proc/meminfo") 

		value : (String | Nil) = ""
		proc.each do | text |
			if text.match(/MemTotal:(.*)/)
				value = text.match(/[0-9]+/).try &.[0]
				break
			end
		end
		if value != nil || Int32 == value.to_s.to_i
			return value.to_s.to_i
		else
			raise "No value found"
			return 0 
		end
	end

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

			total_ram : Int32 = ram
			default_ram : (Int32 | Nil)

			if total_ram <= 2097152 ## 2 Gb
				default_ram = 2 * total_ram
			elsif total_ram > 2097152 && total_ram <= 8388608 ## 8 Gb
				default_ram = total_ram
			elsif total_ram > 8388608
				default_ram = 8388608 
			end
			
			if default_ram.nil?
				0 
			else 
				default_ram
			end

			print stdout.to_s

			print "Escolha o amazenamento utilizado para Swap\n\nO recomendado é "

			print "#{kb_to_gb default_ram} Gb ou #{default_ram.to_s} Kb"

			refresh
			get_char

                        #long_reader("#{stdout.to_s}".split("\n"), console: true).strip

			
			refresh
		when 1

		end
	end
end
