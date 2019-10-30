class Cell
    attr_accessor :position
    attr_reader :id
    attr_accessor :marker
  
    def initialize(id=nil, position=nil)
      @id = id
      @marker = nil
      @position = position
    end
  
    def content
      @marker != nil ? @marker : @id
    end
  end