class VisualRpgAlign
  TYPES = ["begclass", "begsr", "if", "select", "dowhile"]
  CLOSING = ["endclass", "endsr", "endif", "endsl", "enddo"]
  def self.process(file_name)
    indent_type = nil
    indent_count = 0
    block_parm = false
    File.open("#{file_name}.out", 'w') do |f|
      File.open(file_name) do |file|
        file.each do |line|
          line.gsub!(/\t/, '  ')  # Tabs are converted to 2 spaces. Yeah, they are embedded everywhere.
          recompense = line.strip.downcase == 'else' ? -1 : 0
          recompense = 1 if (line.downcase.include?("dclkfld") || line.downcase.include?("dclparm"))
          recompense = 1  if block_parm
          indent_count-=1  if CLOSING.map { |t| line.downcase.include?(t) }.any?  unless line.strip.slice(0,2) == "//"
          if line.strip == ""
            f.puts line.strip
          elsif indent_count > 0
            f.puts "#{ '  ' * (indent_count + recompense) }#{ line.strip }"
          else
            f.puts line.strip
          end
          indent_count+=1  if TYPES.map { |t| line.downcase.include?(t) && !(line.downcase.include?("endif")) }.any?  unless line.strip.slice(0,2) == "//"
          block_parm = true  if line.downcase.include?("dcldiskfile")
          block_parm = false  if (line.strip == "" || line.strip.nil?)
        end
      end
    end
  end
end

VisualRpgAlign.process("report.aspx.vr")
puts "Done"
