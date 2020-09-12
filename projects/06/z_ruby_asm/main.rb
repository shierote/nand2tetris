require './Parser'
require './Code'
require './SymbolTable'

parser = Parser.new(ARGV[0])
puts "=" * 30
puts parser.lineList
puts "=" * 30


while parser.hasMoreCommands?
  if (parser.commandType == "L_COMMAND")
    puts parser.symbol
  end

  parser.advance
end

puts "=" * 30

parser.currentLineNum = 0

outputFilePath = "./out/#{File.basename(ARGV[0], ".asm")}.hack"
File.open(outputFilePath, "w") do |f|
  while parser.hasMoreCommands?
    puts "#{parser.commandType} #{parser.currentLine}"

    if (parser.commandType == "C_COMMAND")
      puts "  dest: #{parser.dest}"
      puts "  comp: #{parser.comp}"
      puts "  jump: #{parser.jump}"
      binaryLine = "111#{Code.comp(parser.comp)}#{Code.dest(parser.dest)}#{Code.jump(parser.jump)}"
      puts binaryLine
      f.puts binaryLine
    elsif (parser.commandType == "A_COMMAND")
      if Parser.isNumber?(parser.symbol)
        binaryLine = "0#{("%015b" % parser.symbol)}"
        puts binaryLine
        f.puts binaryLine
      else
      end
    end

    parser.advance
  end
end
