class SymbolTable
  attr_accessor  :table

  def initialize()
    @table = {
      "SP" => 0,
      "LCL" => 1,
      "ARG" => 2,
      "THIS" => 3,
      "THAT" => 4,
      "SCREEN" => 16384,
      "KBD" => 24576
    }
    16.times do |t|
      @table["R#{t}"] = t
    end
  end

  def addEntry(symbol, address)
    table[symbol] = address
  end

  def contains?(symbol)
    table.has_key?(symbol)
  end

  def getAddress(symbol)
    table[symbol]
  end
end
