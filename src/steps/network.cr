require "ncurses"
require "http/client"

require "../utils/await_clear"
require "../utils/menu"

module NCurses 

	include HTTP

	def network()
		if Client.get("https://www.gentoo.org/").success?
			print "Internet Funcionando! Pulando para a próxima Etapa"
			refresh()
			select_menu(3, ["Ok"],0)
			return
		end
	end
end
