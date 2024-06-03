require "ncurses"
require "http/client"

require "../utils/await_clear"


module NCurses 

	include HTTP

	def network()
		if Client.get("https://www.gentoo.org/").success?
			print "Internet Funcionando! Pulando para a próxima Etapa"
			refresh()
			await_clear()
			return
		end
	end
end
