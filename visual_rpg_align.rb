class VisualRpgAlign
  TYPES = ["begclass", "begsr", "if", "select", "dowhile"]
  CLOSING = ["endclass", "endsr", "endif", "endsl", "enddo"]
  def self.process(file_name)
    indent_type = nil
    indent_count = 0
    File.open("#{file_name}.out", 'w') do |f|
      File.open(file_name) do |file|
        file.each do |line|
          line.gsub!(/\t/, '  ')  # Tabs are converted to 2 spaces. Yeah, they are embedded everywhere.
          else_tag = line.strip.downcase == 'else' ? 1 : 0
          indent_count-=1  if CLOSING.map { |t| line.downcase.include?(t) }.any?  unless line.strip.slice(0,2) == "//"
          if indent_count > 0
            f.puts "#{ '  ' * (indent_count - else_tag) }#{ line.strip }"
          else
            f.puts line
          end
          indent_count+=1  if TYPES.map { |t| line.downcase.include?(t) && !(line.downcase.include?("endif")) }.any?  unless line.strip.slice(0,2) == "//"
        end
      end
    end
  end
end

VisualRpgAlign.process("Default.aspx.vr")
puts "Done"
