current_key = nil
current_key_values=[]
ARGF.each do |line|

   # remove any newline
   line = line.chomp

   # split key and value on tab character
   (key, value) = line.split(/\t/)
   if current_key.nil?
     current_key=key
   end
   if current_key==key
     current_key_values<<value
   else
     if current_key_values.include?("Comedy") and  current_key_values.include?("Romance")
       puts current_key + "\t" + current_key_values.to_s
     end
     current_key=key
     current_key_values=[value]
   end
end