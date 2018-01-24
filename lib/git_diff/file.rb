    attr_reader :a_path, :a_blob, :b_path, :b_blob, :b_mode, :hunks, :binary
      if path_info = /^diff --git(?: a\/(\S+))?(?: b\/(\S+))?/.match(string)
        File.new(
          a_path: path_info.captures[0] || '/dev/null',
          b_path: path_info.captures[1] || '/dev/null'
        )
    def initialize(a_path: '/dev/null', b_path: '/dev/null')
      @a_path = a_path
      @b_path = b_path
      @binary = false
      when mode_info = /^(old|new) mode ([0-9]{6})$/.match(string)
        if mode_info.captures[0] == "old"
          @a_mode = mode_info.captures[1]
        else
          @b_mode = mode_info.captures[1]
        end
      when rename_info = /^rename (from|to) (.*)$/.match(string)
        if rename_info.captures[0] == "from"
          @a_path = rename_info.captures[1]
        else
          @b_path = rename_info.captures[1]
        end
      when binary_info = /^Binary files (?:\/dev\/null|a\/(.*)) and (?:\/dev\/null|b\/(.*)) differ$/.match(string)
        @binary = true
        @a_path ||= binary_info[1] || "/dev/null"
        @b_path ||= binary_info[2] || "/dev/null"
      when /^similarity/.match(string)
        # trash
        true