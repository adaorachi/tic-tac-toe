class Player 
    attr_accessor :marker
    attr_reader :name
    def initialize(name)
      @name = name
      @marker = ''
    end
  
    def random_player(*args)
      args.shuffle
    end
  end