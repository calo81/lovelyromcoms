# encoding: utf-8
ARGF.each do |line|
   line = line.encode("UTF-8",ndef: :replace, replace: "??")
   begin
     parts = line.split("\t")
     puts parts[0]+"\t"+ parts[parts.size-1]
   rescue
     puts 'error'
   end
end