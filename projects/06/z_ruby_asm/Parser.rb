class Parser
  attr_accessor :currentLineNum, :lineList

  def initialize(fileName)
    @currentLineNum = 0
    @lineList = []

    File.open(fileName) do |f|
      f.each_line do |line|
        targetLine = format(line)
        if (targetLine && targetLine != "")
          @lineList.push(targetLine)
        end
      end
    end
  end

  def currentLine
    @lineList[@currentLineNum]
  end

  def hasMoreCommands?
    @lineList.size > @currentLineNum
  end

  def advance # hasMoreCommandsがTrueの前提
    @currentLineNum+=1
    currentLine
  end

  def commandType
    firstChar = currentLine[0]
    case firstChar
    when "@"
      "A_COMMAND"
    when "("
      "L_COMMAND"
    else
      "C_COMMAND"
    end
  end

  def symbol
    case commandType
    when "L_COMMAND"
      currentLine.gsub("(","").gsub(")","")
    else
      currentLine.gsub("@","")
    end
  end

  def dest
    mnemonic = currentLine.split("=")[0] if !currentLine.include?(";")
    return "null" if mnemonic == nil || mnemonic == ""
    return mnemonic
  end

  def comp
    mnemonic = currentLine.split("=")[1]
    mnemonic = currentLine.split(";")[0] if !mnemonic
    return mnemonic
  end

  def jump
    mnemonic = currentLine.split(";")[1]
    return "null" if mnemonic == nil || mnemonic == ""
    mnemonic
  end

  def format(line)
    resultLine = line.chomp
    resultLine = resultLine.gsub(" ", "")
    resultLine = resultLine.split("//")[0]
    return resultLine
  end

  def self.isNumber?(symbol)
    nil != (symbol =~ /\A[0-9]+\z/)
  end
end
