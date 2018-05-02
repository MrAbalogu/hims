require 'rubyXL'
getcell = RubyXL::Parser.parse("druglist.xlsx")
print getcell[0][5][1].value