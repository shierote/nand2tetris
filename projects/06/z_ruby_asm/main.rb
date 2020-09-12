require './Parser'
require './Code'
require './SymbolTable'

parser = Parser.new(ARGV[0])
symbolTable = SymbolTable.new()
puts "=" * 30
puts parser.lineList
puts "=" * 30


romAddress = 0
while parser.hasMoreCommands?
  if (parser.commandType == "L_COMMAND")
    symbolTable.addEntry(parser.symbol,romAddress)
  elsif (parser.commandType == "A_COMMAND" || parser.commandType == "C_COMMAND")
    romAddress += 1
  end

  parser.advance
end

symbolTable.table.each do |symbol, address|
  puts "#{symbol}: #{address}"
end
puts "=" * 30

parser.currentLineNum = 0
ramAddressVal = 16

outputFilePath = "./out/#{File.basename(ARGV[0], ".asm")}.hack"
File.open(outputFilePath, "w") do |f|
  while parser.hasMoreCommands?
    puts "#{parser.commandType} #{parser.currentLine}"

    if (parser.commandType == "C_COMMAND")
      puts "  dest: #{parser.dest}"
      puts "  comp: #{parser.comp}"
      puts "  jump: #{parser.jump}"
      binaryLine = "111#{Code.comp(parser.comp)}#{Code.dest(parser.dest)}#{Code.jump(parser.jump)}"
      puts "  #{binaryLine}"
      f.puts binaryLine
    elsif (parser.commandType == "A_COMMAND")
      if Parser.isNumber?(parser.symbol)
        aValue = parser.symbol
      else
        if symbolTable.contains?(parser.symbol)
          aValue = symbolTable.getAddress(parser.symbol)
        else
          symbolTable.addEntry(parser.symbol, ramAddressVal)
          aValue = symbolTable.getAddress(parser.symbol)
          ramAddressVal += 1
        end
      end
      binaryLine = "0#{("%015b" % aValue)}"
      puts "  #{binaryLine}"
      f.puts binaryLine
    end

    parser.advance
  end
end
