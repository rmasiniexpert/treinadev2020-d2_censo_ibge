require './lib/censo'
class CensoRuby
  censo = Censo.new
  censo.messages.welcome
  censo.messages.select_consult
end