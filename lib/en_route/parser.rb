module EnRoute
  class Parser
    include Tokens
    attr_accessor :ilevel, :istack, :data, :src_dir

    def initialize
      self.ilevel = 0
      self.data = []
      self.src_dir = nil
    end

    def parse file_name
      self.ilevel = 0
      self.src_dir = File.dirname(file_name)
      exec = false
      exec_i = 0
      f = File.open file_name, 'r'
      f.lines do |line|
        exec = exec && add_ruby_code?(exec_i,line)
        unless exec
          if    line =~ Regexp.new(NAMESPACE);   dump f, line, $1, [:namespace,{:name => $2}]
          elsif line =~ Regexp.new(MATCH);       dump f, line, $1, [:match,{:as => $3, :to => $4, :path => $5, :via => $2, :params => $6 }]
          elsif line =~ Regexp.new(RESOURCES);   dump f, line, $1, [:resources,{:name => $2}]
          elsif line =~ Regexp.new(RESOURCE);    dump f, line, $1, [:resource,{:name => $2}]
          elsif line =~ Regexp.new(COLLECTION);  dump f, line, $1, [:collection]
          elsif line =~ Regexp.new(MEMBER);      dump f, line, $1, [:member]
          elsif line =~ Regexp.new(POST);        dump f, line, $1, [:post,{:name => $2}]
          elsif line =~ Regexp.new(ROOT);        dump f, line, '', [:root,{:to => $1}]
          elsif line =~ Regexp.new(GET);         dump f, line, $1, [:get,{:name => $2}]
          elsif line =~ Regexp.new(INCLUDE);     include_script $1, $2
          elsif line =~ Regexp.new(BLANK);       #self.data << [:blank]
          elsif line =~ Regexp.new(RUBY);        exec = true; exec_i = $1.to_s.size
          else;                                  error 'token not found', f, line
          end
        end
      end
      indenting
      f.close
      self.data
    end

    def add_ruby_code? exec_i, line
      i = line.match(/^\s*/).to_s.size
      if i <= exec_i
       false
      else
        self.data << [:ruby,line.sub(/^\s\s/,'')]
        true
      end
    end

    def include_script tab, name
      tab = tab.to_s.size
      error('indenting must be 2 spaces:',f,line) if tab % 2 != 0
      indenting tab
      ilevel = self.ilevel
      parse File.join(self.src_dir, "#{name}.rr")
      self.ilevel = ilevel
    end

    def indenting tab=0
      if tab - self.ilevel == 2
        self.data << [:indent]
        self.ilevel = tab
      elsif tab < self.ilevel
        (1..((self.ilevel-tab)/2)).each do
          self.data << [:dedent]
        end
        self.ilevel = tab
      end
    end

    def dump(f,line,tab,item=nil)
      tab = tab.to_s.size
      error('indenting must be 2 spaces:',f,line) if tab % 2 != 0
      indenting tab
      self.data << item if item
    end

    def error(message,f,line)
      raise "routie: #{message} #{f.inspect} on line\n\t#{f.lineno}: #{line}\n #{self.inspect}"
    end
  end
end
