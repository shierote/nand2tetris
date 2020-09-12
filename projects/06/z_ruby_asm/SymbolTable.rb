class SymbolTable
  attr_accessor :table

  def initialize()
    @table = {}
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
